Class {
	#name : #BrListRowDataBinderChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'rowDataBinder'
	],
	#category : #'Brick-List - Events'
}

{ #category : #accessing }
BrListRowDataBinderChangedEvent >> rowDataBinder [

	^ rowDataBinder
]

{ #category : #accessing }
BrListRowDataBinderChangedEvent >> rowDataBinder: anObject [

	rowDataBinder := anObject
]
