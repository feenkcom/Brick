Class {
	#name : #BrSizeAdjustmentAptitude,
	#superclass : #BrLazyStyleAptitude,
	#category : #'Brick-! Core - Size Adjustment'
}

{ #category : #accessing }
BrSizeAdjustmentAptitude >> huge: aBlock [
	self
		when: BrSizeAdjustmentState huge
		style: aBlock
]

{ #category : #accessing }
BrSizeAdjustmentAptitude >> large: aBlock [
	self
		when: BrSizeAdjustmentState large
		style: aBlock
]

{ #category : #accessing }
BrSizeAdjustmentAptitude >> mini: aBlock [
	self
		when: BrSizeAdjustmentState mini
		style: aBlock
]

{ #category : #accessing }
BrSizeAdjustmentAptitude >> normal: aBlock [
	self
		when: BrSizeAdjustmentState normal
		style: aBlock
]

{ #category : #accessing }
BrSizeAdjustmentAptitude >> small: aBlock [
	self
		when: BrSizeAdjustmentState small
		style: aBlock
]

{ #category : #accessing }
BrSizeAdjustmentAptitude >> tiny: aBlock [
	self
		when: BrSizeAdjustmentState tiny
		style: aBlock
]
