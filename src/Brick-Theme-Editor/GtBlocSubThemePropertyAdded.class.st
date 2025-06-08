Class {
	#name : #GtBlocSubThemePropertyAdded,
	#superclass : #GtBlocThemeAnnouncement,
	#instVars : [
		'themeProperty'
	],
	#category : #'Brick-Theme-Editor-Announcements'
}

{ #category : #accessing }
GtBlocSubThemePropertyAdded >> themeProperty [
	^ themeProperty
]

{ #category : #accessing }
GtBlocSubThemePropertyAdded >> themeProperty: anObject [
	themeProperty := anObject
]
