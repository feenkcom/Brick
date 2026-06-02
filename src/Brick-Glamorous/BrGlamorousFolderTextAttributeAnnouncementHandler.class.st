Class {
	#name : #BrGlamorousFolderTextAttributeAnnouncementHandler,
	#superclass : #BrTextFolderTextAttributeAnnouncementHandler,
	#instVars : [
		'element'
	],
	#category : #'Brick-Glamorous-Editor - Attributes'
}

{ #category : #accessing }
BrGlamorousFolderTextAttributeAnnouncementHandler >> element [
	^ element
]

{ #category : #accessing }
BrGlamorousFolderTextAttributeAnnouncementHandler >> element: anObject [
	element := anObject
]

{ #category : #installation }
BrGlamorousFolderTextAttributeAnnouncementHandler >> install [
	announcer ifNil: [ ^ self ].
	element ifNil: [ ^ self ].
	super install.

	element userData at: #folderAnnouncementHandler put: self
]

{ #category : #'private - event handling' }
BrGlamorousFolderTextAttributeAnnouncementHandler >> onBrTextFolderTextAttributeFoldingChanged: anAnnouncement [
	element ifNil: [ ^ self ].
	BlTaskAction
		enqueueElement: element
		action: [ element expanded: anAnnouncement isFolded not ]
]
