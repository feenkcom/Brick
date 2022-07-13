Class {
	#name : #BrGridList,
	#superclass : #BrList,
	#category : #'Brick-List-Elements'
}

{ #category : #initialization }
BrGridList >> initialize [
	super initialize.

	self aptitude: BrGridListAptitude new.
	self layout: BlFrameLayout new.
	self matchParent
]

{ #category : #accessing }
BrGridList >> stencil: aListRowStencilBuilder [
	self aptitude itemStencilBuilder: aListRowStencilBuilder
]
