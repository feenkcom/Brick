Class {
	#name : #BrPagerPageBoundEvent,
	#superclass : #BlEvent,
	#category : #'Brick-Pager - Support'
}

{ #category : #sending }
BrPagerPageBoundEvent >> sendTo: anObject [
	anObject pageBoundEvent: self
]
