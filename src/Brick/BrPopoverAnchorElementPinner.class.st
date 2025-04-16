Class {
	#name : #BrPopoverAnchorElementPinner,
	#superclass : #BrPopoverPinner,
	#instVars : [
		'fallbackPinner',
		'rootPinner'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #accessing }
BrPopoverAnchorElementPinner >> fallbackPinner [
	^ fallbackPinner
]

{ #category : #accessing }
BrPopoverAnchorElementPinner >> fallbackPinner: anObject [
	fallbackPinner := anObject
]

{ #category : #initialization }
BrPopoverAnchorElementPinner >> initialize [
	super initialize.
	rootPinner := fallbackPinner := BrPopoverSpaceRootPinner new
]

{ #category : #'api - actions' }
BrPopoverAnchorElementPinner >> pinMenuElement: aWidget [
	| anEvent anElement |
	anEvent := BrPopoverWhoToPinToEvent new.
	aWidget fireEvent: anEvent.
	anElement := anEvent anchorElement.
	anElement ifNil: [ 
		fallbackPinner pinMenuElement: aWidget.
		^ self ].

	rootPinner pinMenuElement: aWidget.
	anElement addEventHandler: (BrPopoverAnchorWithPinnedElementHandler new
		pinnedElement: aWidget)
]
