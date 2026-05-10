Class {
	#name : #BrTextExpandButtonAttributeV2,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'isExpanded',
		'id',
		'definingMethod'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextExpandButtonAttributeV2 >> beExpandedByDefault [
	isExpanded := true
]

{ #category : #private }
BrTextExpandButtonAttributeV2 >> collapseAttributeIn: aTextEditor [
	isExpanded := false.
	aTextEditor removeAdornmentAttribute: self expandedAppendingAttribute
]

{ #category : #accessing }
BrTextExpandButtonAttributeV2 >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
BrTextExpandButtonAttributeV2 >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #private }
BrTextExpandButtonAttributeV2 >> expandAttributeIn: aTextEditor [
	isExpanded := true.
	aTextEditor
		addAppendingAttribute: self expandedAppendingAttribute
		atAppendingAttribute: self
]

{ #category : #private }
BrTextExpandButtonAttributeV2 >> expandedAppendingAttribute [
	^ self subclassResponsibility
]

{ #category : #accessing }
BrTextExpandButtonAttributeV2 >> id [
	<return: #BlElementId>
	
	^ id
]

{ #category : #accessing }
BrTextExpandButtonAttributeV2 >> id: anElementId [
	id := anElementId
]

{ #category : #initialization }
BrTextExpandButtonAttributeV2 >> initialize [
	super initialize.
	
	self beAppend.
	self placeholderAlignment: #alignMiddle.
	
	id := BlElementId noId.
	isExpanded := false.
]

{ #category : #accessing }
BrTextExpandButtonAttributeV2 >> isExpanded [
	^ isExpanded
]

{ #category : #private }
BrTextExpandButtonAttributeV2 >> toggleExpandedOrCollapsedIn: aTextEditor [
	self isExpanded
		ifTrue: [ self collapseAttributeIn: aTextEditor ]
		ifFalse: [ self expandAttributeIn: aTextEditor ]
]
