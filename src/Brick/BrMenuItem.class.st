Class {
	#name : #BrMenuItem,
	#superclass : #BrMenuModel,
	#traits : 'TBrMenuWithUpdatableModel + TBrMenuWithEnablementModel',
	#classTraits : 'TBrMenuWithUpdatableModel classTrait + TBrMenuWithEnablementModel classTrait',
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

{ #category : #visiting }
BrMenuItem >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuItem: self
]

{ #category : #'api - selection' }
BrMenuItem >> deselect [
	^ self isSelected: false
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

{ #category : #'api - visibility' }
BrMenuItem >> hide [
	"Hide corresponding menu element.
	Note: This method can be called only from the UI process."
	
	"Deselect this menu item."
	self deselect.
	
	super hide.
	
	"Forward the hide request to its parent,
	which is usually a BrMenuItems instance."
	self parentDo: #hide
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
	announcer announce: (BrMenuItemSelectionChangedAnnouncement new
		menuModel: self;
		isSelected: self isSelected)
]

{ #category : #'event handling' }
BrMenuItem >> onSelectionChanged [
]

{ #category : #'api - selection' }
BrMenuItem >> select [
	^ self isSelected: true
]
