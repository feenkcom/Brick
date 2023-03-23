Class {
	#name : #BrPagerPageEmbellisher,
	#superclass : #BrStencil,
	#instVars : [
		'contentElement',
		'index'
	],
	#category : #'Brick-Pager - Stencil'
}

{ #category : #accessing }
BrPagerPageEmbellisher >> contentElement [
	^ contentElement
]

{ #category : #accessing }
BrPagerPageEmbellisher >> contentElement: anElement [
	contentElement := anElement
]

{ #category : #'api - instantiation' }
BrPagerPageEmbellisher >> create [
	<return: #BlElement>

	^ self contentElement
]

{ #category : #accessing }
BrPagerPageEmbellisher >> index [
	^ index
]

{ #category : #accessing }
BrPagerPageEmbellisher >> index: anInteger [
	"Set a pager page index.
	It can be used for example to set an indexed element ID."
	index := anInteger
]
