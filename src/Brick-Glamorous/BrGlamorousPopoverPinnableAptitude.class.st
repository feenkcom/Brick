"
I make {{gtClass:BrMenuModel}} elements pinnable. It means that users can drag-and-drop menus and keep them permanently visible. Users can explicitly close such elements using a close button.
# Example
The following `Complex submenu` has a drag handle on the top: 
{{gtExample:BrMenuWithScripterExamples>>#hoverComplexSubmenu | noCode=true | previewHeight=600 | previewShow=#gtScreenshotFor:}}

Users can use it to move the menu element and keep it open, while the rest of the dropdown is closed: 
{{gtExample:BrMenuWithScripterExamples>>#dragPinnableComplexSubmenu | noCode=true | previewHeight=600 | previewShow=#gtScreenshotFor:}}
"
Class {
	#name : #BrGlamorousPopoverPinnableAptitude,
	#superclass : #BrPopoverPinnableAptitude,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #initialization }
BrGlamorousPopoverPinnableAptitude >> newCloseButton [
	^ GtInspectorRoundButtonStencil small asElement
		icon: (BrPlusIconStencil close radius: 3) asElement;
		action: [ :aButton |
			self onCloseFrom: aButton ];
		zIndex: 10;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignCenterAt: 1.0.
			c ignored vertical alignCenterAt: 0.0 ];
		addAptitude: (BrGlamorousWithExplicitTooltipAptitude 
			text: 'Close').
]

{ #category : #initialization }
BrGlamorousPopoverPinnableAptitude >> newHandleElement [
	^ super newHandleElement addAptitude: BrGlamorousHandleBarResizerAptitude new
]
