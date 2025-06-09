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
		'pharoPragmaForeground',
		'pharoReturnArrowForeground',
		'pharoStringLiteralForeground',
		'pharoSymbolLiteralForeground',
		'pharoNumberLiteralForeground',
		'pharoNilLiteralForeground',
		'pharoBooleanLiteralForeground',
		'pharoCharacterLiteralForeground',
		'pharoCommentForeground',
		'pharoErrorTokenForeground'
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
			source: [ :aTheme | aTheme editor pharoThisContextVariableForeground ].

	pharoPragmaForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoPragmaForeground ]
			source: [ :aTheme | aTheme editor pharoPragmaForeground ].

	pharoReturnArrowForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoReturnArrowForeground ]
			source: [ :aTheme | aTheme editor pharoReturnArrowForeground ].

	pharoStringLiteralForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoStringLiteralForeground ]
			source: [ :aTheme | aTheme editor pharoStringLiteralForeground ].

	pharoSymbolLiteralForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoSymbolLiteralForeground ]
			source: [ :aTheme | aTheme editor pharoSymbolLiteralForeground ].

	pharoNumberLiteralForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoNumberLiteralForeground ]
			source: [ :aTheme | aTheme editor pharoNumberLiteralForeground ].

	pharoNilLiteralForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoNilLiteralForeground ]
			source: [ :aTheme | aTheme editor pharoNilLiteralForeground ].

	pharoBooleanLiteralForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoBooleanLiteralForeground ]
			source: [ :aTheme | aTheme editor pharoBooleanLiteralForeground ].

	pharoCharacterLiteralForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoCharacterLiteralForeground ]
			source: [ :aTheme | aTheme editor pharoCharacterLiteralForeground ].

	pharoCommentForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoCommentForeground ]
			source: [ :aTheme | aTheme editor pharoCommentForeground ].

	pharoErrorTokenForeground := self
			color: [ :aTheme | aTheme editor constantAt: #pharoErrorTokenForeground ]
			source: [ :aTheme | aTheme editor pharoErrorTokenForeground ]
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoBooleanLiteralForeground [
	^ pharoBooleanLiteralForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoCharacterLiteralForeground [
	^ pharoCharacterLiteralForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoCommentForeground [
	^ pharoCommentForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoDeclaredVariableForeground [
	^ pharoDeclaredVariableForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoErrorTokenForeground [
	^ pharoErrorTokenForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoNilLiteralForeground [
	^ pharoNilLiteralForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoNumberLiteralForeground [
	^ pharoNumberLiteralForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoPragmaForeground [
	^ pharoPragmaForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoReturnArrowForeground [
	^ pharoReturnArrowForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoSelfVariableForeground [
	^ pharoSelfVariableForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoStringLiteralForeground [
	^ pharoStringLiteralForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoSuperVariableForeground [
	^ pharoSuperVariableForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoSymbolLiteralForeground [
	^ pharoSymbolLiteralForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoThisContextVariableForeground [
	^ pharoThisContextVariableForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> pharoUndeclaredVariableForeground [
	^ pharoUndeclaredVariableForeground
]
