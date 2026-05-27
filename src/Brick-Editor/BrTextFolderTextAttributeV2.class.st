Class {
	#name : #BrTextFolderTextAttributeV2,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'id',
		'definingMethod',
		'isFolded',
		'hideAttribute',
		'foldableMarkerAttribute'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #private }
BrTextFolderTextAttributeV2 >> applyFoldedOrUnfoledInEditorElement: aTextEditorElement [
	self isFolded
		ifTrue: [ self foldAttributeInTextEditorElement: aTextEditorElement ]
		ifFalse: [ self unfoldAttributeInTextEditorElement: aTextEditorElement ]
]

{ #category : #accessing }
BrTextFolderTextAttributeV2 >> beFoldedByDefault [
	isFolded := true
]

{ #category : #accessing }
BrTextFolderTextAttributeV2 >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
BrTextFolderTextAttributeV2 >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #private }
BrTextFolderTextAttributeV2 >> foldAttributeInTextEditorElement: aTextEditorElement [
	self foldableMarkerAttribute ifNil: [ ^ self ].

	isFolded := true.
	aTextEditorElement
		addAttribute: self hideReplacableAttribute
		overMarker: self foldableMarkerAttribute
]

{ #category : #accessing }
BrTextFolderTextAttributeV2 >> foldableMarkerAttribute [
	^ foldableMarkerAttribute
]

{ #category : #accessing }
BrTextFolderTextAttributeV2 >> foldableMarkerAttribute: aMarkerAttribute [
	"Set a marker that indicates foldable text part(s)."

	self
		assert: [ aMarkerAttribute isKindOf: BrTextInvisibleMarkerAttribute ]
		description: [ 'aMarkerAttribute must be a marker attribute: {1}' format: {aMarkerAttribute} ].

	foldableMarkerAttribute := aMarkerAttribute
]

{ #category : #accessing }
BrTextFolderTextAttributeV2 >> hideReplacableAttribute [
	^ hideAttribute
]

{ #category : #accessing }
BrTextFolderTextAttributeV2 >> id [
	<return: #BlElementId>
	
	^ id
]

{ #category : #accessing }
BrTextFolderTextAttributeV2 >> id: anElementId [
	id := anElementId asBlocElementId
]

{ #category : #initialization }
BrTextFolderTextAttributeV2 >> initialize [
	super initialize.
	
	self beAppend.
	self placeholderAlignment: #alignMiddle.
	
	id := BlElementId noId.
	isFolded := false.
	hideAttribute := BrTextFoldAttribute new.
	foldableMarkerAttribute := nil
]

{ #category : #accessing }
BrTextFolderTextAttributeV2 >> isFolded [
	^ isFolded
]

{ #category : #'api - styling' }
BrTextFolderTextAttributeV2 >> isFolded: aBoolean fromTextEditorElement: aTextEditorElement [
	self
		assert: [ aBoolean isBoolean ]
		description: [ 'The isFolded attribute must be a boolean value: {1}' format: {aBoolean} ].

	isFolded = aBoolean ifTrue: [ ^ self ].
		
	isFolded := aBoolean.
	self applyFoldedOrUnfoledInEditorElement: aTextEditorElement
]

{ #category : #private }
BrTextFolderTextAttributeV2 >> toggleFoldedOrUnfoledInEditorElement: aTextEditorElement [
	self isFolded
		ifTrue: [ self unfoldAttributeInTextEditorElement: aTextEditorElement ]
		ifFalse: [ self foldAttributeInTextEditorElement: aTextEditorElement ]
]

{ #category : #private }
BrTextFolderTextAttributeV2 >> unfoldAttributeInTextEditorElement: aTextEditorElement [
	self foldableMarkerAttribute ifNil: [ ^ self ].

	isFolded := false.
	aTextEditorElement removeAdornmentAttribute: self hideReplacableAttribute
]
