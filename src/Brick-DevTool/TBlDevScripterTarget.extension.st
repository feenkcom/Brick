Extension { #name : #TBlDevScripterTarget }

{ #category : #'*Brick-DevTool' }
TBlDevScripterTarget >> onBrButtonName: aButtonLabel [
	self updateTarget: (BrDevScripterButtonWithLabelChildEventTarget new buttonLabel: aButtonLabel)
]

{ #category : #'*Brick-DevTool' }
TBlDevScripterTarget >> onBrTextEditor [
	self onChildFromMessage: #editor
]

{ #category : #'*Brick-DevTool' }
TBlDevScripterTarget >> onBrTextEditorText [
	self onChildFromMessage: #text
]

{ #category : #'*Brick-DevTool' }
TBlDevScripterTarget >> onDropdown: aBoolean [
	"True indicates using a new menu implementation.
	False means using an old anchored implementation."

	aBoolean
		ifFalse: [ self
				// BrAnchoredOuterContainer;
				/ BrAnchoredElement ]
		ifTrue: [ self // BrMenuSteppedElement ]
]

{ #category : #'*Brick-DevTool' }
TBlDevScripterTarget >> onMenuContainer [
	self
		onSpaceRoot;
		// BrMenuSteppedElement
]

{ #category : #'*Brick-DevTool' }
TBlDevScripterTarget >> onPopover [
	self
		onSpaceRoot;
		onDropdown: true
]
