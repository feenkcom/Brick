Trait {
	#name : #TBrSizeAdjustable,
	#category : #'Brick-! Core - Size Adjustment'
}

{ #category : #'api - size adjustable' }
TBrSizeAdjustable >> beHugeSize [
	self beSize: BrSizeAdjustmentState huge
]

{ #category : #'api - size adjustable' }
TBrSizeAdjustable >> beLargeSize [
	self beSize: BrSizeAdjustmentState large
]

{ #category : #'api - size adjustable' }
TBrSizeAdjustable >> beMiniSize [
	self beSize: BrSizeAdjustmentState mini
]

{ #category : #'api - size adjustable' }
TBrSizeAdjustable >> beNoneSize [
	self beSize: BrSizeAdjustmentState none
]

{ #category : #'api - size adjustable' }
TBrSizeAdjustable >> beNormalSize [
	self beSize: BrSizeAdjustmentState normal
]

{ #category : #'api - size adjustable' }
TBrSizeAdjustable >> beSize: aBrSizeAdjustmentState [
	aBrSizeAdjustmentState isNone
		ifTrue: [ self states removeState: aBrSizeAdjustmentState ]
		ifFalse: [ self states addState: aBrSizeAdjustmentState ]
]

{ #category : #'api - size adjustable' }
TBrSizeAdjustable >> beSmallSize [
	self beSize: BrSizeAdjustmentState small
]

{ #category : #'api - size adjustable' }
TBrSizeAdjustable >> beTinySize [
	self beSize: BrSizeAdjustmentState tiny
]
