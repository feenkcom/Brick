Class {
	#name : #BrFromFuture,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'future',
		'dataSnapshot',
		'elementStencil',
		'elementDataBinder',
		'element',
		'updater'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #'api - accessing' }
BrFromFuture >> dataBinder: aFromFutureDataBinder [
	elementDataBinder := aFromFutureDataBinder asStencilBuilder: BrFromFutureDataBinder
]

{ #category : #initialization }
BrFromFuture >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'api - accessing' }
BrFromFuture >> future: aFuture [
	self future: aFuture initialValue: nil
]

{ #category : #'api - accessing' }
BrFromFuture >> future: aFuture initialValue: anObject [
	future := aFuture asAsyncFuture.
	dataSnapshot := BrFromFutureDataSnapshot new setPending: anObject
]

{ #category : #initialization }
BrFromFuture >> initialize [
	super initialize.
	
	dataSnapshot := BrFromFutureDataSnapshot new setPending: nil.
	elementStencil := [ BlElement new ] asStencil.
	elementDataBinder := BrFromFutureDataBinder new.
	updater := BrElementUpdater new.
	updater element: self selector: #privateUpdateElement.
]

{ #category : #'hooks - children' }
BrFromFuture >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	dataSnapshot isPending
		ifFalse: [ ^ self ].

	element
		ifNil: [
			element := elementStencil asElement ].

	self privateUpdateElement.

	future await
		onSuccessDo: [ :aResult | self privateDataSnapshot: (BrFromFutureDataSnapshot new setData: aResult) ];
		onFailureDo: [ :anError |
			anError freeze.
			self privateDataSnapshot: (BrFromFutureDataSnapshot new setError: anError) ]
]

{ #category : #private }
BrFromFuture >> privateDataSnapshot: aDataSnapshot [
	dataSnapshot := aDataSnapshot.
	updater requestUpdate
]

{ #category : #private }
BrFromFuture >> privateUpdateElement [
	"Must be called from the UI thread"
	| anEmbellishedElement aTargetElementToAdd |

	anEmbellishedElement := elementDataBinder 
		element: element;
		data: dataSnapshot;
		build.

	aTargetElementToAdd := (anEmbellishedElement isKindOf: BlElement)
		ifTrue: [ anEmbellishedElement == element
			ifTrue: [ element ]
			ifFalse: [ anEmbellishedElement ] ]
		ifFalse: [ element ].

	(self hasChild: aTargetElementToAdd)
		ifFalse: [
			self removeChildren.
			element removeFromParent.
			aTargetElementToAdd removeFromParent.
			self addChild: aTargetElementToAdd ].
]

{ #category : #'api - accessing' }
BrFromFuture >> stencil: aStencil [
	elementStencil := aStencil asStencil
]
