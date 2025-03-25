Class {
	#name : #BrTextExpandButtonAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'isExpanded',
		'attributesCreatingBlock',
		'createdAttributes',
		'id',
		'definingMethod'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #private }
BrTextExpandButtonAttribute >> applyExpandedOrCollapsedAttributesOn: aTBrTextEditorTextualPiece in: aTextEditor [
	self applyExpandedOrCollapsedAttributesOnText: aTBrTextEditorTextualPiece text
]

{ #category : #private }
BrTextExpandButtonAttribute >> applyExpandedOrCollapsedAttributesOnText: aBrText [
	aBrText
		clearAttributes: [ :aTextAttribute | self createdAttributes includes: aTextAttribute ].

	isExpanded ifTrue: [ self createAttributesAffect: aBrText ]
]

{ #category : #accessing }
BrTextExpandButtonAttribute >> attributesCreatingBlock [
	^ attributesCreatingBlock
]

{ #category : #accessing }
BrTextExpandButtonAttribute >> attributesCreatingBlock: aBlock [
	attributesCreatingBlock := aBlock
]

{ #category : #private }
BrTextExpandButtonAttribute >> createAttributesAffect: aBrText [
	createdAttributes := attributesCreatingBlock value asOrderedCollection.
	aBrText attributes: createdAttributes
]

{ #category : #accessing }
BrTextExpandButtonAttribute >> createdAttributes [
	^ createdAttributes
]

{ #category : #accessing }
BrTextExpandButtonAttribute >> createdAttributes: aCollection [
	createdAttributes := aCollection
]

{ #category : #accessing }
BrTextExpandButtonAttribute >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
BrTextExpandButtonAttribute >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #accessing }
BrTextExpandButtonAttribute >> id [
	<return: #BlElementId>
	
	^ id
]

{ #category : #accessing }
BrTextExpandButtonAttribute >> id: anElementId [
	id := anElementId
]

{ #category : #initialization }
BrTextExpandButtonAttribute >> initialize [
	super initialize.
	
	self beAppend.
		self placeholderAlignment: #alignMiddle.
	id := BlElementId noId.
	attributesCreatingBlock := [ OrderedCollection new ].
	isExpanded := false.
	createdAttributes := OrderedCollection new
]

{ #category : #accessing }
BrTextExpandButtonAttribute >> isExpanded [
	^ isExpanded
]

{ #category : #accessing }
BrTextExpandButtonAttribute >> isExpanded: aBoolean [
	isExpanded := aBoolean
]

{ #category : #private }
BrTextExpandButtonAttribute >> toggleExpandedOrCollapsedAttributesOn: aTBrTextEditorTextualPiece [
	self isExpanded: isExpanded not.
	self applyExpandedOrCollapsedAttributesOnText: aTBrTextEditorTextualPiece text
]

{ #category : #private }
BrTextExpandButtonAttribute >> toggleExpandedOrCollapsedAttributesOn: aTBrTextEditorTextualPiece in: aTextEditor [
	self isExpanded: isExpanded not.
	self applyExpandedOrCollapsedAttributesOnText: aTBrTextEditorTextualPiece text
]
