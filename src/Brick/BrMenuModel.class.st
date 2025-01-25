Class {
	#name : #BrMenuModel,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'parent',
		'id'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #testing }
BrMenuModel class >> isAbstract [
	^ self name = #BrMenuModel
]

{ #category : #visiting }
BrMenuModel >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuModel: self
]

{ #category : #'api - announcer' }
BrMenuModel >> announcer [
	^ announcer
]

{ #category : #'api - converting' }
BrMenuModel >> asElement [
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #'api - converting' }
BrMenuModel >> asStencil [
	^ [ self ] asStencil
]

{ #category : #'gt - extensions' }
BrMenuModel >> gtItemChildren [
	^ Array empty
]

{ #category : #'gt - extensions' }
BrMenuModel >> gtItemLabel [
	^ self gtDisplayString
]

{ #category : #'gt - extensions' }
BrMenuModel >> gtParentsFor: aView [
	<gtView>
	self parent ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Parents';
		items: [ Array streamContents: [ :aStream | 
			self parentsDo: [ :aParent | aStream nextPut: aParent ] ] ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Parent' text: #gtItemLabel
]

{ #category : #'gt - extensions' }
BrMenuModel >> gtRootItems [
	^ { self }
]

{ #category : #'api - visibility' }
BrMenuModel >> hide [
	announcer announce: (BrMenuHideRequest new menuModel: self)
]

{ #category : #'api - visibility' }
BrMenuModel >> hideAll [
	self hide.
	self parentDo: #hideAll
]

{ #category : #accessing }
BrMenuModel >> id [
	<return: #BlElementId>
	^ id
]

{ #category : #accessing }
BrMenuModel >> id: anElementId [
	id := anElementId
]

{ #category : #initialization }
BrMenuModel >> initialize [
	super initialize.
	announcer := Announcer new.
]

{ #category : #'api - submenu' }
BrMenuModel >> items [
	^ #()
]

{ #category : #'api - hooks' }
BrMenuModel >> onMenuDisplayed: aMenuElement [
	"Subclasses may react when a menu is dispalyed using a given element"

	
]

{ #category : #accessing }
BrMenuModel >> parent [
	<return: #BrMenuModel or: nil>
	^ parent
]

{ #category : #accessing }
BrMenuModel >> parent: anObject [
	parent := anObject
]

{ #category : #'api - parent' }
BrMenuModel >> parentDo: aBlock [
	parent ifNotNil: aBlock
]

{ #category : #'api - parent' }
BrMenuModel >> parentsDo: aBlock [
	parent ifNotNil: [ :aParent |
		aBlock cull: aParent.
		aParent parentsDo: aBlock ]
]
