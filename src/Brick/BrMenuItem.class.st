Class {
	#name : #BrMenuItem,
	#superclass : #BrMenuModel,
	#instVars : [
		'isSelected',
		'group'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #testing }
BrMenuItem class >> isAbstract [
	^ self name = #BrMenuItem
]

{ #category : #'api - converting' }
BrMenuItem >> asElement [
	<return: #BlElement>
	^ self elementType new menuModel: self
]

{ #category : #'api - selection' }
BrMenuItem >> deselect [
	^ self isSelected: false
]

{ #category : #'api - converting' }
BrMenuItem >> elementType [
	"Return element class that is used do display the menu item"

	<return: #'BlElement class'>
	^ self subclassResponsibility
]

{ #category : #'api - grouping' }
BrMenuItem >> group [
	<return: #BrMenuItemGroupConfiguration>
	^ group
]

{ #category : #'api - grouping' }
BrMenuItem >> group: aBrMenuItemGroupConfiguration [
	group := aBrMenuItemGroupConfiguration
]

{ #category : #'api - grouping' }
BrMenuItem >> groupId: aSymbol priority: aPriority [
	self
		group: (BrMenuItemGroupConfiguration new
				name: aSymbol;
				priority: aPriority)
]

{ #category : #'gt - extensions' }
BrMenuItem >> gtItemDepth [
	| aDepth |
	aDepth := 1.
	self parentsDo: [ aDepth := aDepth + 1 ].
	^ aDepth
]

{ #category : #'gt - extensions' }
BrMenuItem >> gtItemLabel [
	^ self labelModel ifNotNil: #gtItemLabel
]

{ #category : #'gt - extensions' }
BrMenuItem >> gtItemSelection [
	^ self isSelected
		ifTrue: [ 'selected' ]
		ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
]

{ #category : #'api - visibility' }
BrMenuItem >> hide [
	self deselect.
	super hide.
	self parent ifNotNil: #hide
]

{ #category : #initialization }
BrMenuItem >> initialize [
	super initialize.
	isSelected := false.
	group := BrMenuItemGroupConfiguration new.
]

{ #category : #'api - selection' }
BrMenuItem >> isSelected [
	<return: #Boolean>
	^ isSelected
]

{ #category : #'api - selection' }
BrMenuItem >> isSelected: aBoolean [
	isSelected = aBoolean ifTrue: [ ^ self ].
	isSelected := aBoolean.
	self onSelectionChanged.
	self notifySelectionChanged.
]

{ #category : #accessing }
BrMenuItem >> menuType [
	^ self class
]

{ #category : #'event handling' }
BrMenuItem >> notifySelectionChanged [
	announcer announce: (BrMenuItemSelectionChanged new
		menuItem: self;
		isSelected: self isSelected)
]

{ #category : #'event handling' }
BrMenuItem >> onSelectionChanged [
]

{ #category : #'api - selection' }
BrMenuItem >> select [
	^ self isSelected: true
]
