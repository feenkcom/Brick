Class {
	#name : #BrTextExpanderTextAttributeV2,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'isExpanded',
		'id',
		'definingMethod'
	],
	#category : 'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextExpanderTextAttributeV2 >> beExpandedByDefault [
	isExpanded := true
]

{ #category : #private }
BrTextExpanderTextAttributeV2 >> collapseAttributeIn: aTextEditor [
	isExpanded := false.
	aTextEditor removeAdornmentAttribute: self expandedAppendingAttribute
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
BrTextExpanderTextAttributeV2 >> expandAttributeIn: aTextEditor [
	isExpanded := true.
	aTextEditor
		addAppendingAttribute: self expandedAppendingAttribute
		atAppendingAttribute: self
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
]

{ #category : #accessing }
BrTextExpanderTextAttributeV2 >> isExpanded [
	^ isExpanded
]

{ #category : #private }
BrTextExpanderTextAttributeV2 >> toggleExpandedOrCollapsedIn: aTextEditor [
	self isExpanded
		ifTrue: [ self collapseAttributeIn: aTextEditor ]
		ifFalse: [ self expandAttributeIn: aTextEditor ]
]
