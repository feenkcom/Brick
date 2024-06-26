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
		'action'
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
	"An action can be a block with two optional parameters:
	 - a UI element to which this button model is attached
	 - this button model
	[ :aButtonElement :aButtonModel :anEvent |  ].

	Button action must not be nil"

	self
		assert: [ aBlockOrSymbolOrValuable isNotNil ]
		description: [ 'Button action must not be nil' ].

	action := aBlockOrSymbolOrValuable
]

{ #category : #'mouse handlers' }
BrButtonModel >> clickEvent: anEvent [
	anEvent consumed: true.
	
	(self widget states hasState: BlElementState disabled)
		ifFalse: [ self action gtValueWithArgs: { self widget . self . anEvent } ]
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

	action := [ :anElement :aButtonModel :anEvent | ]
]

{ #category : #initialization }
BrButtonModel >> initializeListeners [
	self
		when: BlClickEvent
		do: [ :anEvent | (self hasModifiers: anEvent) ifFalse: [ self clickEvent: anEvent ] ].
	self
		when: BlFocusInEvent
		do: [ self
				when: BlKeyDownEvent
				do: [ :anEvent | anEvent key isReturn ifTrue: [ self clickEvent: anEvent ] ] ].

	self
		when: BlFocusOutEvent
		do: [ self when: BlKeyDownEvent do: [ :anEvent |  ] ]
]
