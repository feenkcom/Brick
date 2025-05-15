Class {
	#name : #BrEditorSearchTextExampleResult,
	#superclass : #Object,
	#instVars : [
		'marker',
		'context',
		'text',
		'selectedItem',
		'selectedIndex'
	],
	#category : #'Brick-Examples-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextExampleResult >> context [
	^ context
]

{ #category : #accessing }
BrEditorSearchTextExampleResult >> context: aContext [
	context := aContext.
	selectedItem := aContext selectedItem.
	selectedIndex := aContext selectedIndex.
]

{ #category : #'gt - extensions' }
BrEditorSearchTextExampleResult >> gtComputedPatternItemsFor: aView [
	<gtView>
	^ aView forward
		title: 'Computed pattern items';
		object: [ context ];
		view: #gtComputedPatternItemsFor:
]

{ #category : #'gt - extensions' }
BrEditorSearchTextExampleResult >> gtTextFor: aView [
	<gtView>
	^ aView forward
		priority: 10;
		title: 'Text';
		object: [ self text ];
		view: #gtTextFor:
]

{ #category : #accessing }
BrEditorSearchTextExampleResult >> marker [
	^ marker
]

{ #category : #accessing }
BrEditorSearchTextExampleResult >> marker: anObject [
	marker := anObject
]

{ #category : #accessing }
BrEditorSearchTextExampleResult >> selectedIndex [
	^ selectedIndex
]

{ #category : #accessing }
BrEditorSearchTextExampleResult >> selectedItem [
	^ selectedItem
]

{ #category : #accessing }
BrEditorSearchTextExampleResult >> text [
	^ text ifNil: [ context editorModelText ]
]

{ #category : #accessing }
BrEditorSearchTextExampleResult >> text: anObject [
	text := anObject
]
