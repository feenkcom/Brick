Extension { #name : 'TBlDevScripterTarget' }

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onBrButtonName: aButtonLabel [
	self updateTarget: (BrDevScripterButtonWithLabelChildEventTarget new buttonLabel: aButtonLabel)
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onBrPagerFirstPane [
	self 
		onChildOfClass: BrInfinitePagerElement;
		onChildAt: 1
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onBrPagerSecondPane [
	self 
		onChildOfClass: BrInfinitePagerElement;
		onChildAt: 2
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onBrTextEditor [
	self onChildFromMessage: #editor
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onBrTextEditorText [
	self onChildFromMessage: #text
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onGtInspectorViewsTabBar [
	self
		onGtInspectorViewsTabGroup
		onChildNamed: #header;
		onChildNamed: #scrolltabbar;
		onChildNamed: #tabbar
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onGtInspectorViewsTabGroup [
	self
		onChildOfClass: BrTabGroup;
		onChildNamed: #content;
		onChildAt: 1;
		onChildOfClass: BrTabGroup
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onGtMaximizedPagerContent [
	self
		onChildOfClass: BlOverlayElement;
		onChildAt: 1;
		onChildOfClass: GtPagerWrapperElement;
		onChildNamed: #toolArea;
		onChildNamed: #tool
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onGtPagerFirstPaneContent [
	self 
		onBrPagerFirstPane;
		onGtPagerWrappedPaneContent
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onGtPagerPaneCloseButton [
	self 
		onChildOfClass: BrPagerPageContentElement;
		onChildAt: 2
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onGtPagerSecondPaneContent [
	self 
		onBrPagerSecondPane;
		onGtPagerWrappedPaneContent
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onGtPagerWrappedPaneContent [
	self 
		onChildOfClass: BrPagerPageContentElement;
		onChildOfClass: GtPagerWrapperElement;
		onChildNamed: #toolArea;
		onChildNamed: #tool
]

{ #category : '*Brick-DevTool' }
TBlDevScripterTarget >> onGtPlaygroundPlayAllButton [
	self 
		onChildNamed: #pages; "BrTabGroup"
		onChildNamed: #header;
		onChildNamed: #toolbar;
		onChildOfClass: BrToolbar;
		onChildAt: 2 "replace with a button id"
]
