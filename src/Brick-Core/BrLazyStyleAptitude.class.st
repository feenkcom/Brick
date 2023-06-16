Class {
	#name : #BrLazyStyleAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBlElementQuery',
	#classTraits : 'TBlElementQuery classTrait',
	#instVars : [
		'styles',
		'targetQuery'
	],
	#category : #'Brick-Core-Core'
}

{ #category : #'private - adding' }
BrLazyStyleAptitude >> computeStylestoAdd [
	^ targetQuery isEmpty
		ifTrue: [ styles styles ]
		ifFalse: [ styles styles collect: [ :eachStyle |
				BlForwardedStyle new
					state: eachStyle state;
					targetObject: targetQuery;
					style: eachStyle ] ]
]

{ #category : #initialization }
BrLazyStyleAptitude >> initialize [
	super initialize.

	styles := BlLazyStyles new.
	"empty selector, which means we apply it on the widget itself"
	targetQuery := BlElementLazyQuery new
]

{ #category : #'api - hooks' }
BrLazyStyleAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.	
	
	anElement styles addStyles: self computeStylestoAdd
]

{ #category : #'api - hooks' }
BrLazyStyleAptitude >> onUninstalledIn: anElement [
	super onUninstalledIn: anElement.
	
	anElement styles removeStyles: self computeStylestoAdd
]

{ #category : #accessing }
BrLazyStyleAptitude >> queryStep: aBlElementStep [
	targetQuery queryStep: aBlElementStep
]

{ #category : #accessing }
BrLazyStyleAptitude >> state [
	^ BlElementState
]

{ #category : #'private - adding' }
BrLazyStyleAptitude >> updateWith: aBlock [
	"Evaluate a given block that is suppose to change aptitude properties that are used to define styles and attempt to dynamically update an element"

	aBlock ensure: [
		self widgetDo: [ :anElement |
			styles clearCache.
			"plaese note that we should request the style recomputation of the widget itself and we shouldn't compute the target element (query) manually because they are forwarded from the widget itself"
			anElement requestStyle ] ]
]

{ #category : #'private - adding' }
BrLazyStyleAptitude >> when: aStateBlock style: aStyleBlock [
	| aTargetState |
	
	aTargetState := aStateBlock gtValueWithArgs: { self state }.
	styles
		addStyleFor: aTargetState
		computation: aStyleBlock
]
