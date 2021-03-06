"
I defer the styling request until the corresponding editor element is added to the scene graph
"
Class {
	#name : #BrTextStylerDeferringTask,
	#superclass : #BlTask,
	#instVars : [
		'stylerAsyncStrategy',
		'textEditor',
		'textToStyle',
		'afterBlock'
	],
	#category : #'Brick-Editor-Styler'
}

{ #category : #accessing }
BrTextStylerDeferringTask >> afterBlock [
	^ afterBlock
]

{ #category : #accessing }
BrTextStylerDeferringTask >> afterBlock: anObject [
	afterBlock := anObject
]

{ #category : #'api - running' }
BrTextStylerDeferringTask >> run [
	self stylerAsyncStrategy critical: [
		(self textToStyle isNextGenerationOf: self textEditor textSnapshot)
			ifTrue: [ self stylerAsyncStrategy
				style: self textToStyle
				afterDo: self afterBlock ].
		self stylerAsyncStrategy isStylingRequested: false ]
]

{ #category : #accessing }
BrTextStylerDeferringTask >> stylerAsyncStrategy [
	^ stylerAsyncStrategy
]

{ #category : #accessing }
BrTextStylerDeferringTask >> stylerAsyncStrategy: anObject [
	stylerAsyncStrategy := anObject
]

{ #category : #accessing }
BrTextStylerDeferringTask >> textEditor [
	^ textEditor
]

{ #category : #accessing }
BrTextStylerDeferringTask >> textEditor: anObject [
	textEditor := anObject
]

{ #category : #accessing }
BrTextStylerDeferringTask >> textToStyle [
	^ textToStyle
]

{ #category : #accessing }
BrTextStylerDeferringTask >> textToStyle: anObject [
	textToStyle := anObject
]
