Class {
	#name : #BrSearchExceptionAnnouncement,
	#superclass : #BrSearchAnnouncement,
	#instVars : [
		'exception',
		'freezedException',
		'context'
	],
	#category : #'Brick-List - Search Events'
}

{ #category : #accessing }
BrSearchExceptionAnnouncement >> context [
	^ context
]

{ #category : #accessing }
BrSearchExceptionAnnouncement >> context: anObject [
	context := anObject
]

{ #category : #accessing }
BrSearchExceptionAnnouncement >> exception [
	^ freezedException ifNil: [ exception ]
]

{ #category : #accessing }
BrSearchExceptionAnnouncement >> exception: anException [
	exception := anException
]

{ #category : #initialization }
BrSearchExceptionAnnouncement >> prepareForDelivery [
	super prepareForDelivery.

	exception ifNotNil: [ :anException | 
		freezedException := GtSystemUtility freeze: anException ]
]
