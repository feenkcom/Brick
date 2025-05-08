Class {
	#name : #BrTextTooltipAttribute,
	#superclass : #BrTextHoverAttribute,
	#instVars : [
		'tooltipStencil'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #'event handling' }
BrTextTooltipAttribute >> aptitudeIdForText: aText [
	| aStopIndex aStartIndex |
	aStartIndex := aText textOffset.
	aStopIndex := aStartIndex + aText size - 1.
	^ self aptitudeIdFrom: aStartIndex to: aStopIndex
]

{ #category : #private }
BrTextTooltipAttribute >> aptitudeIdFrom: aStartIndex to: aStopIndex [
	^ BrTextTooltipId from: aStartIndex to: aStopIndex
]

{ #category : #private }
BrTextTooltipAttribute >> ensureTooltipWithId: anAptitudeId forTextElement: aTextElement [
	| aCache |
	aCache := aTextElement userData
			at: BrTextTooltipsCache
			ifPresent: [ :theCache | theCache ]
			ifAbsentPut: [ BrTextTooltipsCache new ].

	^ aCache
		at: anAptitudeId
		ifPresent: [ :theAptitude | theAptitude ]
		ifAbsentPut: [ | newAptitude |
			newAptitude := self newTooltipAptitudeForId: anAptitudeId.
			aTextElement addAptitude: newAptitude.
			newAptitude ]
]

{ #category : #initialization }
BrTextTooltipAttribute >> initialize [
	super initialize.

	enterAction := [ :aText :aTextElement :aTextEditor :anEvent | 
		self
			onShowTooltipActionForText: aText
			textElement: aTextElement
			event: anEvent ].
	leaveAction := [ :aText :aTextElement :aTextEditor :anEvent | 
		self
			onHideTooltipActionForText: aText
			textElement: aTextElement
			event: anEvent ]
]

{ #category : #private }
BrTextTooltipAttribute >> newTooltipAptitudeForId: anAptitudeId [
	| anAptitude |
	anAptitude := tooltipStencil create.
	anAptitude
		dispatchEvent: (BrTextTooltipSetAptitudeIdWish new aptitudeId: anAptitudeId).
	^ anAptitude
]

{ #category : #'event handling' }
BrTextTooltipAttribute >> onHideTooltipActionForText: aText textElement: aTextElement event: anEvent [
	| anAptitudeId |
	tooltipStencil ifNil: [ ^ self ].
	anAptitudeId := self aptitudeIdForText: aText.
	aTextElement
		dispatchEvent: (BrTextTooltipDisableMouseEventHandlerWish new
				aptitudeId: anAptitudeId;
				dueToEvent: anEvent)
]

{ #category : #'event handling' }
BrTextTooltipAttribute >> onShowTooltipActionForText: aText textElement: aTextElement event: anEvent [
	| aBounds anOffset anAptitude anAptitudeId |
	tooltipStencil ifNil: [ ^ self ].
	anAptitudeId := self aptitudeIdForText: aText.
	anAptitude := self ensureTooltipWithId: anAptitudeId forTextElement: aTextElement.
	anOffset := aText textOffset - aTextElement text textOffset + (aText size / 2).
	aBounds := aTextElement globalCursorBoundsForIndex: anOffset.
	anAptitude relocator: (BrPopoverExplicitRelocator new globalBounds: aBounds).
	aTextElement
		dispatchEvent: (BrTextTooltipEnableMouseEventHandlerWish new
				aptitudeId: anAptitudeId;
				dueToEvent: anEvent)
]

{ #category : #'api - initialization' }
BrTextTooltipAttribute >> stencil: aStencilBuilder [
	"Equivalent to `BrWithExplicitPopoverAptitude>>#stencil:`"

	self tooltipStencil: [ BrGlamorousWithExplicitTooltipAptitude new 
		mouseEventHandler: BrTextTooltipMouseHoverEventHandler new;
		stencil: aStencilBuilder ]
]

{ #category : #accessing }
BrTextTooltipAttribute >> tooltipStencil [
	<return: #BrStencil of: #BrWithExplicitTooltipAptitude>
	^ tooltipStencil
]

{ #category : #accessing }
BrTextTooltipAttribute >> tooltipStencil: aStencil [
	"Set a stencil that returns a `BrWithExplicitTooltipAptitude` kind of instance."

	tooltipStencil := aStencil asStencil
]
