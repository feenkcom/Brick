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
		'pharoErrorTokenForeground',
		'enabledBreakpointForeground',
		'enabledBreakpointBackground',
		'disabledBreakpointBackground',
		'disabledBreakpointForeground',
		'completionPreviewBackground',
		'occurrenceHighlight'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousEditorTheme >> borderColor [
	^ borderColor
]

{ #category : #accessing }
BrGlamorousEditorTheme >> borderColor: aColor [
	self
		constantAt: #borderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousEditorTheme >> completionPreviewBackground [
	^ completionPreviewBackground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> defaultTextForeground [
	^ defaultTextForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> disabledBreakpointBackground [
	^ disabledBreakpointBackground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> disabledBreakpointForeground [
	^ disabledBreakpointForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> enabledBreakpointBackground [
	^ enabledBreakpointBackground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> enabledBreakpointForeground [
	^ enabledBreakpointForeground
]

{ #category : #accessing }
BrGlamorousEditorTheme >> focusedBorderColor [
	^ focusedBorderColor
]

{ #category : #accessing }
BrGlamorousEditorTheme >> focusedBorderColor: aColor [
	self
		constantAt: #focusedBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #initialization }
BrGlamorousEditorTheme >> initializeThemeable [
	super initializeThemeable.

	defaultTextForeground := self
			color: [ :aTheme | aTheme colors primaryTextColor ]
			source: [ :aTheme | aTheme editor defaultTextForeground ].

	occurrenceHighlight := self
			color: [ :aTheme | aTheme editor constantAt: #occurrenceHighlight ]
			source: [ :aTheme | aTheme editor occurrenceHighlight ].

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
			source: [ :aTheme | aTheme editor pharoErrorTokenForeground ].
	borderColor := self
			color: [ :aTheme | aTheme editor constantAt: #borderColor ]
			source: [ :aTheme | aTheme editor borderColor ].
	focusedBorderColor := self
			color: [ :aTheme | aTheme editor constantAt: #focusedBorderColor ]
			source: [ :aTheme | aTheme editor focusedBorderColor ].
	enabledBreakpointForeground := self
			color: [ :aTheme | aTheme editor constantAt: #enabledBreakpointForeground ]
			source: [ :aTheme | aTheme editor enabledBreakpointForeground ].
	enabledBreakpointBackground := self
			color: [ :aTheme | aTheme editor constantAt: #enabledBreakpointBackground ]
			source: [ :aTheme | aTheme editor enabledBreakpointBackground ].
	disabledBreakpointBackground := self
			color: [ :aTheme | aTheme editor constantAt: #disabledBreakpointBackground ]
			source: [ :aTheme | aTheme editor disabledBreakpointBackground ].
	disabledBreakpointForeground := self
			color: [ :aTheme | aTheme editor constantAt: #disabledBreakpointForeground ]
			source: [ :aTheme | aTheme editor disabledBreakpointForeground ].
	completionPreviewBackground := self
			color: [ :aTheme | aTheme editor constantAt: #completionPreviewBackground ]
			source: [ :aTheme | aTheme editor completionPreviewBackground ]
]

{ #category : #accessing }
BrGlamorousEditorTheme >> occurrenceHighlight [
	^ occurrenceHighlight
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
