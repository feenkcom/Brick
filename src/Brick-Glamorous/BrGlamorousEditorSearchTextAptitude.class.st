Class {
	#name : #BrGlamorousEditorSearchTextAptitude,
	#superclass : #BrEditorSearchTextAptitude,
	#category : #'Brick-Glamorous-Editor'
}

{ #category : #initialization }
BrGlamorousEditorSearchTextAptitude >> newPopoverAptitude [
	^ BrGlamorousWithExplicitDropdownAptitude new
		withoutHandle;
		withoutMouseEventHandler;
		withGainFocusOnShow;
		withContainerAreaBuilders: {
				BlSteppedLayoutAreaBuilder contextMenuBottomLeft.
				BlSteppedLayoutAreaBuilder dropdownBottomLeft.
				BlSteppedLayoutAreaBuilder dropdownBottomRight.
				BlSteppedLayoutAreaBuilder contextMenuBottomRight.
				BlSteppedLayoutAreaBuilder dropdownUpLeft.
				BlSteppedLayoutAreaBuilder tooltipUpAlmostLeft.
				BlSteppedLayoutAreaBuilder tooltipBottomLeft.};
		relocator: BrEditorSearchTextPopoverContainerRelocator new;
		stencil: [ :aBrMenuInitialContext | 
			BrMenuExplicit new
				stencil: [ searchElement
						removeFromParent;
						editorDo: [ :anEditor | anEditor requestFocus ] ] ]
]

{ #category : #initialization }
BrGlamorousEditorSearchTextAptitude >> newSearchElement [
	^ BrSearchTextElement new
		hFitContentLimited;
		constraintsDo: [ :c | 
			c minWidth: 300.
			c frame horizontal alignCenter.
			c frame vertical alignCenter ]
]

{ #category : #'private - event management' }
BrGlamorousEditorSearchTextAptitude >> onBrSearchTextEndWish: anEvent [
	super onBrSearchTextEndWish: anEvent.

	self
		widgetDo: [ :aWidget | self dispatchEvent: (BrDropdownHideWish new anchor: aWidget) ]
]

{ #category : #'private - event management' }
BrGlamorousEditorSearchTextAptitude >> onOpenSearchTextDialogEvent: anEvent [
	super onOpenSearchTextDialogEvent: anEvent.
	self widgetDo: [ :aWidget | 
		self dispatchEvent: (BrDropdownShowWish new anchor: aWidget) ]
]
