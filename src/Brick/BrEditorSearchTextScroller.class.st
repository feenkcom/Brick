Class {
	#name : #BrEditorSearchTextScroller,
	#superclass : #Object,
	#instVars : [
		'editorElement',
		'lineIndex',
		'characterStartPosition',
		'characterStopPosition',
		'smoothScrollThreshold'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextScroller >> characterStartPosition [
	^ characterStartPosition
]

{ #category : #accessing }
BrEditorSearchTextScroller >> characterStartPosition: anInteger [
	characterStartPosition := anInteger
]

{ #category : #accessing }
BrEditorSearchTextScroller >> characterStopPosition [
	^ characterStopPosition
]

{ #category : #accessing }
BrEditorSearchTextScroller >> characterStopPosition: anInteger [
	characterStopPosition := anInteger
]

{ #category : #accessing }
BrEditorSearchTextScroller >> editorElement [
	^ editorElement
]

{ #category : #accessing }
BrEditorSearchTextScroller >> editorElement: aBrEditor [
	editorElement := aBrEditor
]

{ #category : #initialization }
BrEditorSearchTextScroller >> initialize [
	super initialize.
	
	smoothScrollThreshold := 100
]

{ #category : #accessing }
BrEditorSearchTextScroller >> lineIndex [
	^ lineIndex
]

{ #category : #accessing }
BrEditorSearchTextScroller >> lineIndex: anInteger [
	lineIndex := anInteger
]

{ #category : #scrolling }
BrEditorSearchTextScroller >> scroll [
	| aFirstSegment aLastSegment aLineDistance |
	
	"Get range of visible lines and characters"
	aFirstSegment := (editorElement layout
			findFirstVisibleChildClosestToStartCompletelyVisible: true
			acceptPartiallyVisible: false) ifNotNil: #segment.
	aLastSegment := (editorElement layout
			findFirstVisibleChildClosestToEndCompletelyVisible: true
			acceptPartiallyVisible: false) ifNotNil: #segment.
			
	"Scroll only if the character is not visible"
	(aFirstSegment isNotNil
		and: [ aLastSegment isNotNil
				and: [ aFirstSegment textStart >= characterStartPosition
						and: [ aLastSegment textEnd <= characterStopPosition ] ] ]) ifTrue: [ ^ self ].	
						
	"Check the distance"
	(aFirstSegment isNotNil and: [ aLastSegment isNotNil ])
		ifTrue: [ aLineDistance := (aFirstSegment index - lineIndex) abs
					min: (aLastSegment index - lineIndex) abs ].
					
	"Scroll smoothly or jump to the position, depending on the distance."
	(aLineDistance isNotNil and: [ aLineDistance < smoothScrollThreshold ])
		ifTrue: [ editorElement smoothScrollToPosition: lineIndex ]
		ifFalse: [ editorElement scrollToPosition: lineIndex ]
]

{ #category : #accessing }
BrEditorSearchTextScroller >> smoothScrollThreshold [
	^ smoothScrollThreshold
]

{ #category : #accessing }
BrEditorSearchTextScroller >> smoothScrollThreshold: anObject [
	smoothScrollThreshold := anObject
]
