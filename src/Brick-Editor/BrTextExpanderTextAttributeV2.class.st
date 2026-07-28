Class {
	#name : #BrTextExpanderTextAttributeV2,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'isExpanded',
		'id',
		'definingMethod',
		'expandedAppendingAttribute',
		'stencil'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextExpanderTextAttributeV2 >> beExpandedByDefault [
	isExpanded := true
]

{ #category : #accessing }
BrTextExpanderTextAttributeV2 >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
BrTextExpanderTextAttributeV2 >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #private }
BrTextExpanderTextAttributeV2 >> expandedAppendingAttribute [
	^ self subclassResponsibility
]

{ #category : #accessing }
BrTextExpanderTextAttributeV2 >> id [
	<return: #BlElementId>
	
	^ id
]

{ #category : #accessing }
BrTextExpanderTextAttributeV2 >> id: anElementId [
	id := anElementId asBlocElementId
]

{ #category : #initialization }
BrTextExpanderTextAttributeV2 >> initialize [
	super initialize.
	
	self beAppend.
	self placeholderAlignment: #alignMiddle.
	
	id := BlElementId noId.
	isExpanded := false.
	
	expandedAppendingAttribute := BrTextAdornmentDynamicAttribute new
		beAppend;
		stencil: [ :aSegmentPiece :anEditor | stencil ].

	adornmentAction := BrTextAdornmentToggleAppendingAttributeAction new
		appendingAttribute: expandedAppendingAttribute.
]

{ #category : #accessing }
BrTextExpanderTextAttributeV2 >> isExpanded [
	^ isExpanded
]

{ #category : #private }
BrTextExpanderTextAttributeV2 >> toggleExpandedOrCollapsedIn: aTextEditor [
	aTextEditor executeAdornmentActionOfAdornmentAttribute: self.
	isExpanded := isExpanded not
]
