Class {
	#name : #BrEditorSearchTextStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'subtext',
		'substring',
		'currentItem',
		'visualizer',
		'currentCount',
		'currentRange'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextStyler >> currentCount [
	^ currentCount
]

{ #category : #'api - search' }
BrEditorSearchTextStyler >> currentItem [
	^ currentItem
]

{ #category : #private }
BrEditorSearchTextStyler >> currentItemAmong: anItemsCount [
	| aCurrentItem |
	anItemsCount isZero ifTrue: [ ^ 1 ].
	aCurrentItem := self currentItem.
	aCurrentItem isZero ifTrue: [ 
		currentItem := anItemsCount.
		^ anItemsCount ].

	aCurrentItem := aCurrentItem \\ anItemsCount.
	aCurrentItem isZero ifTrue: [ aCurrentItem := anItemsCount ].
	
	^ currentItem := aCurrentItem
]

{ #category : #accessing }
BrEditorSearchTextStyler >> currentRange [
	^ currentRange
]

{ #category : #accessing }
BrEditorSearchTextStyler >> editor: aBrEditor [
	visualizer := BrEditorSearchTextVisualizer forEditor: aBrEditor
]

{ #category : #private }
BrEditorSearchTextStyler >> extraStyle: aText ast: anAst [
	self privateStyle: aText
]

{ #category : #'api - search' }
BrEditorSearchTextStyler >> nextItem [
	currentItem := self currentItem + 1
]

{ #category : #'api - search' }
BrEditorSearchTextStyler >> previousItem [
	currentItem := self currentItem - 1
]

{ #category : #private }
BrEditorSearchTextStyler >> privateStyle: aText [
	| allIndexes aSubstring aCurrentItem |
	aSubstring := self substring ifNil: [ ^ aText ].

	allIndexes := aText finder
			caseInsensitiveSubstring: aSubstring;
			searchAll.

	currentCount := allIndexes size.
	aCurrentItem := self currentItemAmong: allIndexes size.

	allIndexes
		doWithIndex: [ :eachStartPosition :eachIndex | 
			| isCurrentItem endPosition |
			isCurrentItem := aCurrentItem = eachIndex.
			endPosition := eachStartPosition + aSubstring size - 1.
			isCurrentItem ifTrue: [ currentRange := eachStartPosition to: endPosition ].
			(aText from: eachStartPosition to: endPosition)
				highlight: (isCurrentItem
						ifTrue: [ BrGlamorousColors failureBackgroundColor ]
						ifFalse: [ BrGlamorousColors disabledButtonTextColor ]) ].

	self visualizer
		selectionContext: (BrEditorSearchTextVisualizerContext new
				pattern: aSubstring;
				allStartPositions: allIndexes;
				selectedItem: aCurrentItem;
				text: aText).

	^ aText
]

{ #category : #private }
BrEditorSearchTextStyler >> style: aText ast: anAst [
	
]

{ #category : #private }
BrEditorSearchTextStyler >> substring [
	^ self subtext ifNotNil: #asString
]

{ #category : #accessing }
BrEditorSearchTextStyler >> subtext [
	<return: #BlText or: nil>
	^ subtext
]

{ #category : #'api - search' }
BrEditorSearchTextStyler >> subtext: aBlText [
	subtext := aBlText.
	substring := nil.
	currentItem := 1.
	currentRange := nil.
	currentCount := nil.
]

{ #category : #accessing }
BrEditorSearchTextStyler >> visualizer [
	^ visualizer ifNil: [ visualizer := BrEditorSearchTextVisualizer null ]
]

{ #category : #accessing }
BrEditorSearchTextStyler >> visualizer: aVisualizer [
	visualizer := aVisualizer
]
