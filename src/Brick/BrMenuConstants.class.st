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
BrMenuConstants class >> defaultMenuGroupBottomPadding [
	^ 2
]

{ #category : #constants }
BrMenuConstants class >> defaultMenuGroupTopPadding [
	^ 4
]

{ #category : #constants }
BrMenuConstants class >> defaultMenuItemBottomPadding [
	^ 3
]

{ #category : #constants }
BrMenuConstants class >> defaultMenuItemLeftPadding [
	^ 6
]

{ #category : #constants }
BrMenuConstants class >> defaultMenuItemRightPadding [
	^ 6
]

{ #category : #constants }
BrMenuConstants class >> defaultMenuItemTopPadding [
	^ 2
]

{ #category : #initialization }
BrMenuConstants class >> handleExtent [
	"Default handle extent used for context menus."

	^ 4 @ 4
]
