Trait {
	#name : #TBrLayoutAlignable,
	#category : #'Brick-Core-Layout Alignment'
}

{ #category : #'api - alignment' }
TBrLayoutAlignable >> alignBottomCenter [
	self states
		addState: BrLayoutHorizontalAlignmentState center;
		addState: BrLayoutVerticalAlignmentState end
]

{ #category : #'api - alignment' }
TBrLayoutAlignable >> alignBottomLeft [
	self states
		addState: BrLayoutHorizontalAlignmentState start;
		addState: BrLayoutVerticalAlignmentState end
]

{ #category : #'api - alignment' }
TBrLayoutAlignable >> alignBottomRight [
	self states
		addState: BrLayoutHorizontalAlignmentState end;
		addState: BrLayoutVerticalAlignmentState end
]

{ #category : #'api - alignment' }
TBrLayoutAlignable >> alignCenter [
	self states
		addState: BrLayoutHorizontalAlignmentState center;
		addState: BrLayoutVerticalAlignmentState center
]

{ #category : #'api - alignment' }
TBrLayoutAlignable >> alignCenterLeft [
	self states
		addState: BrLayoutHorizontalAlignmentState start;
		addState: BrLayoutVerticalAlignmentState center
]

{ #category : #'api - alignment' }
TBrLayoutAlignable >> alignCenterRight [
	self states
		addState: BrLayoutHorizontalAlignmentState end;
		addState: BrLayoutVerticalAlignmentState center
]

{ #category : #'api - alignment' }
TBrLayoutAlignable >> alignNone [
	self states
		addState: BrLayoutHorizontalAlignmentState none;
		addState: BrLayoutVerticalAlignmentState none
]

{ #category : #'api - alignment' }
TBrLayoutAlignable >> alignTopCenter [
	self states
		addState: BrLayoutHorizontalAlignmentState center;
		addState: BrLayoutVerticalAlignmentState start
]

{ #category : #'api - alignment' }
TBrLayoutAlignable >> alignTopLeft [
	self states
		addState: BrLayoutHorizontalAlignmentState start;
		addState: BrLayoutVerticalAlignmentState start
]

{ #category : #'api - alignment' }
TBrLayoutAlignable >> alignTopRight [
	self states
		addState: BrLayoutHorizontalAlignmentState end;
		addState: BrLayoutVerticalAlignmentState start
]
