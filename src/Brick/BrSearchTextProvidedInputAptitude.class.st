Class {
	#name : #BrSearchTextProvidedInputAptitude,
	#superclass : #BrSearchTextAptitude,
	#instVars : [
		'searchElement'
	],
	#category : #'Brick-List - Search Aptitude'
}

{ #category : #accessing }
BrSearchTextProvidedInputAptitude >> searchElement [
	^ searchElement
]

{ #category : #accessing }
BrSearchTextProvidedInputAptitude >> searchElement: anElement [
	self assert: [ anElement isNotNil ].
	searchElement = anElement ifTrue: [ ^ self ].
	
	searchElement ifNotNil: [ :oldElement | 
		self uninstallSearchElementEventHandlers: anElement ].
	
	searchElement := anElement.
	self installSearchElementEventHandlers: anElement
]
