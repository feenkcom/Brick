Class {
	#name : #BrWithAnchoredAptitudeStencil,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'widget',
		'aptitude'
	],
	#category : #'Brick-Anchored - Look'
}

{ #category : #accessing }
BrWithAnchoredAptitudeStencil >> aptitude [
	^ aptitude
]

{ #category : #accessing }
BrWithAnchoredAptitudeStencil >> aptitude: anObject [
	aptitude := anObject
]

{ #category : #accessing }
BrWithAnchoredAptitudeStencil >> buildDefault [
	^ BlElement new
]

{ #category : #accessing }
BrWithAnchoredAptitudeStencil >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self widget;
		push: self aptitude
]

{ #category : #accessing }
BrWithAnchoredAptitudeStencil >> reset [
	super reset.
	
	widget := nil.
	aptitude := nil
]

{ #category : #accessing }
BrWithAnchoredAptitudeStencil >> widget [
	^ widget
]

{ #category : #accessing }
BrWithAnchoredAptitudeStencil >> widget: anObject [
	widget := anObject
]
