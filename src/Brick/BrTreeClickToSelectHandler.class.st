Class {
	#name : #BrTreeClickToSelectHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'treeWidget'
	],
	#category : #'Brick-Tree - Support'
}

{ #category : #'api - accessing' }
BrTreeClickToSelectHandler >> clickEvent: aBlClickEvent [
	| clickedDataSourcePosition |

	clickedDataSourcePosition := aBlClickEvent currentTarget constraints infinite holder dataSourcePosition.
	clickedDataSourcePosition <= 0
		ifTrue: [ ^ self ].

	aBlClickEvent consumed: true.
	treeWidget requestFocus.
	treeWidget selectOne: clickedDataSourcePosition dueTo: aBlClickEvent
]

{ #category : #'api - accessing' }
BrTreeClickToSelectHandler >> doubleClickEvent: aBlDoubleClickEvent [
	aBlDoubleClickEvent consumed: true.

	treeWidget dispatchEvent: (BrSelectionDoubleClicked new selection: treeWidget selectedIndices; sourceEvent: aBlDoubleClickEvent)
]

{ #category : #'api - accessing' }
BrTreeClickToSelectHandler >> eventsToHandle [
	^ { BlClickEvent . BlDoubleClickEvent }
]

{ #category : #accessing }
BrTreeClickToSelectHandler >> treeWidget [
	^ treeWidget
]

{ #category : #accessing }
BrTreeClickToSelectHandler >> treeWidget: anObject [
	treeWidget := anObject
]
