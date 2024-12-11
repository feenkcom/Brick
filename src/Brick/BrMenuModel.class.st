Class {
	#name : #BrMenuModel,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'parent'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #testing }
BrMenuModel class >> isAbstract [
	^ self name = #BrMenuModel
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

{ #category : #initialization }
BrMenuModel >> initialize [
	super initialize.
	announcer := Announcer new.
]

{ #category : #'api - submenu' }
BrMenuModel >> items [
	^ #()
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
BrMenuModel >> parentsDo: aBlock [
	parent ifNotNil: [ :aParent |
		aBlock cull: aParent.
		aParent parentsDo: aBlock ]
]
