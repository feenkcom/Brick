Class {
	#name : 'BrTextEditorStyledTextMemento',
	#superclass : 'BrTextEditorMemento',
	#instVars : [
		'text',
		'styler'
	],
	#category : 'Brick-Editor-Model - Memento'
}

{ #category : 'initialization' }
BrTextEditorStyledTextMemento >> initialize [
	super initialize.
	
	text := '' asRopedText
]

{ #category : 'testing' }
BrTextEditorStyledTextMemento >> isTextMemento [
	^ true
]

{ #category : 'evaluating' }
BrTextEditorStyledTextMemento >> label [
	^ 'Styled Text'
]

{ #category : 'accessing' }
BrTextEditorStyledTextMemento >> order [
	^ 60
]

{ #category : 'memento' }
BrTextEditorStyledTextMemento >> restoreStateOf: aTextEditor [
	aTextEditor
		disableStyleTextWhenModifiedDuring: [
			aTextEditor styler: self styler.
			aTextEditor restoreText: text copy ]
]

{ #category : 'memento' }
BrTextEditorStyledTextMemento >> saveStateOf: aTextEditor [
	text := aTextEditor text copy.
	styler := aTextEditor styler
]

{ #category : 'accessing' }
BrTextEditorStyledTextMemento >> styler [
	^ styler
]

{ #category : 'accessing' }
BrTextEditorStyledTextMemento >> styler: anObject [
	styler := anObject
]

{ #category : 'accessing' }
BrTextEditorStyledTextMemento >> text [
	^ text
]

{ #category : 'accessing' }
BrTextEditorStyledTextMemento >> text: anObject [
	text := anObject
]

{ #category : 'evaluating' }
BrTextEditorStyledTextMemento >> value [
	^ text copyWithoutExternalReferences
]
