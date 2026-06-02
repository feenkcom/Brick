Class {
	#name : #BrTextFolderTextAttributeFoldingChanged,
	#superclass : #BrTextFolderTextAttributeAnnouncement,
	#instVars : [
		'isFolded'
	],
	#category : #'Brick-Editor-Attributes - Support'
}

{ #category : #accessing }
BrTextFolderTextAttributeFoldingChanged >> isFolded [
	^ isFolded
]

{ #category : #accessing }
BrTextFolderTextAttributeFoldingChanged >> isFolded: anObject [
	isFolded := anObject
]
