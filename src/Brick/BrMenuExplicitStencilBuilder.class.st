Class {
	#name : #BrMenuExplicitStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'menuModel'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - instantiation' }
BrMenuExplicitStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	^ BlElement new
		size: 10 @ 10;
		background: Color veryLightGray
]

{ #category : #accessing }
BrMenuExplicitStencilBuilder >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrMenuExplicitStencilBuilder >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #'api - instantiation' }
BrMenuExplicitStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor push: menuModel 
]

{ #category : #initialization }
BrMenuExplicitStencilBuilder >> reset [
	super reset.
	menuModel := nil
]
