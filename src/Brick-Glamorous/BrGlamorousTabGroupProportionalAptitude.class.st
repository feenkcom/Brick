Class {
	#name : #BrGlamorousTabGroupProportionalAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'headerLook'
	],
	#category : #'Brick-Glamorous-Tabs'
}

{ #category : #'api - style' }
BrGlamorousTabGroupProportionalAptitude >> headerBackground: aBackground [
	headerLook headerDo: [ :aHeaderElement | aHeaderElement background: aBackground ]
]

{ #category : #initialization }
BrGlamorousTabGroupProportionalAptitude >> initialize [
	super initialize.

	self addAll: {
		headerLook := BrGlamorousTabGroupProportionalHeaderAptitude new.
		BrTabGroupSplitterAptitude new.
		BrTabGroupContentAptitude new }.

	self addChangeProperty: #(widget layout) with: [ BlLinearLayout vertical ]
]
