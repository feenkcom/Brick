Class {
	#name : #BrTextCursorStylableAttribute,
	#superclass : #BrTextCursorProtoAttribute,
	#instVars : [
		'attributes',
		'selectionTriggersCursorEnter',
		'shouldAddAttributeOnEnter',
		'selectionBehavior',
		'cursorEnterActions',
		'cursorLeaveActions'
	],
	#classVars : [
		'IgnoreSelection',
		'SelectionPreservesCursorEnter',
		'SelectionTriggersCursorEnter'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #'class initialization' }
BrTextCursorStylableAttribute class >> initialize [
	IgnoreSelection := #IgnoreSelection.
	SelectionPreservesCursorEnter := #SelectionPreservesCursorEnter.
	SelectionTriggersCursorEnter := #SelectionTriggersCursorEnter
]

{ #category : #'api - actions' }
BrTextCursorStylableAttribute >> addAttributeOverSelfOnLeave: anAttribute [
	cursorLeaveActions add: (BrTextAddAttributeOverSelfAction attribute: anAttribute)
]

{ #category : #'api - actions' }
BrTextCursorStylableAttribute >> addAttributeOverSelfOnLeave: anAttribute firstCharacters: aCharCount [
	cursorLeaveActions add: (BrTextAddAttributeOverSelfFirstCharsAction attribute: anAttribute firstCharacters: aCharCount)
]

{ #category : #'api - actions' }
BrTextCursorStylableAttribute >> addAttributeOverSelfOnLeave: anAttribute lastCharacters: aCharCount [
	cursorLeaveActions add: (BrTextAddAttributeOverSelfLastCharsAction attribute: anAttribute lastCharacters: aCharCount)
]

{ #category : #'api - selection' }
BrTextCursorStylableAttribute >> ignoreSelection [
	selectionBehavior := IgnoreSelection
]

{ #category : #initialization }
BrTextCursorStylableAttribute >> initialize [
	super initialize.

	selectionBehavior := IgnoreSelection.
	cursorEnterActions := OrderedCollection new.
	cursorLeaveActions := OrderedCollection new.
	
	
	
	enterAction := [ :aTextEditorModel :aTextElement :aStart :anEnd | 
		shouldAddAttributeOnEnter
			ifTrue: [ (aTextEditorModel text from: aStart to: anEnd) attributes: self attributes ]
			ifFalse: [ (aTextEditorModel text from: aStart to: anEnd)
					clearAttributes: [ :aTextAttribute | self attributes identityIncludes: aTextAttribute ] ] ].
	leaveAction := [ :aTextEditorModel :aTextElement :aStart :anEnd | 
		shouldAddAttributeOnEnter
			ifTrue: [ (aTextEditorModel text from: aStart to: anEnd)
					clearAttributes: [ :aTextAttribute | self attributes identityIncludes: aTextAttribute ] ]
			ifFalse: [ (aTextEditorModel text from: aStart to: anEnd)
					attributes: self attributes ] ]
]

{ #category : #'api - selection' }
BrTextCursorStylableAttribute >> preserveCursorEnterOnSelection [
	selectionBehavior := SelectionPreservesCursorEnter
]

{ #category : #'api - actions' }
BrTextCursorStylableAttribute >> removeAttributeOverSelfOnEnter: anAttribute [
	cursorEnterActions add: (BrTextRemoveAttributeOverSelfAction attribute: anAttribute)
]

{ #category : #'api - actions' }
BrTextCursorStylableAttribute >> removeAttributeOverSelfOnLeave: anAttribute [
	cursorLeaveActions add: (BrTextRemoveAttributeOverSelfAction attribute: anAttribute)
]

{ #category : #'api - selection' }
BrTextCursorStylableAttribute >> triggerCursorEnterOnSelection [
	selectionBehavior := SelectionTriggersCursorEnter
]
