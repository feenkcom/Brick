Class {
	#name : #BrEditorTextFlowLayoutExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Layout'
}

{ #category : #'instance creation' }
BrEditorTextFlowLayoutExamples >> container [
	<gtExample>
	<return: #BlElement>
	| anElement |
	anElement := BlElement new
			layout: (BrEditorTextFlowLayout new lineSpacing: 10);
			constraintsDo: [ :c | 
				c horizontal exact: 500.
				c vertical fitContent ];
			addChildren: (20
					timesCollect: [ BlElement new
							size: 75 @ 30;
							margin: (BlInsets all: 4);
							background: (Color random alpha: 0.5) ]).

	^ anElement
]

{ #category : #'examples - layout' }
BrEditorTextFlowLayoutExamples >> container_extent [
	<gtExample>
	<return: #BlElement>
	| aContainer |
	aContainer := self container.
	aContainer forceLayout.

	self assert: aContainer extent equals: 500.0 @ 182.0.

	^ aContainer
]

{ #category : #'examples - layout' }
BrEditorTextFlowLayoutExamples >> layout_no_memory_leak [
	<gtExample>
	<return: #BlElement>
	| aContainer |
	aContainer := self container_extent.

	self assert: aContainer layout hasLines.
	self assert: aContainer layout hasElements.
	aContainer onRemovedFromSceneGraph.
	self assert: aContainer layout hasLines.
	self assert: aContainer layout hasElements not.

	^ aContainer
]
