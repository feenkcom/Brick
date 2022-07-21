Class {
	#name : #BrGroupedListHeaderDataBinderChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'headerDataBinder'
	],
	#category : #'Brick-List-Grouped-Events'
}

{ #category : #accessing }
BrGroupedListHeaderDataBinderChangedEvent >> headerDataBinder [
	^ headerDataBinder
]

{ #category : #accessing }
BrGroupedListHeaderDataBinderChangedEvent >> headerDataBinder: anObject [
	headerDataBinder := anObject
]
