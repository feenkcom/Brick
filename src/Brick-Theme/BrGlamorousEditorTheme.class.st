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

{ #category : #accessing }
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
	super initializeColors
]

{ #category : #initialization }
BrGlamorousEditorTheme >> initializeConstants [
	super initializeConstants
]

{ #category : #initialization }
BrGlamorousEditorTheme >> initializeThemeable [
	super initializeThemeable.

	defaultTextForeground := self
			color: [ :aTheme | aTheme colors primaryTextColor ]
			source: [ :aTheme | aTheme editor defaultTextForeground ].

	pharoDeclaredVariableForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoDeclaredVariableForeground ]
			source: [ :aTheme | aTheme editor pharoDeclaredVariableForeground ].

	pharoUndeclaredVariableForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoUndeclaredVariableForeground ]
			source: [ :aTheme | aTheme editor pharoUndeclaredVariableForeground ].

	pharoSelfVariableForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoSelfVariableForeground ]
			source: [ :aTheme | aTheme editor pharoSelfVariableForeground ].

	pharoSuperVariableForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoSuperVariableForeground ]
			source: [ :aTheme | aTheme editor pharoSuperVariableForeground ].

	pharoThisContextVariableForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoThisContextVariableForeground ]
			source: [ :aTheme | aTheme editor pharoThisContextVariableForeground ]
]

{ #category : #accessing }
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

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoUndeclaredVariableForeground [
	^ pharoUndeclaredVariableForeground
]
