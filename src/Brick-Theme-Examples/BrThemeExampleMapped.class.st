Class {
	#name : #BrThemeExampleMapped,
	#superclass : #BrTheme,
	#instVars : [
		'map'
	],
	#category : #'Brick-Theme-Examples-Brick-Theme-Examples'
}

{ #category : #accessing }
BrThemeExampleMapped >> at: aClass put: aSymbol [
	self
		assert: [ aSymbol isKeyword
				and: [ aSymbol numArgs = 1 and: [ self class canPerform: aSymbol ] ] ].
	map at: aClass put: aSymbol
]

{ #category : #accessing }
BrThemeExampleMapped >> defaultBackground [
	^ Color random
]

{ #category : #accessing }
BrThemeExampleMapped >> initialize [
	super initialize.
	map := IdentityDictionary new.
	self at: BrButton put: #newGlamorousButtonLookFor:
]

{ #category : #accessing }
BrThemeExampleMapped >> newDefaultLookFor: anElement [
	^ BrThemeExampleAptitude new
]

{ #category : #accessing }
BrThemeExampleMapped >> newGlamorousButtonLookFor: anElement [
	^ BrGlamorousButtonWithLabelAptitude new
]

{ #category : #accessing }
BrThemeExampleMapped >> newLookFor: anElement [
	| cursor |
	cursor := anElement class.
	[ map
		at: cursor
		ifPresent: [ :s | ^ self perform: s with: anElement ].
	cursor := cursor superclass ] doWhileTrue: [ cursor isNotNil ].
	^ nil
]

{ #category : #accessing }
BrThemeExampleMapped >> newMaterialButtonLookFor: anElement [
	^ BrMaterialButtonAptitude new
]
