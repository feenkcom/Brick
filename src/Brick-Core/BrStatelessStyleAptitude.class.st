Class {
	#name : #BrStatelessStyleAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'styles'
	],
	#category : #'Brick-Core-Core'
}

{ #category : #initialization }
BrStatelessStyleAptitude >> initialize [
	super initialize.

	styles := self statelessStyles
]

{ #category : #'api - hooks' }
BrStatelessStyleAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	anElement styles addStatelessStyles: styles
]

{ #category : #'api - hooks' }
BrStatelessStyleAptitude >> onUninstalledIn: anElement [
	super onUninstalledIn: anElement.
	
	anElement styles removeStatelessStyles: styles
]

{ #category : #initialization }
BrStatelessStyleAptitude >> statelessStyles [
	^ self subclassResponsibility
]
