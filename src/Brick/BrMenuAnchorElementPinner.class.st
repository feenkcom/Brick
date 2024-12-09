Class {
	#name : #BrMenuAnchorElementPinner,
	#superclass : #BrMenuPinner,
	#instVars : [
		'fallbackPinner',
		'rootPinner'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #accessing }
BrMenuAnchorElementPinner >> fallbackPinner [
	^ fallbackPinner
]

{ #category : #accessing }
BrMenuAnchorElementPinner >> fallbackPinner: anObject [
	fallbackPinner := anObject
]

{ #category : #initialization }
BrMenuAnchorElementPinner >> initialize [
	super initialize.
	rootPinner := fallbackPinner := BrMenuSpaceRootPinner new
]

{ #category : #'api - actions' }
BrMenuAnchorElementPinner >> pinMenuElement: aWidget [
	| anEvent anElement |
	anEvent := BrMenuWhoToPinToEvent new.
	aWidget fireEvent: anEvent.
	anElement := anEvent anchorElement.
	anElement ifNil: [ 
		fallbackPinner pinMenuElement: aWidget.
		^ self ].

	rootPinner pinMenuElement: aWidget.
	anElement addEventHandler: (BrMenuAnchorWithPinnedElementHandler new
		pinnedElement: aWidget)
]
