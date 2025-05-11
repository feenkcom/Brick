Class {
	#name : #BrTextTooltipAttribute,
	#superclass : #BrTextHoverAttribute,
	#instVars : [
		'tooltipStencil'
	],
	#category : #'Brick-Attributes'
}

{ #category : #private }
BrTextTooltipAttribute >> ensureTooltipWithText: anAptitudeId forTextElement: aTextElement [
	| aCache |
	aCache := aTextElement userData
			at: #TextTooltipsCache
			ifPresent: [ :theCache | theCache ]
			ifAbsentPut: [ WeakValueDictionary new ].

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
		dispatchEvent: (BrTextTooltipSetAptitudeIdWish new subtext: anAptitudeId).
	^ anAptitude
]

{ #category : #'event handling' }
BrTextTooltipAttribute >> onHideTooltipActionForText: aText textElement: aTextElement event: anEvent [
	tooltipStencil ifNil: [ ^ self ].
	aTextElement
		dispatchEvent: (BrTextTooltipDisableMouseEventHandlerWish new
				subtext: aText;
				dueToEvent: anEvent)
]

{ #category : #'event handling' }
BrTextTooltipAttribute >> onShowTooltipActionForText: aText textElement: aTextElement event: anEvent [
	| aBounds anOffset anAptitude |
	tooltipStencil ifNil: [ ^ self ].
	anAptitude := self ensureTooltipWithText: aText forTextElement: aTextElement.
	anOffset := aText textOffset - aTextElement text textOffset + (aText size / 2).
	aBounds := aTextElement globalCursorBoundsForIndex: anOffset.
	anAptitude relocator: (BrPopoverExplicitRelocator new globalBounds: aBounds).
	aTextElement
		dispatchEvent: (BrTextTooltipEnableMouseEventHandlerWish new
				subtext: aText;
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
