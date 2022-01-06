Class {
	#name : #BrFromFuture,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'future',
		'futureExecution',
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

	"the future is running"
	futureExecution
		ifNotNil: [ ^ self ].

	element
		ifNil: [
			element := elementStencil asElement ].

	self privateUpdateElement.

	futureExecution := future await.
	futureExecution
		then: [ :aResult | self privateDataSnapshot: (BrFromFutureDataSnapshot new setData: aResult) ]
		otherwise: [ :anError |
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
BrFromFuture >> stencil: aStencil [
	elementStencil := aStencil asStencil
]
