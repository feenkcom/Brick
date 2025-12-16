Class {
	#name : #BrSearchMarkerContext,
	#superclass : #Object,
	#instVars : [
		'source',
		'pattern',
		'foundItems',
		'selectedItem',
		'element'
	],
	#category : #'Brick-List - Search Model'
}

{ #category : #accessing }
BrSearchMarkerContext >> element [
	^ element
]

{ #category : #accessing }
BrSearchMarkerContext >> element: anObject [
	element := anObject
]

{ #category : #accessing }
BrSearchMarkerContext >> elementDo: aBlock [
	^ element ifNotNil: aBlock
]

{ #category : #'api - found items' }
BrSearchMarkerContext >> foundItems [
	<return: #Array of: #BrSearchFoundItem>
	^ foundItems ifNil: [ #() ]
]

{ #category : #'api - found items' }
BrSearchMarkerContext >> foundItems: aCollection [
	foundItems := aCollection.
	selectedItem := nil.
]

{ #category : #'gt - extensions' }
BrSearchMarkerContext >> gtFoundItemsFor: aView [
	<gtView>
	foundItems ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Found items';
		items: [ foundItems ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #'api - source' }
BrSearchMarkerContext >> hasSource [
	<return: #BrSearchSource>
	^ source isNotNil and: [ source hasSource ]
]

{ #category : #'api - source' }
BrSearchMarkerContext >> hasVisibleSource [
	<return: #BrSearchSource>
	^ source isNotNil and: [ source hasVisibleSource ]
]

{ #category : #'as yet unclassified' }
BrSearchMarkerContext >> isSelectedItem: aBrSearchFoundTextItem [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
BrSearchMarkerContext >> isSelectedItem: anItem index: anIndex [
	| aSelectedItem |
	aSelectedItem := self selectedItem.
	aSelectedItem ifNil: [ ^ self selectedIndex = anIndex ].

	^ anIndex = aSelectedItem
]

{ #category : #'api - pattern' }
BrSearchMarkerContext >> pattern [
	<return: #BrSearchPattern>
	^ pattern
]

{ #category : #'api - pattern' }
BrSearchMarkerContext >> pattern: aSearchPattern [
	pattern := aSearchPattern
]

{ #category : #'api - found items' }
BrSearchMarkerContext >> selectedIndex [
	"Return an index among #foundItems"

	<return: #Integer>
	^ self selectedItem ifNotNil: #index ifNil: [ 1 ]
]

{ #category : #'api - found items' }
BrSearchMarkerContext >> selectedItem [
	<return: #BrSearchFoundItem or: nil>
	self foundItems ifEmpty: [ ^ nil ].
	selectedItem ifNotNil: [ ^ selectedItem ].
	^ self foundItems
		detect: [ :eachItem | eachItem isSelected ]
		ifFound: [ :anItem | selectedItem := anItem ]
		ifNone: [ nil ]
]

{ #category : #'api - source' }
BrSearchMarkerContext >> source [
	<return: #BrSearchSource>
	^ source
]

{ #category : #'api - source' }
BrSearchMarkerContext >> source: aSource [
	source := aSource
]
