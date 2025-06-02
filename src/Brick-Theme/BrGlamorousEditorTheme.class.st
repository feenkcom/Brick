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
		'pharoThisContextVariableForeground',
		'someForeground'
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

{ #category : #initialization }
BrGlamorousEditorTheme >> initializeColors [
	super initializeColors.


]

{ #category : #initialization }
BrGlamorousEditorTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #pharoSelfVariableForeground put: (self theme colors pharoSelfVariableColor).

]

{ #category : #initialization }
BrGlamorousEditorTheme >> initializeThemeable [
	super initializeThemeable.

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
			color: [ :aTheme | aTheme editor constantAt: #pharoSelfVariableForeground ]
			source: [ :aTheme | aTheme editor pharoSelfVariableForeground ].

	pharoSuperVariableForeground := self
			color: [ :aTheme | aTheme colors pharoSuperVariableColor ]
			source: [ :aTheme | aTheme editor pharoSuperVariableForeground ].

	pharoThisContextVariableForeground := self
			color: [ :aTheme | aTheme colors pharoThisContextVariableColor ]
			source: [ :aTheme | aTheme editor pharoThisContextVariableForeground ]
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
