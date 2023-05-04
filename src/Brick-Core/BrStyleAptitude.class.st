Class {
	#name : #BrStyleAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBlElementQuery',
	#classTraits : 'TBlElementQuery classTrait',
	#instVars : [
		'styles',
		'targetQuery'
	],
	#category : #'Brick-Core-Core'
}

{ #category : #initialization }
BrStyleAptitude >> initialize [
	super initialize.

	styles := BlEagerStyles new.

	"empty selector, which means we apply it on the widget itself"
	targetQuery := BlElementLazyQuery new
]

{ #category : #'api - hooks' }
BrStyleAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.
	
	targetQuery isEmpty
		ifFalse: [ styles := styles asForwarded: targetQuery ].

	anElement styles addStyles: styles styles
]

{ #category : #'api - hooks' }
BrStyleAptitude >> onUninstalledIn: anElement [
	super onUninstalledIn: anElement.
	
	anElement styles removeStyles: styles styles
]

{ #category : #initialization }
BrStyleAptitude >> propagateStylesToWidget [
	"Call me if this look is updated after its creation"

	self widgetDo: [ :aWidget |
		aWidget styles addStyles: styles styles.
		aWidget requestStyle ]
]

{ #category : #accessing }
BrStyleAptitude >> queryStep: aBlElementStep [
	targetQuery queryStep: aBlElementStep
]

{ #category : #accessing }
BrStyleAptitude >> state [
	^ BlElementState
]

{ #category : #'private - adding' }
BrStyleAptitude >> styleFor: anElementState [
	^ styles styleFor: anElementState
]

{ #category : #'private - adding' }
BrStyleAptitude >> when: aStateBlock style: aStyleBlock [
	| aTargetState |
	
	aTargetState := aStateBlock gtValueWithArgs: { self state }.
	aStyleBlock value: (self styleFor: aTargetState)
]
