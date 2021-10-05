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
	elementStencil := [ BlElement new ] asStencil.
	elementDataBinder := BrFromFutureDataBinder new.
	updater := BrElementUpdater new.
	updater element: self selector: #privateUpdateElement.
]

{ #category : #'hooks - children' }
BrFromPromise >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	dataSnapshot isPending
		ifFalse: [ ^ self ].

	element
		ifNil: [ element := elementStencil asElement ].

	self privateUpdateElement.
	
	promise
		then: [ :aResult | self privateDataSnapshot: (BrFromFutureDataSnapshot new setData: aResult) ]
		otherwise: [ :anError | self privateDataSnapshot: (BrFromFutureDataSnapshot new setError: anError) ]
]

{ #category : #private }
BrFromPromise >> privateDataSnapshot: aDataSnapshot [
	dataSnapshot := aDataSnapshot.
	updater requestUpdate
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
	promise := aPromise asAsyncPromise.
	dataSnapshot := BrFromFutureDataSnapshot new setPending: anObject
]

{ #category : #'api - accessing' }
BrFromPromise >> stencil: aStencil [
	elementStencil := aStencil asStencil
]
