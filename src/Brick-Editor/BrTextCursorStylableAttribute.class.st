Class {
	#name : #BrTextCursorStylableAttribute,
	#superclass : #BrTextCursorProtoAttribute,
	#instVars : [
		'selectionTriggersCursorEnter',
		'selectionBehavior',
		'cursorEnterActions',
		'cursorLeaveActions'
	],
	#classVars : [
		'IgnoreSelection',
		'SelectionPreservesCursorEnter',
		'SelectionTriggersCursorEnter'
	],
	#category : 'Brick-Editor-Attributes'
}

{ #category : #'class initialization' }
BrTextCursorStylableAttribute class >> initialize [
	IgnoreSelection := #IgnoreSelection.
	SelectionPreservesCursorEnter := #SelectionPreservesCursorEnter.
	SelectionTriggersCursorEnter := #SelectionTriggersCursorEnter
]

{ #category : #'api - actions' }
BrTextCursorStylableAttribute >> addAttributeOverSelfOnEnter: anAttribute [
	cursorEnterActions add: (BrTextAddAttributeOverSelfAction attribute: anAttribute)
]

{ #category : #'api - actions' }
BrTextCursorStylableAttribute >> addAttributeOverSelfOnEnterAndRemoveOnLeave: anAttribute [
	self
		addAttributeOverSelfOnEnter: anAttribute;
		removeAttributeOverSelfOnLeave: anAttribute
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
]

{ #category : #private }
BrTextCursorStylableAttribute >> performEnterAction: anEvent in: aTextEditor [
	| aStart anEnd |
	isInside = true
		ifTrue: [ ^ self ].

	isInside := true.
	aStart := anEvent attributeStart.
	anEnd := anEvent attributeEnd.
	
	cursorEnterActions do: [ :eachAction |
		eachAction performEnterAction: anEvent in: aTextEditor ].
]

{ #category : #private }
BrTextCursorStylableAttribute >> performLeaveAction: anEvent in: aTextEditor [
	| aStart anEnd |
	isInside = false
		ifTrue: [ ^ self ].

	isInside := false.
	aStart := anEvent attributeStart.
	anEnd := anEvent attributeEnd.
	
	cursorLeaveActions do: [ :eachAction |
		eachAction performLeaveAction: anEvent in: aTextEditor ].
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
