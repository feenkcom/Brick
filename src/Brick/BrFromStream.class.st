Class {
	#name : #BrFromStream,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'monitor',
		'updater',
		'sink',
		'collection',
		'recent',
		'future',
		'promise',
		'dataSnapshot',
		'elementStencil',
		'elementDataBinder',
		'element',
		'stream'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #adding }
BrFromStream >> add: anItem [
	monitor critical: [ 
		collection add: anItem.
		recent add: anItem.
		updater requestUpdate ]
]

{ #category : #'api - accessing' }
BrFromStream >> dataBinder: aFromFutureDataBinder [
	elementDataBinder := aFromFutureDataBinder asStencilBuilder: BrFromFutureDataBinder
]

{ #category : #initialization }
BrFromStream >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
BrFromStream >> initialize [
	super initialize.
	
	monitor := Monitor new.

	collection := OrderedCollection new.
	recent := OrderedCollection new.
	dataSnapshot := BrFromFutureDataSnapshot new setPending: (BrFromStreamData new allValues: collection; newValues: #()).
	
	updater := BrElementUpdater new.
	updater element: self selector: #privateUpdateElement
]

{ #category : #'hooks - children' }
BrFromStream >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	"self privateInitializeElement"
]

{ #category : #'private - update' }
BrFromStream >> privateDataSnapshot: aDataSnapshot [
	monitor critical: [
		dataSnapshot := aDataSnapshot.
		updater requestUpdate ]
]

{ #category : #'private - update' }
BrFromStream >> privateInitializeElement [
	| aPromise isProcessed |

	dataSnapshot isPending
		ifFalse: [ ^ self ].

	element
		ifNil: [ element := elementStencil asElement ].

	self privateUpdateElement.

	isProcessed := false.
	
	aPromise := promise := future asAsyncPromise.
	aPromise
		then: [ :aResult |
			isProcessed := true.
			promise == aPromise
				ifTrue: [
					| aFinalData |
					aFinalData := BrFromStreamData new
						allValues: collection;
						newValues: recent.
					recent := OrderedCollection new.
					self privateDataSnapshot: (BrFromFutureDataSnapshot new setData: aFinalData) ] ]
		otherwise: [ :anError |
			isProcessed := true.
			promise == aPromise
				ifTrue: [
					anError freeze.
					self privateDataSnapshot: (BrFromFutureDataSnapshot new setError: anError) ] ].
			
	isProcessed ifFalse: [
		"To let the space know that we are waiting for a promise to finish"
		self enqueueTask: (BlPromiseTask new promise: aPromise) ]
]

{ #category : #'private - update' }
BrFromStream >> privateUpdateElement [	
	monitor critical: [ [ 
		dataSnapshot isPending
			ifTrue: [
				dataSnapshot initialData newValues: recent.
				recent := OrderedCollection new ].
		elementDataBinder 
			element: element;
			data: dataSnapshot;
			build ] on: Error fork: [ :anException | anException pass ] ].

	(self hasChild: element)
		ifTrue: [ ^ self ].

	element removeFromParent.
	self addChild: element
]

{ #category : #'api - accessing' }
BrFromStream >> stencil: aStencil [
	elementStencil := aStencil asStencil
]

{ #category : #'api - accessing' }
BrFromStream >> stream: aStream [
	self stream: aStream sink: AsyncDrainSink new
]

{ #category : #'api - accessing' }
BrFromStream >> stream: aStream sink: aSink [
	stream ifNotNil: [ :aPreviousStream | aPreviousStream terminate ].

	collection := OrderedCollection new.
	recent := OrderedCollection new.
	sink := AsyncFanoutSink forSinkA: (AsyncCollectionSink forCollection: self) sinkB: aSink.
	stream := aStream terminatable.
	future := AsyncMaybeDoneFuture forFuture: ((sink sendAll: stream) then: [ sink close ]).
	dataSnapshot := BrFromFutureDataSnapshot new setPending: (BrFromStreamData new allValues: collection; newValues: #()).

	self privateInitializeElement
]
