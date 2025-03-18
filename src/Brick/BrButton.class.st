Class {
	#name : #BrButton,
	#superclass : #BlElement,
	#traits : 'TBrEnableable + TBrLayoutAlignable + TBrLayoutResizable + TBrSizeAdjustable',
	#classTraits : 'TBrEnableable classTrait + TBrLayoutAlignable classTrait + TBrLayoutResizable classTrait + TBrSizeAdjustable classTrait',
	#instVars : [
		'labelModel',
		'iconModel',
		'interactiveModel'
	],
	#category : #'Brick-Button - UI'
}

{ #category : #'api - widget' }
BrButton >> action [
	^ self viewModel action
]

{ #category : #'api - widget' }
BrButton >> action: aValuable [
	"An action can be a block with three optional parameters:
	 - a UI element to which this button model is attached
	 - this button model
	 - a click or a key-down event
	[ :aButtonElement :aButtonModel :anEvent |  ].
	
	The action is evaluated if
	- a button is enabled, and
	- no key modifier is pressed.

	Button action must not be nil"

	self viewModel action: aValuable
]

{ #category : #'api - widget' }
BrButton >> actionWithModifiers: aBlockOrSymbolOrValuable [
	"Add an action that is executed when clicked with modifiers.
	An action can be a block with three optional parameters:
	 - a UI element to which this button model is attached
	 - this button model
	 - a click or a key-down event
	[ :aButtonElement :aButtonModel :anEvent |  ].
	
	The action is evaluated if
	- a button is enabled, and
	- a key modifier are pressed.

	Button action must not be nil"

	self viewModel actionWithModifiers: aBlockOrSymbolOrValuable
]

{ #category : #'api - widget' }
BrButton >> actionsWithModifiers [
	^ self viewModel actionsWithModifiers
]

{ #category : #'api - widget' }
BrButton >> actionsWithModifiers: aCollection [
	"A collection of actions that are executed when clicked with modifiers.
	Each action can be a block with three optional parameters:
	 - a UI element to which this button model is attached
	 - this button model
	 - a click or a key-down event
	[ :aButtonElement :aButtonModel :anEvent |  ].
	
	The actions are evaluated if
	- a button is enabled, and
	- a key modifier are pressed.

	Button actions must not be nil"

	self viewModel actionsWithModifiers: aCollection
]

{ #category : #layout }
BrButton >> baselineOffset [
	^ self
		childWithId: #label
		ifFound: [ :aTextElement | aTextElement baselineOffset + self padding top + aTextElement margin top ]
		ifNone: [ 0 ]
]

{ #category : #accessing }
BrButton >> gtActionFor: aView [
	<gtView>
	self action ifNil: [ ^ aView empty ].
	self action blocDefiningMethod = (BrButtonModel >> #initialize)
		ifTrue: [ ^ aView empty ].

	^ (self action gtSourceCodeFor: aView)
		title: 'Action';
		priority: 20
]

{ #category : #'api - widget' }
BrButton >> icon [
	^ iconModel icon
]

{ #category : #'api - widget' }
BrButton >> icon: anElement [
	iconModel icon: anElement
]

{ #category : #initialization }
BrButton >> initialize [
	super initialize.

	self
		hFitContent;
		vLocal;
		beNormalSize;
		alignCenter.
	
	self viewModel: (BrButtonModel new +
		(labelModel := BrLabelModel new) +
		(iconModel := BrIconModel new))
]

{ #category : #'api - widget' }
BrButton >> label [
	^ labelModel text
]

{ #category : #'api - widget' }
BrButton >> label: aStringOrBrText [
	labelModel text: aStringOrBrText
]

{ #category : #'api - widget' }
BrButton >> model [
	^ self viewModel model
]

{ #category : #'api - widget' }
BrButton >> model: anObject [
	self viewModel model: anObject
]

{ #category : #layout }
BrButton >> supportsBaseline [
	^ self
		childWithId: #label
		ifFound: [ :aLabel | true ]
		ifNone: [ false ]
]
