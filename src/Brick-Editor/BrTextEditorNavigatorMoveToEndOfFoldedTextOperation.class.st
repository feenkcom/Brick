Class {
	#name : #BrTextEditorNavigatorMoveToEndOfFoldedTextOperation,
	#superclass : #BrTextEditorNavigatorOperation,
	#category : #'Brick-Editor-Model - Operators'
}

{ #category : #'as yet unclassified' }
BrTextEditorNavigatorMoveToEndOfFoldedTextOperation >> performOn: aNavigator [
	aNavigator
		privateRegisterForMove: self cursor
		by: (aNavigator findFoldEndAfter: self cursor position) - self cursor position + 1
]
