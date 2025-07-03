Class {
	#name : #BrGlamorousMaximizerFullscreenHostAptitude,
	#superclass : #BrMaximizerHostAptitude,
	#category : #'Brick-Glamorous-Maximizer'
}

{ #category : #'private - hooks' }
BrGlamorousMaximizerFullscreenHostAptitude >> createCloseButton [
	^ BrGlamorousMaximizerCloseButtonStencil new asElement
]

{ #category : #'private - hooks' }
BrGlamorousMaximizerFullscreenHostAptitude >> onMaximize: aMaximizeWish [
	| containerElement |
	containerElement := BlElement new
		background: aMaximizeWish preferredBackground;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c ignoreByLayout ].
			
	BrGlamorousMaximizerSwitcher new
		maximizerAptitude: aMaximizeWish maximizerAptitude;
		hostElement: self widget;
		elementToMaximize: aMaximizeWish elementToMaximize;
		containerElement: containerElement;
		closeButton: self createCloseButton;
		switch
]
