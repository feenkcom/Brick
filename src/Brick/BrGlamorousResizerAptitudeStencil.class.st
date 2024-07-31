"
My subclasses create instances of {{gtClass:BrGlamorousWithResizerAptitude}}.
I am used by {{gtClass:BrWithDropdownAptitude}}. 
"
Class {
	#name : #BrGlamorousResizerAptitudeStencil,
	#superclass : #BrStencil,
	#instVars : [
		'isKeepRatio',
		'whenResizedHandler'
	],
	#category : #'Brick-Dropdown - Helpers'
}

{ #category : #comparing }
BrGlamorousResizerAptitudeStencil >> = aStencil [
	self == aStencil ifTrue: [ ^ true ].

	^ self class = aStencil class
]

{ #category : #private }
BrGlamorousResizerAptitudeStencil >> createResizeAptitudeWith: anAptitude [
	whenResizedHandler ifNotNil: [ anAptitude whenResizedDo: whenResizedHandler ].
	isKeepRatio ifNotNil: [ :aBoolean | anAptitude keepRatio: aBoolean ].
	^ anAptitude
]

{ #category : #comparing }
BrGlamorousResizerAptitudeStencil >> hash [
	^ self class hash
]

{ #category : #accessing }
BrGlamorousResizerAptitudeStencil >> isKeepRatio [
	^ isKeepRatio
]

{ #category : #accessing }
BrGlamorousResizerAptitudeStencil >> isKeepRatio: anObject [
	isKeepRatio := anObject
]

{ #category : #accessing }
BrGlamorousResizerAptitudeStencil >> whenResizedDo: aBlock [
	whenResizedHandler := aBlock
]
