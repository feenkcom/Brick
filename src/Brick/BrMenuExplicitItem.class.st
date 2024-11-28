Class {
	#name : #BrMenuExplicitItem,
	#superclass : #BrMenuItem,
	#instVars : [
		'stencil'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #accessing }
BrMenuExplicitItem >> stencil [
	^ stencil
]

{ #category : #accessing }
BrMenuExplicitItem >> stencil: anObject [
	stencil := anObject
]
