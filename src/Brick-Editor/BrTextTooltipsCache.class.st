"
I cache {{gtClass:BrWithExplicitPopoverAptitude}} instances for a given text line element.
I use {{gtClass:BrTextTooltipId}}.  
I am used by {{gtClass:BrTextTooltipAttribute}}. 

"
Class {
	#name : #BrTextTooltipsCache,
	#superclass : #Object,
	#instVars : [
		'cache'
	],
	#category : #'Brick-Editor-Attributes - Support'
}

{ #category : #accessing }
BrTextTooltipsCache >> at: anAptitudeId ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ cache
		at: anAptitudeId
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #accessing }
BrTextTooltipsCache >> at: anAptitudeId ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
	^ cache
		at: anAptitudeId
		ifPresent: aPresentBlock
		ifAbsentPut: anAbsentBlock
]

{ #category : #initialization }
BrTextTooltipsCache >> initialize [
	super initialize.
	cache := WeakValueDictionary new
]
