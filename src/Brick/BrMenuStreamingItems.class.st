"
I am a menu with streaming items. In other words, I get {{gtClass:BrMenuItem}} instances from a {{gtClass:TAsyncStream | label=stream}}. 
# Example
{{gtExample:BrMenuExamples>>#menuStreamingItems | codeExpanded=false | previewExpanded=true | previewHeight=500}}
"
Class {
	#name : #BrMenuStreamingItems,
	#superclass : #BrMenu,
	#instVars : [
		'stream',
		'selectedItem'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenuStreamingItems >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuStreamingItems: self
]

{ #category : #'api - selection' }
BrMenuStreamingItems >> deselect [
	selectedItem ifNotNil: #deselect.
	selectedItem := nil
]

{ #category : #'api - selection' }
BrMenuStreamingItems >> deselectedItem: aMenuItem [
	self assert: [ aMenuItem isSelected not ].
	selectedItem == aMenuItem ifFalse: [ ^ self ].

	selectedItem := nil
]

{ #category : #initialization }
BrMenuStreamingItems >> initialize [
	super initialize.
	stream := AsyncEmptyStream new
]

{ #category : #initialization }
BrMenuStreamingItems >> initializeMenuItem: aMenuItem [
	aMenuItem parent: self
]

{ #category : #'api - notifying' }
BrMenuStreamingItems >> notifyMenuItem: aMenuItem selectionChanged: isMenuItemSelected [
	super notifyMenuItem: aMenuItem selectionChanged: isMenuItemSelected.

	isMenuItemSelected
		ifTrue: [ self selectedItem: aMenuItem ]
		ifFalse: [ self deselectedItem: aMenuItem ]
]

{ #category : #'api - selection' }
BrMenuStreamingItems >> selectedItem [
	^ selectedItem
]

{ #category : #'api - selection' }
BrMenuStreamingItems >> selectedItem: aMenuItem [
	self assert: [ aMenuItem isSelected ].
	selectedItem == aMenuItem ifTrue: [ ^ self ].

	selectedItem ifNotNil: #deselect.
	selectedItem := aMenuItem
]

{ #category : #accessing }
BrMenuStreamingItems >> stream [
	<return: #TAsyncStream or: #BrMenuItem>
	^ stream asyncSimilarCopy
]

{ #category : #accessing }
BrMenuStreamingItems >> stream: anAsyncStream [
	"Set a stream of BrMenuItem instances."

	stream := (anAsyncStream asAsyncStream
			map: [ :eachMenuItem | 
				self initializeMenuItem: eachMenuItem.
				eachMenuItem ]) cached.
	selectedItem := nil.

	self announcer announce: (BrMenuItemsChangedAnnouncement new menuModel: self)
]

{ #category : #'api - updating' }
BrMenuStreamingItems >> updateSimpleListElementItems: aSimpleListElement [
	aSimpleListElement stream: self stream
]
