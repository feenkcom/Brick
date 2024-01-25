Extension { #name : #TBlElementProperties }

{ #category : #'*Brick' }
TBlElementProperties >> hExact: aWidth [
	self addProperty: (BlElementLayoutHorizontalResizerProperty new exact: aWidth)
]

{ #category : #'*Brick' }
TBlElementProperties >> hFitContent [
	self addProperty: (BlElementLayoutHorizontalResizerProperty fitContent)
]

{ #category : #'*Brick' }
TBlElementProperties >> hFitContentLimited [
	self addProperty: (BlElementLayoutHorizontalResizerProperty new fitContentLimited)
]

{ #category : #'*Brick' }
TBlElementProperties >> hMatchParent [
	self addProperty: (BlElementLayoutHorizontalResizerProperty matchParent)
]

{ #category : #'*Brick' }
TBlElementProperties >> vExact: aHeight [
	self addProperty: (BlElementLayoutVerticalResizerProperty new exact: aHeight)
]

{ #category : #'*Brick' }
TBlElementProperties >> vFitContent [
	self addProperty: (BlElementLayoutVerticalResizerProperty fitContent)
]

{ #category : #'*Brick' }
TBlElementProperties >> vFitContentLimited [
	self addProperty: (BlElementLayoutVerticalResizerProperty new fitContentLimited)
]

{ #category : #'*Brick' }
TBlElementProperties >> vMatchParent [
	self addProperty: (BlElementLayoutVerticalResizerProperty matchParent)
]
