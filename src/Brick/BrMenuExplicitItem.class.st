Class {
	#name : #BrMenuExplicitItem,
	#superclass : #BrMenuItem,
	#instVars : [
		'stencil'
	],
	#category : #'Brick-Menu'
}

{ #category : #accessing }
BrMenuExplicitItem >> stencil [
	^ stencil
]

{ #category : #accessing }
BrMenuExplicitItem >> stencil: anObject [
	stencil := anObject
]
