Class {
	#name : #BrSearchFinishedAnnouncement,
	#superclass : #BrSearchAnnouncement,
	#instVars : [
		'items',
		'selectedIndex',
		'context'
	],
	#category : #'Brick-List - Search Events'
}

{ #category : #accessing }
BrSearchFinishedAnnouncement >> context [
	^ context
]

{ #category : #accessing }
BrSearchFinishedAnnouncement >> context: anObject [
	context := anObject
]

{ #category : #accessing }
BrSearchFinishedAnnouncement >> items [
	^ items ifNil: [ #() ]
]

{ #category : #accessing }
BrSearchFinishedAnnouncement >> items: anObject [
	items := anObject
]

{ #category : #accessing }
BrSearchFinishedAnnouncement >> itemsCount [
	^ self items size
]

{ #category : #accessing }
BrSearchFinishedAnnouncement >> selectedIndex [
	^ selectedIndex
]

{ #category : #accessing }
BrSearchFinishedAnnouncement >> selectedIndex: anObject [
	selectedIndex := anObject
]
