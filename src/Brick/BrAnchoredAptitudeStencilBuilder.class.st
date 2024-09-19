Class {
	#name : #BrAnchoredAptitudeStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'widget'
	],
	#category : #'Brick-Anchored - Look'
}

{ #category : #accessing }
BrAnchoredAptitudeStencilBuilder >> buildDefault [
	^ BlElement new
]

{ #category : #accessing }
BrAnchoredAptitudeStencilBuilder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self widget
]

{ #category : #accessing }
BrAnchoredAptitudeStencilBuilder >> reset [
	super reset.
	
	widget := nil
]

{ #category : #accessing }
BrAnchoredAptitudeStencilBuilder >> widget [
	^ widget
]

{ #category : #accessing }
BrAnchoredAptitudeStencilBuilder >> widget: anObject [
	widget := anObject
]
