Class {
	#name : #BrGlamorousDarkTheme,
	#superclass : #BrGlamorousTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousDarkTheme >> initialize [
	super initialize.

	colors := BrGlamorousDarkThemeColors theme: self.

	link := BrGlamorousLinkDarkTheme theme: self.
	link initializeThemeable.
	status := BrGlamorousStatusDarkTheme theme: self.
	status initializeThemeable.

	default := BrGlamorousDefaultDarkTheme theme: self.
	default initializeThemeable.

	editor := BrGlamorousEditorDarkTheme theme: self.
	editor initializeThemeable.

	button := BrGlamorousButtonDarkTheme theme: self.
	button initializeThemeable.

	item := BrGlamorousItemDarkTheme theme: self.
	item initializeThemeable.

	header := BrGlamorousHeaderDarkTheme theme: self.
	header initializeThemeable.

	label := BrGlamorousLabelDarkTheme theme: self.
	label initializeThemeable
]

{ #category : #'instance creation' }
BrGlamorousDarkTheme >> newColumnedListTheme [
	^ BrColumnedListDarkTheme theme: self
]

{ #category : #initialization }
BrGlamorousDarkTheme >> newMarkupTheme [
	^ BrGlamorousMarkupDarkTheme theme: self
]
