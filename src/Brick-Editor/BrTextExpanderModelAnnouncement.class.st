Class {
	#name : #BrTextExpanderModelAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'expanderModel'
	],
	#category : #'Brick-Editor-Attributes - Support'
}

{ #category : #accessing }
BrTextExpanderModelAnnouncement >> expanderModel [
	^ expanderModel
]

{ #category : #accessing }
BrTextExpanderModelAnnouncement >> expanderModel: anObject [
	expanderModel := anObject
]
