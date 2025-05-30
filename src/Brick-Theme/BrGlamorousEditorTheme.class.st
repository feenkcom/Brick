Class {
	#name : #BrGlamorousEditorTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'borderColor',
		'focusedBorderColor',
		'defaultTextForeground',
		'pharoDeclaredVariableForeground',
		'pharoUndeclaredVariableForeground',
		'pharoSelfVariableForeground',
		'pharoSuperVariableForeground',
		'pharoThisContextVariableForeground'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousEditorTheme >> borderColor [
	^ borderColor
]

{ #category : #accessing }
BrGlamorousEditorTheme >> borderColor: anObject [
	borderColor := anObject
]

{ #category : #'as yet unclassified' }
BrGlamorousEditorTheme >> defaultTextForeground [
	^ defaultTextForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> focusedBorderColor [
	^ focusedBorderColor
]

{ #category : #accessing }
BrGlamorousEditorTheme >> focusedBorderColor: anObject [
	focusedBorderColor := anObject
]

{ #category : #initialization }
BrGlamorousEditorTheme >> initialize [
	super initialize.
	borderColor := BrGlamorousColors editorBorderColor.
	focusedBorderColor := BrGlamorousColors focusedEditorBorderColor
]

{ #category : #'as yet unclassified' }
BrGlamorousEditorTheme >> initializeTheme [
	super initializeTheme.
	
	defaultTextForeground := self
		color: [ :aTheme | aTheme colors primaryTextColor ]
		source: [ :aTheme | aTheme editor defaultTextForeground ].

	pharoDeclaredVariableForeground := self
		color: [ :aTheme | aTheme colors pharoDeclaredVariableColor ]
		source: [ :aTheme | aTheme editor pharoDeclaredVariableForeground ].

	pharoUndeclaredVariableForeground := self
		color: [ :aTheme | aTheme colors pharoUndeclaredVariableColor ]
		source: [ :aTheme | aTheme editor pharoUndeclaredVariableForeground ].

	pharoSelfVariableForeground := self
		color: [ :aTheme | aTheme colors pharoSelfVariableColor ]
		source: [ :aTheme | aTheme editor pharoSelfVariableForeground ].

	pharoSuperVariableForeground := self
		color: [ :aTheme | aTheme colors pharoSuperVariableColor ]
		source: [ :aTheme | aTheme editor pharoSuperVariableForeground ].

	pharoThisContextVariableForeground := self
		color: [ :aTheme | aTheme colors pharoThisContextVariableColor ]
		source: [ :aTheme | aTheme editor pharoThisContextVariableForeground ].
]

{ #category : #'as yet unclassified' }
BrGlamorousEditorTheme >> pharoDeclaredVariableForeground [
	^ pharoDeclaredVariableForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoSelfVariableForeground [
	^ pharoSelfVariableForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoSuperVariableForeground [
	^ pharoSuperVariableForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoThisContextVariableForeground [
	^ pharoThisContextVariableForeground
]

{ #category : #'as yet unclassified' }
BrGlamorousEditorTheme >> pharoUndeclaredVariableForeground [
	^ pharoUndeclaredVariableForeground
]
