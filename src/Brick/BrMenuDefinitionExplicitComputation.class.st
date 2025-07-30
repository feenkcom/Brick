Class {
	#name : #BrMenuDefinitionExplicitComputation,
	#superclass : #Object,
	#traits : 'TBrMenuDefinitionComputation',
	#classTraits : 'TBrMenuDefinitionComputation classTrait',
	#instVars : [
		'valuable'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #accessing }
BrMenuDefinitionExplicitComputation >> definition [
	"Return an object that explains how/where a menu model is computed"

	^ self valuable value
]

{ #category : #accessing }
BrMenuDefinitionExplicitComputation >> valuable [
	^ valuable
]

{ #category : #accessing }
BrMenuDefinitionExplicitComputation >> valuable: anObject [
	valuable := anObject
]
