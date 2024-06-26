"
I am sent when selection in a view model is changed
"
Class {
	#name : #BrSelectionChanged,
	#superclass : #BrChangeEvent,
	#instVars : [
		'selection',
		'selectedInterval',
		'deselectedInterval',
		'sourceEvent'
	],
	#category : #'Brick-! Core - Events'
}

{ #category : #'api - accessing' }
BrSelectionChanged >> allSelectedDo: aBlock [
	"Evaluate a given block with each selected interval as an argument"

	selection do: [ :eachSelectedInterval | aBlock value: eachSelectedInterval indices ]
]

{ #category : #'api - accessing' }
BrSelectionChanged >> deselectedDo: aBlock [
	"Evaluate a given block with a newly selected interval as an argument if there is one"

	deselectedInterval ifNotNil: aBlock
]

{ #category : #accessing }
BrSelectionChanged >> deselectedInterval [
	^ deselectedInterval
]

{ #category : #accessing }
BrSelectionChanged >> deselectedInterval: anObject [
	deselectedInterval := anObject
]

{ #category : #accessing }
BrSelectionChanged >> indices [
	<return: #Collection of: #Number>

	^ selection indices
]

{ #category : #'api - accessing' }
BrSelectionChanged >> selectedDo: aBlock [
	"Evaluate a given block with a newly selected interval as an argument if there is one"

	selectedInterval ifNotNil: aBlock
]

{ #category : #accessing }
BrSelectionChanged >> selectedInterval [
	^ selectedInterval
]

{ #category : #accessing }
BrSelectionChanged >> selectedInterval: anObject [
	selectedInterval := anObject
]

{ #category : #accessing }
BrSelectionChanged >> selection: aBlSelection [
	selection := aBlSelection
]

{ #category : #'api - accessing' }
BrSelectionChanged >> selectionDo: aBlock [
	aBlock value: selection
]

{ #category : #accessing }
BrSelectionChanged >> sourceEvent [
	^ sourceEvent
]

{ #category : #accessing }
BrSelectionChanged >> sourceEvent: anEvent [
	sourceEvent := anEvent
]

{ #category : #'api - accessing' }
BrSelectionChanged >> withIndexDo: aBlock [
	"[ :anIndex :isSelected | ]"

	self deselectedDo: [ :anInterval | anInterval do: [ :anIndex | aBlock value: anIndex value: false ] ].
	self selectedDo: [ :anInterval | anInterval do: [ :anIndex | aBlock value: anIndex value: true ] ]
]
