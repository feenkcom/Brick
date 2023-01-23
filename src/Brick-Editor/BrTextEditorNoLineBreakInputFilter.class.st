Class {
	#name : #BrTextEditorNoLineBreakInputFilter,
	#superclass : #BrTextEditorInputFilter,
	#category : #'Brick-Editor-Model'
}

{ #category : #accessing }
BrTextEditorNoLineBreakInputFilter >> filter: aString [
	<return: #String>
	
	^ aString reject: #isLineBreak
]
