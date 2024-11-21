Class {
	#name : #BrMenuTextLabelModel,
	#superclass : #Object,
	#instVars : [
		'text',
		'shortcut',
		'preview'
	],
	#category : #'Brick-Menu'
}

{ #category : #'gt - extensions' }
BrMenuTextLabelModel >> gtItemLabel [
	| aText |
	aText := self text asString asRopedText.
	
	self preview ifNotNil: [ :aString | 
		aText appendString: ' '.
		aText append: (aString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
	].
	
	self shortcut ifNotNil: [ :aString | 
		aText append: ((' [', aString, ']') asRopedText foreground: BrGlamorousColors defaultButtonTextColor)
	].
	
	^ aText
]

{ #category : #accessing }
BrMenuTextLabelModel >> preview [
	<return: #String>
	^ preview
]

{ #category : #accessing }
BrMenuTextLabelModel >> preview: aString [
	preview := aString
]

{ #category : #printing }
BrMenuTextLabelModel >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self text asString.
	self preview
		ifNotNil: [ :aString | 
			aStream
				space;
				nextPutAll: self preview asString ].
	self shortcut
		ifNotNil: [ :aString | 
			aStream
				nextPutAll: ' [';
				nextPutAll: self shortcut asString;
				nextPut: $] ].

	aStream nextPut: $)
]

{ #category : #accessing }
BrMenuTextLabelModel >> shortcut [
	<return: #String>
	^ shortcut
]

{ #category : #accessing }
BrMenuTextLabelModel >> shortcut: aString [
	shortcut := aString
]

{ #category : #accessing }
BrMenuTextLabelModel >> text [
	<return: #String>
	^ text
]

{ #category : #accessing }
BrMenuTextLabelModel >> text: aString [
	text := aString
]
