Class {
	#name : #BrElementUpdaterByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-Core'
}

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> basicUpdater [
	<gtExample>
	| anUpdater |
	anUpdater := BrElementUpdater new.
	self assert: anUpdater element isNil.
	self assert: anUpdater action isNotNil.
	self assert: anUpdater isUpdateRequested not.
	self assert: anUpdater postponedDuration equals: 0 seconds.
	self assert: anUpdater postponedDuration isZero.

	^ anUpdater
]

{ #category : #'examples - support' }
BrElementUpdaterByScripterExamples >> defaultBackgroundColor [
	^ Color yellow alpha: 0.2
]

{ #category : #'examples - support' }
BrElementUpdaterByScripterExamples >> element [
	<gtExample>
	^ BlElement new
		background: self defaultBackgroundColor;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c margin: (BlInsets all: 10) ].
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> postponedDuration [
	<gtExample>
	^ 300 milliSeconds
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> postponedUpdateRequest_AfterElementAddedInSceneGraph [
	<gtExample>
	| aScripter |
	aScripter := self postponedUpdaterInScripterAndElementInSpace.

	aScripter
		substep: 'Request update'
		do: [ :aStep | 
			aStep assert
				label: 'Assert inactive update request';
				do: [ :anUpdater | anUpdater isUpdateRequested not ];
				onModel;
				play.

			aStep do
				label: 'Send request';
				block: [ :anUpdater | anUpdater requestUpdate ];
				onModel;
				play.
				
			aStep assert
				label: 'Assert inactive update request';
				satisfies: [ :anUpdater | anUpdater isUpdateRequested not ];
				onModel;
				play.

			aStep assert
				label: 'Assert element background';
				satisfies: [ :anElement | anElement background = self updatedBackgroundColor asBlBackground ];
				onSelf;
				play ].

	^ aScripter
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> postponedUpdateRequest_BeforeElementAddedInSceneGraph [
	<gtExample>
	| aScripter |
	aScripter := self postponedUpdaterInScripterAndElementNotInSpace.

	aScripter
		substep: 'Request update'
		do: [ :aStep | 
			aStep assert
				label: 'Assert inactive update request';
				satisfies: [ :anUpdater | anUpdater isUpdateRequested not ];
				onModel;
				play.

			aStep do
				label: 'Send request';
				block: [ :anUpdater | anUpdater requestUpdate ];
				onModel;
				play.

			aStep assert
				label: 'Assert active update request';
				satisfies: [ :anUpdater | anUpdater isUpdateRequested ];
				onModel;
				play.

			aStep assert
				label: 'Assert element does not include a task';
				satisfies: [ :anUpdater | anUpdater element taskQueue isEmpty ];
				onModel;
				play.

			aStep assert
				label: 'Assert element not in space';
				satisfies: [ :anUpdater | anUpdater element space isNil ];
				onModel;
				play.

			aStep assert
				label: 'Assert element background color';
				satisfies: [ :anUpdater | anUpdater element background = self defaultBackgroundColor asBlBackground ];
				onModel;
				play ].

	aScripter
		substep: 'Add element into space'
		do: [ :aStep | 
			aStep set
				label: 'Add element into space';
				element: [ :aModel | aModel element ];
				onModel;
				play.

			aStep assert
				label: 'Assert inactive update request';
				satisfies: [ :anUpdater | anUpdater isUpdateRequested not ];
				onModel;
				play.

			aStep assert
				label: 'Assert element background color';
				satisfies: [ :anElement | anElement background = self updatedBackgroundColor asBlBackground ];
				onSelf;
				play ].

	^ aScripter
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> postponedUpdaterInScripterAndElementInSpace [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithModel: [ :aTarget :theScripter | self updaterWithElementAndPostponedAction ]
			element: [ :aModel | aModel element ].

	^ aScripter
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> postponedUpdaterInScripterAndElementNotInSpace [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter
		substep: 'Initialize Model and UI'
		do: [ :aStep | 
			aStep set
				label: 'Initialize Model';
				model: [ self updaterWithElementAndPostponedAction ];
				onScripter;
				play ].

	^ aScripter
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> updateRequest_AfterElementAddedInSceneGraph [
	<gtExample>
	| aScripter |
	aScripter := self updaterInScripterAndElementInSpace.

	aScripter
		substep: 'Request update'
		do: [ :aStep | 
			aStep assert
				label: 'Assert inactive update request';
				satisfies: [ :anUpdater | anUpdater isUpdateRequested not ];
				onModel;
				play.

			aStep do
				label: 'Send request';
				block: [ :anUpdater | anUpdater requestUpdate ];
				onModel;
				play.

			aStep assert
				label: 'Assert active update request';
				satisfies: [ :anUpdater | anUpdater isUpdateRequested not ];
				onModel;
				play.

			aStep assert
				label: 'Assert element background color';
				satisfies: [ :anElement | anElement background = self updatedBackgroundColor asBlBackground ];
				onSelf;
				play ].

	^ aScripter
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> updateRequest_BeforeElementAddedInSceneGraph [
	<gtExample>
	| aScripter |
	aScripter := self updaterInScripterAndElementNotInSpace.

	aScripter
		substep: 'Request update'
		do: [ :aStep | 
			aStep assert
				label: 'Assert inactive update request';
				satisfies: [ :anUpdater | anUpdater isUpdateRequested not ];
				onModel;
				play.

			aStep do
				label: 'Send request';
				block: [ :anUpdater | anUpdater requestUpdate ];
				onModel;
				play.

			aStep assert
				label: 'Assert active update request';
				satisfies: [ :anUpdater | anUpdater isUpdateRequested ];
				onModel;
				play.

			aStep assert
				label: 'Assert element not in space';
				satisfies: [ :anUpdater | anUpdater element space isNil ];
				onModel;
				play.

			aStep assert
				label: 'Assert element background color';
				satisfies: [ :anUpdater | anUpdater element background = self defaultBackgroundColor asBlBackground ];
				onModel;
				play ].

	aScripter
		substep: 'Add element into space'
		do: [ :aStep | 
			aStep set
				element: [ :aModel | aModel element ];
				onModel;
				play.

			aStep assert
				label: 'Assert inactive update request';
				satisfies: [ :anUpdater | anUpdater isUpdateRequested not ];
				onModel;
				play.

			aStep assert
				label: 'Assert element background color';
				satisfies: [ :anElement | anElement background = self updatedBackgroundColor asBlBackground ];
				onSelf;
				play ].

	^ aScripter
]

{ #category : #'examples - support' }
BrElementUpdaterByScripterExamples >> updatedBackgroundColor [
	^ Color blue alpha: 0.2
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> updaterInScripterAndElementInSpace [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithModel: [ :aTarget :theScripter | self updaterWithElementAndAction ]
			element: [ :aModel | aModel element ].

	^ aScripter
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> updaterInScripterAndElementNotInSpace [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter
		substep: 'Initialize Model and UI'
		do: [ :aStep | 
			aStep set
				label: 'Initialize Model';
				model: [ self updaterWithElementAndAction ];
				onScripter;
				play ].

	^ aScripter
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> updaterWithElementAndAction [
	<gtExample>
	| anUpdater anElement anAction |
	anUpdater := self basicUpdater.
	
	anElement := self element.
	anAction := [ :theElement | 
		theElement background: self updatedBackgroundColor ].
	
	anUpdater element: anElement.
	anUpdater action: anAction.
	
	self assert: anUpdater element equals: anElement.
	self assert: anUpdater action equals: anAction.
	self assert: anUpdater isUpdateRequested not.
	self assert: anElement taskQueue tasks size equals: 0.
	
	^ anUpdater
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> updaterWithElementAndPostponedAction [
	<gtExample>
	| anUpdater |
	anUpdater := self updaterWithElementAndAction.

	anUpdater := anUpdater postponedDuration: self postponedDuration.

	self assert: anUpdater postponedDuration equals: self postponedDuration.
	self assert: anUpdater postponedDuration isZero not.
	self assert: anUpdater isUpdateRequested not.
	self assert: anUpdater element taskQueue tasks size equals: 0.

	^ anUpdater
]
