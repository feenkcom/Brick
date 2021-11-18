Class {
	#name : #BrFromPromise,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'promise',
		'dataSnapshot',
		'elementStencil',
		'elementDataBinder',
		'element',
		'updater'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #'api - accessing' }
BrFromPromise >> dataBinder: aFromFutureDataBinder [
	elementDataBinder := aFromFutureDataBinder asStencilBuilder: BrFromFutureDataBinder
]

{ #category : #initialization }
BrFromPromise >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
BrFromPromise >> initialize [
	super initialize.
	
	dataSnapshot := BrFromFutureDataSnapshot new setPending: nil.
	elementStencil := nil.
	elementDataBinder := nil.
	updater := BrElementUpdater new.
	updater element: self selector: #privateUpdateElement.
]

{ #category : #private }
BrFromPromise >> privateDataSnapshot: aDataSnapshot synchronous: isSynchronous [
	dataSnapshot := aDataSnapshot.
	
	isSynchronous
		ifTrue: [ self privateUpdateElement ]
		ifFalse: [ updater requestUpdate ]
]

{ #category : #private }
BrFromPromise >> privateInitializeElement [
	| aPromise isProcessed |

	dataSnapshot isPending
		ifFalse: [ ^ self ].
	
	element
		ifNil: [ element := elementStencil asElement ].
	
	isProcessed := false.
	
	aPromise := promise.
	aPromise
		then: [ :aResult :isSynchronous |
			isProcessed := true.
			(promise == aPromise)
				ifTrue: [
					self
						privateDataSnapshot: (BrFromFutureDataSnapshot new setData: aResult)
						synchronous: isSynchronous ] ]
		otherwise: [ :anError |
			isProcessed := true.
			(promise == aPromise)
				ifTrue: [
					self
						privateDataSnapshot: (BrFromFutureDataSnapshot new setError: anError)
						synchronous: false ] ].
	
	isProcessed ifFalse: [ self privateUpdateElement ]
]

{ #category : #private }
BrFromPromise >> privateUpdateElement [
	"Must be called from the UI thread"

	elementDataBinder 
		element: element;
		data: dataSnapshot;
		build.
	
	(self hasChild: element)
		ifTrue: [ ^ self ].

	element removeFromParent.
	self addChild: element
]

{ #category : #'api - accessing' }
BrFromPromise >> promise: aPromise [
	self promise: aPromise initialValue: nil
]

{ #category : #'api - accessing' }
BrFromPromise >> promise: aPromise initialValue: anObject [
	self
		assert: [ elementStencil notNil ]
		description: [ 'Must configure element stencil before setting the promise' ].
		
	self
		assert: [ elementDataBinder notNil ]
		description: [ 'Must assign element data binder before setting the promise' ].

	promise := aPromise asAsyncPromise.
	dataSnapshot := BrFromFutureDataSnapshot new setPending: anObject.
	self privateInitializeElement
]

{ #category : #'api - accessing' }
BrFromPromise >> stencil: aStencil [
	elementStencil := aStencil asStencil
]
