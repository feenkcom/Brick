Class {
	#name : #BrTextExpandButtonHidingExpandedElementsAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'attributesCreatingBlock',
		'createdAttributes',
		'createdAttributeTags',
		'markerAttribute',
		'expanderModel',
		'id',
		'definingMethod'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #initialization }
BrTextExpandButtonHidingExpandedElementsAttribute >> initialize [
	super initialize.

	self beAppend.
	self placeholderAlignment: #alignMiddle.
	id := BlElementId noId.
	
	expanderModel := BrTextExpanderModel new.
	
	markerAttribute := nil.
	attributesCreatingBlock := [ OrderedCollection new ].
	createdAttributes := OrderedCollection new.
	createdAttributeTags := #()
]
