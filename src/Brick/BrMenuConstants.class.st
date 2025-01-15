Class {
	#name : #BrMenuConstants,
	#superclass : #Object,
	#category : #'Brick-Menu - Support'
}

{ #category : #accessing }
BrMenuConstants class >> cornerRadius [
	^ 4
]

{ #category : #constants }
BrMenuConstants class >> defaultMenuItemBottomPadding [
	^ 3
]

{ #category : #constants }
BrMenuConstants class >> defaultMenuItemLeftPadding [
	^ 10
]

{ #category : #constants }
BrMenuConstants class >> defaultMenuItemRightPadding [
	^ 10
]

{ #category : #constants }
BrMenuConstants class >> defaultMenuItemTopPadding [
	^ 3
]

{ #category : #initialization }
BrMenuConstants class >> handleExtent [
	"Default handle extent used for context menus."

	^ 4 @ 4
]
