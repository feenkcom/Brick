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
BrLazyStyleAptitude >> when: aStateBlock style: aStyleBlock [
	| aTargetState |
	
	aTargetState := aStateBlock gtValueWithArgs: { self state }.
	styles
		addStyleFor: aTargetState
		computation: aStyleBlock
]
