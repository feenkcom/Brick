"
Semantic header colors shared by columned lists and columned trees. Themeable colors resolve through the owning theme's columnedList subtheme. Only headers that can actually sort use the hover background.
"
Class {
	#name : #BrColumnedListTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'headerBackgroundColor',
		'sortableHeaderHoveredBackgroundColor'
	],
	#category : #'Brick-Theme-Columned List'
}

{ #category : #accessing }
BrColumnedListTheme >> headerBackgroundColor [
	^ headerBackgroundColor
]

{ #category : #accessing }
BrColumnedListTheme >> headerBackgroundColor: aColor [
	self constantAt: #headerBackgroundColor put: aColor.
	headerBackgroundColor := aColor
]

{ #category : #initialization }
BrColumnedListTheme >> initializeColors [
	super initializeColors.
	headerBackgroundColor := self constantAt: #headerBackgroundColor.
	sortableHeaderHoveredBackgroundColor := self
			constantAt: #sortableHeaderHoveredBackgroundColor
]

{ #category : #initialization }
BrColumnedListTheme >> initializeThemeable [
	super initializeThemeable.
	headerBackgroundColor := self
			color: [ :aTheme | aTheme columnedList constantAt: #headerBackgroundColor ]
			source: [ :aTheme | aTheme columnedList headerBackgroundColor ].
	sortableHeaderHoveredBackgroundColor := self
			color: [ :aTheme | aTheme columnedList constantAt: #sortableHeaderHoveredBackgroundColor ]
			source: [ :aTheme | aTheme columnedList sortableHeaderHoveredBackgroundColor ]
]

{ #category : #accessing }
BrColumnedListTheme >> sortableHeaderHoveredBackgroundColor [
	^ sortableHeaderHoveredBackgroundColor
]

{ #category : #accessing }
BrColumnedListTheme >> sortableHeaderHoveredBackgroundColor: aColor [
	self constantAt: #sortableHeaderHoveredBackgroundColor put: aColor.
	sortableHeaderHoveredBackgroundColor := aColor
]
