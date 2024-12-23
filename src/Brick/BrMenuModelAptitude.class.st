Class {
	#name : #BrMenuModelAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBrMenuWithMenuModel',
	#classTraits : 'TBrMenuWithMenuModel classTrait',
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #initialization }
BrMenuModelAptitude >> initializeListeners [
	super initializeListeners.

	self when: BrMenuDetachWish do: [ :anEvent | 
		self onMenuDetachWish: anEvent ]
]

{ #category : #'event handling' }
BrMenuModelAptitude >> onMenuDetachWish: anEvent [
	self unsubscribeFromMenuModel
]
