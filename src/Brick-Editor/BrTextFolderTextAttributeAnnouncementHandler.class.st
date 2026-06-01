Class {
	#name : #BrTextFolderTextAttributeAnnouncementHandler,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'Brick-Editor-Attributes - Support'
}

{ #category : #accessing }
BrTextFolderTextAttributeAnnouncementHandler >> announcer [
	^ announcer
]

{ #category : #accessing }
BrTextFolderTextAttributeAnnouncementHandler >> announcer: anObject [
	announcer := anObject
]

{ #category : #installation }
BrTextFolderTextAttributeAnnouncementHandler >> install [
	announcer ifNil: [ ^ self ].

	announcer weak
		when: BrTextFolderTextAttributeFoldingChanged
		send: #onBrTextFolderTextAttributeFoldingChanged:
		to: self.
]

{ #category : #'private - event handling' }
BrTextFolderTextAttributeAnnouncementHandler >> onBrTextFolderTextAttributeFoldingChanged: anAnnouncement [
	self subclassResponsibility
]
