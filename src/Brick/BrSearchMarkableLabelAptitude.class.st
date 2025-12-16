Class {
	#name : #BrSearchMarkableLabelAptitude,
	#superclass : #BrSearchMarkableAptitude,
	#instVars : [
		'text'
	],
	#category : #'Brick-List - Search Aptitude'
}

{ #category : #'private - search' }
BrSearchMarkableLabelAptitude >> findItems: aMarkContext using: aMarker [
	<return: #Array of: #BrSearchFoundTextItem>
	self isSearchableText ifFalse: [ ^ #() ].

	^ aMarkContext pattern findAllIndexesInText: self text
]

{ #category : #initialization }
BrSearchMarkableLabelAptitude >> initializeListeners [
	super initializeListeners.
	self when: BrLabelChanged do: [ :anEvent | self text: anEvent text ]
]

{ #category : #initialization }
BrSearchMarkableLabelAptitude >> initializeRequests [
	super initializeRequests.
	self request: BrLabelRequest new
]

{ #category : #testing }
BrSearchMarkableLabelAptitude >> isSearchableText [
	<return: #Boolean>
	^ text isNotNil and: [ self text isNotEmpty ]
]

{ #category : #'private - event handling' }
BrSearchMarkableLabelAptitude >> onItemIdChanged [
	super onItemIdChanged.
	self isSearchableText ifFalse: [ ^ self ].

	self foundItemsDo: [ :foundItems | self flag: #todo ] ifAbsent: [  ]
]

{ #category : #accessing }
BrSearchMarkableLabelAptitude >> text [
	^ text ifNil: [ text := '' asRopedText ]
]

{ #category : #'as yet unclassified' }
BrSearchMarkableLabelAptitude >> text: aText [
	text := aText
]
