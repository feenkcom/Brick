Class {
	#name : #BrMenuInitialStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'context'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - instantiation' }
BrMenuInitialStencilBuilder >> buildDefault [
	<return: #BrMenu or: nil>
	^ nil
]

{ #category : #accessing }
BrMenuInitialStencilBuilder >> context [
	<return: #BrMenuInitialContext>
	^ context
]

{ #category : #accessing }
BrMenuInitialStencilBuilder >> context: aMenuInitialContext [
	context := aMenuInitialContext
]

{ #category : #'api - instantiation' }
BrMenuInitialStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor push: context 
]

{ #category : #initialization }
BrMenuInitialStencilBuilder >> reset [
	super reset.
	context := nil
]
