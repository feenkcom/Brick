Class {
	#name : #BrListItemDataBinderChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'itemDataBinder'
	],
	#category : #'Brick-List-Ungrouped-Events'
}

{ #category : #accessing }
BrListItemDataBinderChangedEvent >> itemDataBinder [
	^ itemDataBinder
]

{ #category : #accessing }
BrListItemDataBinderChangedEvent >> itemDataBinder: anObject [
	itemDataBinder := anObject
]
