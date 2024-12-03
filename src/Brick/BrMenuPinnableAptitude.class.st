Class {
	#name : #BrMenuPinnableAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'handleElement',
		'pullHandler',
		'closeButton'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'private - updating' }
BrMenuPinnableAptitude >> addCloseButton [
	closeButton ifNotNil: [ ^ self ].
	
	self widgetDo: [ :anElement |
		anElement clipChildren: false.
		closeButton := self newCloseButton.
		closeButton visibility: BlVisibility gone.
		closeButton action: [ :aButton |
			self onCloseFrom: aButton ].
		self
			when: BlMouseEnterEvent
			do: [ :anEvent | closeButton visibility: BlVisibility visible ].
		self
			when: BlMouseLeaveEvent
			do: [ :anEvent | closeButton visibility: BlVisibility gone ].
		anElement addChild: closeButton ]
]

{ #category : #initialization }
BrMenuPinnableAptitude >> initialize [
	super initialize.
	pullHandler := BlPullHandler new disallowOutOfBounds.
	handleElement := self newHandleElement.
	handleElement addEventHandler: pullHandler.
	closeButton := nil.
	
	self
		addChange:
			(BrLookChange new
				up: [ :e | 
					self widget addChild: handleElement.
					pullHandler targetElement: self widget ];
				down: [ :e | 
					handleElement removeFromParent.
					pullHandler targetElement: nil.
					closeButton ifNotNil: #removeFromParent.
					closeButton := nil ];
				yourself).
]

{ #category : #initialization }
BrMenuPinnableAptitude >> initializeListeners [
	super initializeListeners.

	self when: BlPullStartEvent doOnce: [ :anEvent | self onPullStartEvent: anEvent ].
	self when: BlPullEndEvent doOnce: [ :anEvent | self onPullEndEvent: anEvent ]
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> newCloseButton [
	^ GtInspectorRoundButtonStencil small asElement
		icon: (BrPlusIconStencil close radius: 3) asElement;
		zIndex: 10;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignCenterAt: 1.0.
			c ignored vertical alignCenterAt: 0.0 ];
		addAptitude: (BrGlamorousWithLabelTooltipAptitude 
			text: 'Close').
]

{ #category : #initialization }
BrMenuPinnableAptitude >> newHandleElement [
	^ BrMenuDragHandleElement new
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignCenter.
			c ignored vertical alignTop ]
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> onCloseFrom: aButton [
	self widgetDo: [ :aWidget | 
		BlTaskAction 
			enqueueElement: aWidget 
			action: [ aWidget removeFromParent ] ]
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> onPullEndEvent: anEvent [ 
	self widgetDo: [ :aWidget |
		| aPosition aSpace |
		anEvent consumed: true.
	
		aPosition := aWidget positionInSpace.
		aSpace := aWidget space.
		aWidget removeFromParent.
		aSpace addChild: aWidget.
		aWidget relocate: aPosition.
		self addCloseButton ]
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> onPullStartEvent: anEvent [ 
	self widgetDo: [ :aWidget |
		| aPosition |
		anEvent consumed: true.
	
		aPosition := aWidget position.
		aWidget fireEvent: BrMenuDetachWish new.
		aWidget constraintsDo: [ :c | 
			c ignoreByLayout ].
		aWidget relocate: aPosition ]
]
