Class {
	#name : #BrResizer,
	#superclass : #BlElement,
	#instVars : [
		'target',
		'location',
		'resizerListener',
		'isKeepRatio'
	],
	#category : #'Brick-Resizer - UI'
}

{ #category : #location }
BrResizer >> beBottom [
	self location: BrResizerBottomLocation new
]

{ #category : #location }
BrResizer >> beLeft [
	self location: BrResizerLeftLocation new
]

{ #category : #location }
BrResizer >> beRight [
	self location: BrResizerRightLocation new
]

{ #category : #location }
BrResizer >> beTop [
	self location: BrResizerTopLocation new
]

{ #category : #initialization }
BrResizer >> initialize [
	super initialize.

	isKeepRatio := false
]

{ #category : #testing }
BrResizer >> isKeepRatio [
	^ isKeepRatio ifNil: [ false ]
]

{ #category : #accessing }
BrResizer >> keepRatio: aBoolean [

	isKeepRatio := aBoolean.
	resizerListener ifNotNil: [ :anEventHandler |
		anEventHandler keepRatio: self isKeepRatio ]
]

{ #category : #accessing }
BrResizer >> location [
	^ location
]

{ #category : #accessing }
BrResizer >> location: aResizerLocation [
	location = aResizerLocation
		ifTrue: [ ^ self ].
	
	location := aResizerLocation.
	
	resizerListener ifNotNil: [ :anEventHandler | self removeEventHandler: anEventHandler ].
	resizerListener := self location newResizerListener.
	resizerListener resizeTarget: self target.
	resizerListener keepRatio: self isKeepRatio.
	self addEventHandler: resizerListener.

	self states addState: (BrResizerLocationState location: aResizerLocation)
]

{ #category : #accessing }
BrResizer >> target [
	^ target
]

{ #category : #accessing }
BrResizer >> target: anElement [
	"Set which element should be resized with this resizer"
	
	target = anElement
		ifTrue: [ ^ self ].

	target := anElement.
	resizerListener ifNotNil: [ :anEventHandler | anEventHandler resizeTarget: anElement ]
]
