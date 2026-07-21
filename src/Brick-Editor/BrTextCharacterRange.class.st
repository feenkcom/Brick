Class {
	#name : #BrTextCharacterRange,
	#superclass : #BrTextRange,
	#category : 'Brick-Editor-Model'
}

{ #category : #testing }
BrTextCharacterRange >> isCharacterRange [
	^ true
]

{ #category : #printing }
BrTextCharacterRange >> typeName [
	^ 'Character'
]
