Class {
	#name : #BrSearchProgressAnnouncement,
	#superclass : #BrSearchAnnouncement,
	#instVars : [
		'items',
		'selectedIndex',
		'context'
	],
	#category : #'Brick-List - Search Events'
}

{ #category : #accessing }
BrSearchProgressAnnouncement >> context [
	^ context
]

{ #category : #accessing }
BrSearchProgressAnnouncement >> context: anObject [
	context := anObject
]

{ #category : #accessing }
BrSearchProgressAnnouncement >> items [
	^ items ifNil: [ #() ]
]

{ #category : #accessing }
BrSearchProgressAnnouncement >> items: anObject [
	items := anObject
]

{ #category : #accessing }
BrSearchProgressAnnouncement >> itemsCount [
	^ self items size
]

{ #category : #accessing }
BrSearchProgressAnnouncement >> selectedIndex [
	^ selectedIndex
]

{ #category : #accessing }
BrSearchProgressAnnouncement >> selectedIndex: anObject [
	selectedIndex := anObject
]
