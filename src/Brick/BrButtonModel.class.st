"
# Button model

Button - An element of a graphical user interface which a user can select to perform a particular action.
(https://en.oxforddictionaries.com/definition/button)

I know how to react on a typical user action such as click or touch event. My reaction is defined by an `#action` which can be any valuable:  {{gtClass:BlockClosure}}, {{gtClass:Symbol}} or any object that responds to `#value`

I am not responsible for labels or icons since buttons not necessarily have them.

See {{gtClass:BrButtonModelExamples}} for examples

"
Class {
	#name : #BrButtonModel,
	#superclass : #BrWidgetModel,
	#instVars : [
		'action',
		'actionsWithModifiers'
	],
	#category : #'Brick-Button - Model'
}

{ #category : #printing }
BrButtonModel class >> modelName [
	^ 'Button'
]

{ #category : #'api - widget' }
BrButtonModel >> action [
	<return: #BlockClosure or: #Symbol or: #Valuable>
	
	^ action
]

{ #category : #'api - widget' }
BrButtonModel >> action: aBlockOrSymbolOrValuable [
	"An action can be a block with three optional parameters:
	 - a UI element to which this button model is attached
	 - this button model
	 - a click or a key-down event
	[ :aButtonElement :aButtonModel :anEvent |  ].
	
	The action is evaluated if
	- a button is enabled, and
	- no key modifier is pressed.

	Button action must not be nil"

	self
		assert: [ aBlockOrSymbolOrValuable isNotNil ]
		description: [ 'Button action must not be nil' ].

	action := aBlockOrSymbolOrValuable
]

{ #category : #'api - widget' }
BrButtonModel >> actionWithModifiers: aBlockOrSymbolOrValuable [
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

	self
		assert: [ aBlockOrSymbolOrValuable isNotNil ]
		description: [ 'Button action wit modifiers must not be nil' ].

	actionsWithModifiers := self actionsWithModifiers copyWith: aBlockOrSymbolOrValuable
]

{ #category : #'api - widget' }
BrButtonModel >> actionsWithModifiers [
	<return: #Array of: #BlockClosure>
	^ actionsWithModifiers ifNil: [ actionsWithModifiers := Array empty ]
]

{ #category : #'api - widget' }
BrButtonModel >> actionsWithModifiers: aCollection [
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
	
	self
		assert: [ aCollection allSatisfy: #isNotNil ]
		description: [ 'Button actions with modifiers must not be nil' ].
	
	actionsWithModifiers := aCollection
]

{ #category : #'mouse handlers' }
BrButtonModel >> clickEvent: anEvent [
	(self hasModifiers: anEvent)
		ifFalse: [ self clickWithoutModifiersEvent: anEvent ]
		ifTrue: [ self clickWithModifiersEvent: anEvent ]
]

{ #category : #'mouse handlers' }
BrButtonModel >> clickWithModifiersEvent: anEvent [
	self actionsWithModifiers ifEmpty: [ ^ self ].

	anEvent consumed: true.
	
	(self widget states hasState: BlElementState disabled) ifTrue: [ ^ self ].
	
	self actionsWithModifiers do: [ :eachAction |
		eachAction gtValueWithArgs: { self widget . self . anEvent } ]
]

{ #category : #'mouse handlers' }
BrButtonModel >> clickWithoutModifiersEvent: anEvent [
	anEvent consumed: true.
	
	(self widget states hasState: BlElementState disabled) ifTrue: [ ^ self ].
	
	self action gtValueWithArgs: { self widget . self . anEvent }
]

{ #category : #'mouse handlers' }
BrButtonModel >> disableAllModifiers [
	enableAllModifiers := false
]

{ #category : #'mouse handlers' }
BrButtonModel >> enableAllModifiers [
	enableAllModifiers := true
]

{ #category : #'gt-extension' }
BrButtonModel >> gtActionFor: aView [
	<gtView>
	
	self action isClosure
		ifFalse: [ ^ aView empty ].
		
	^ aView forward
		title: 'Action';
		priority: 1;
		object: [ self action ];
		view: #gtSourceCodeFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Action' 
			tooltip: 'Inspect action object' 
			action: [ :aButton | aButton phlow spawnObject: self action ]
]

{ #category : #initialization }
BrButtonModel >> hasModifiers: anEvent [

	"Return true if any modifiers are pressed"

	<return: #Boolean>
	^ anEvent modifiers isAlt or: [ 
		  anEvent modifiers isCmd or: [ 
			  anEvent modifiers isCtrl or: [ 
				  anEvent modifiers isShift ] ] ]
]

{ #category : #initialization }
BrButtonModel >> initialize [
	super initialize.

	action := [ :anElement :aButtonModel :anEvent | ].
	actionsWithModifiers := #().
]

{ #category : #initialization }
BrButtonModel >> initializeListeners [
	self
		when: BlClickEvent
		do: [ :anEvent | self clickEvent: anEvent ].
	
	self 
		when: BlKeyDownEvent
		do: [ :anEvent | 
			anEvent key isReturn ifTrue: [ self clickEvent: anEvent ] ].
]
