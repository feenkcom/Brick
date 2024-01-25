Class {
	#name : #BrListClickToSelectHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'listWidget',
		'shouldRequestFocus'
	],
	#category : #'Brick-List-Support'
}

{ #category : #'api - accessing' }
BrListClickToSelectHandler >> clickEvent: aBlClickEvent [
	| anItemIndex |

	anItemIndex := aBlClickEvent currentTarget constraints infinite holder dataSourcePosition.
	anItemIndex <= 0
		ifTrue: [ ^ self ].

	aBlClickEvent consumed: true.
	
	listWidget requestFocus.
	listWidget selectOne: anItemIndex dueTo: aBlClickEvent.
]

{ #category : #'api - accessing' }
BrListClickToSelectHandler >> doubleClickEvent: aBlDoubleClickEvent [
	aBlDoubleClickEvent consumed: true.

	listWidget dispatchEvent: (BrSelectionDoubleClicked new selection: listWidget selectedIndices; sourceEvent: aBlDoubleClickEvent)
]

{ #category : #'api - accessing' }
BrListClickToSelectHandler >> eventsToHandle [
	^ { BlClickEvent . BlDoubleClickEvent }
]

{ #category : #'initialization ' }
BrListClickToSelectHandler >> initialize [
	super initialize.
	
	shouldRequestFocus := true
]

{ #category : #accessing }
BrListClickToSelectHandler >> listWidget [
	^ listWidget
]

{ #category : #accessing }
BrListClickToSelectHandler >> listWidget: anObject [
	listWidget := anObject
]

{ #category : #accessing }
BrListClickToSelectHandler >> shouldRequestFocus [
	^ shouldRequestFocus
]

{ #category : #accessing }
BrListClickToSelectHandler >> shouldRequestFocus: anObject [
	shouldRequestFocus := anObject
]
