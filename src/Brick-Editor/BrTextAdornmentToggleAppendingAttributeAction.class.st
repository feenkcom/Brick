Class {
	#name : #BrTextAdornmentToggleAppendingAttributeAction,
	#superclass : #BrTextAdornmentAction,
	#instVars : [
		'appendingAttribute'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextAdornmentToggleAppendingAttributeAction >> appendingAttribute [
	^ appendingAttribute
]

{ #category : #accessing }
BrTextAdornmentToggleAppendingAttributeAction >> appendingAttribute: anObject [
	appendingAttribute := anObject
]

{ #category : #'api - action' }
BrTextAdornmentToggleAppendingAttributeAction >> executeOnEditorElement: anEditorElement fromAdornmentAttribute: anAdornmentAttribute [
	anAdornmentAttribute shouldAppend
		ifFalse: [ ^ self ].

	anEditorElement text
		findAttribute: appendingAttribute
		indicesDo: [ :aMarkerStartPosition :aMarkerEndPosition | 
			(anEditorElement text
				from: aMarkerStartPosition
				to: aMarkerEndPosition) removeAttribute: appendingAttribute.
			^ self ].

	anEditorElement addAppendingAttribute: appendingAttribute atAppendingAttribute: anAdornmentAttribute
]
