Class {
	#name : #BrIconDropdownAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'iconElement'
	],
	#category : #'Brick-! Core - Aptitudes'
}

{ #category : #initialization }
BrIconDropdownAptitude >> defaultIconElement [
	^ BlElement new
		size: 6 @ 6;
		background: Color red;
		geometry: BlEllipseGeometry new
]

{ #category : #accessing }
BrIconDropdownAptitude >> icon [
	<return: #BlElement>

	^ iconElement
]

{ #category : #accessing }
BrIconDropdownAptitude >> icon: aStencilOrElement [
	self
		assert: [ aStencilOrElement isNotNil ]
		description: [ 'Icon must not be nil' ].

	iconElement := aStencilOrElement asElement.
	self updateIcon
]

{ #category : #accessing }
BrIconDropdownAptitude >> iconDo: aBlock [
	aBlock value: self icon
]

{ #category : #accessing }
BrIconDropdownAptitude >> iconElementId [
	^ #iconDropdown
]

{ #category : #initialization }
BrIconDropdownAptitude >> initialize [
	super initialize.

	"default icon"
	iconElement := self defaultIconElement.
	self
		addChange:
			(BrLookChange new
				up: [ :e | self updateIcon ];
				down: [ :e | iconElement ifNotNil: #removeFromParent ];
				yourself)
]

{ #category : #updating }
BrIconDropdownAptitude >> updateIcon [
	self
		widgetDo: [ self widgetContent
				childNamed: self iconElementId
				ifFound: [ :anIconElement | 
					| aParent anIndex |
					aParent := anIconElement parent.
					anIndex := aParent childIndexOf: anIconElement.
					anIconElement removeFromParent.
					iconElement removeFromParent.
					aParent
						addChild: iconElement
						at: anIndex
						as: self iconElementId ]
				ifNone: [ self widgetContent addChild: iconElement as: self iconElementId ] ]
]
