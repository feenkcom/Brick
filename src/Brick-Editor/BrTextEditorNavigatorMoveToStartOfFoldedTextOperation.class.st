Class {
	#name : #BrTextEditorNavigatorMoveToStartOfFoldedTextOperation,
	#superclass : #BrTextEditorNavigatorOperation,
	#category : #'Brick-Editor-Model - Operators'
}

{ #category : #'as yet unclassified' }
BrTextEditorNavigatorMoveToStartOfFoldedTextOperation >> performOn: aNavigator [
	aNavigator
		privateRegisterForMove: self cursor
		by: (aNavigator findFoldStartBefore: self cursor position) - self cursor position
]
