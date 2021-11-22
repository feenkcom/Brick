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
BrElementUpdaterByScripterExamples >> updateRequest_AfterElementAddedInSceneGraph [

	<gtExample>
	| aScripter |
	aScripter := self updaterInScripterAndElementInSpace.

	aScripter substep: 'Request update' do: [ :aStep | 
	
		aStep check
			label: 'Check inactive update request';
			do: [ :anUpdater | anUpdater isUpdateRequested not ];
			onModel;
			play.

		aStep do
			label: 'Send request';
			block: [ :anUpdater | anUpdater requestUpdate ];
			onModel;
			play.

		aStep check
			label: 'Check active update request';
			do: [ :anUpdater | anUpdater isUpdateRequested ];
			onModel;
			play.

		aStep wait
			forEnqueuedSpaceTaskTimeout: 5 seconds;
			play.

		aStep wait
			forSemaphore: (aScripter userData at: #updaterSemaphore)
			timeoutSeconds: 5;
			play.

		aStep wait
			forEmptySpaceTaskQueueTimeout: 5 seconds;
			play.

		aStep check
			label: 'Check inactive update request';
			do: [ :anUpdater | anUpdater isUpdateRequested not ];
			onModel;
			play.

		aStep check
			label: 'Check empty element task queue';
			do: [ :anElement | anElement taskQueue tasks size isZero ];
			onSelf;
			play ].

	^ aScripter syncContinue
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> updateRequest_BeforeElementAddedInSceneGraph [

	<gtExample>
	| aScripter |
	aScripter := self updaterInScripterAndElementNotInSpace.

	aScripter substep: 'Request update' do: [ :aStep | 
		aStep check
			label: 'Check inactive update request';
			do: [ :anUpdater | anUpdater isUpdateRequested not ];
			onModel;
			play.

		aStep do
			label: 'Send request';
			block: [ :anUpdater | anUpdater requestUpdate ];
			onModel;
			play.

		aStep wait
			forEnqueuedSpaceTaskTimeout: 5 seconds;
			play.

		aStep check
			label: 'Check active update request';
			do: [ :anUpdater | anUpdater isUpdateRequested ];
			onModel;
			play.

		aStep check
			label: 'Check element does not include a task';
			do: [ :anUpdater | anUpdater element taskQueue isEmpty ];
			onModel;
			play.

		aStep check
			label: 'Check element not in space';
			do: [ :anUpdater | anUpdater element space isNil ];
			onModel;
			play ].

	aScripter substep: 'Add element into space' do: [ :aStep | 
		aStep set
			element: [ :aModel | aModel element ];
			onModel;
			play.

		aStep check
			label: 'Check active update request';
			do: [ :anUpdater | anUpdater isUpdateRequested ];
			onModel;
			play.

		aStep wait
			forEnqueuedSpaceTaskTimeout: 5 seconds;
			play.

		aStep wait
			forSemaphore: (aScripter userData at: #updaterSemaphore)
			timeoutSeconds: 5;
			play.

		aStep wait
			forEmptySpaceTaskQueueTimeout: 5 seconds;
			play.

		aStep check
			label: 'Check inactive update request';
			do: [ :anUpdater | anUpdater isUpdateRequested not ];
			onModel;
			play.

		aStep check
			label: 'Check empty element task queue';
			do: [ :anElement | anElement taskQueue tasks size isZero ];
			onSelf;
			play ].

	^ aScripter syncContinue
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> updateRequest_ElementNotInSceneGraph [
	<gtExample>
	| anUpdater aSemaphore aTimeout |
	aSemaphore := Semaphore new.
	anUpdater := self updaterWithElementAndAction.
	anUpdater requestUpdate.
	BlTaskAtQueue default
		schedule: [ 
			100 milliSeconds wait. 
			aSemaphore signal ]
		at: anUpdater postponedTime.
	aTimeout := aSemaphore waitTimeoutSeconds: 5.
	self 
		assert: aTimeout not 
		description: 'Semaphore was not signaled on time'.
	self assert: anUpdater isUpdateRequested.
	self assert: anUpdater element taskQueue tasks size equals: 0.
	^ anUpdater
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
		             scripterWithModel: [ :aTarget :theScripter |
		             	| anUpdater anOriginAction aSemaphore |
		             	aSemaphore := Semaphore new.
		             	theScripter userData at: #updaterSemaphore put: aSemaphore.
		             	anUpdater := self updaterWithElementAndAction.
		             	anOriginAction := anUpdater action.
		             	anUpdater action: [ :theElement | 
		             		anOriginAction cull: theElement.
		             		aSemaphore signal ].
		             	anUpdater ]
		             element: [ :aModel | aModel element ].

	^ aScripter syncContinue
]

{ #category : #'examples - updater' }
BrElementUpdaterByScripterExamples >> updaterInScripterAndElementNotInSpace [

	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter substep: 'Initialize Model and UI' do: [ :aStep | 
		aStep set
			label: 'Initialize Model';
			model: [ :aTarget :theScripter | 
				| anUpdater anOriginAction aSemaphore |
				aSemaphore := Semaphore new.
				theScripter userData at: #updaterSemaphore put: aSemaphore.
				anUpdater := self updaterWithElementAndAction.
				anOriginAction := anUpdater action.
				anUpdater action: [ :theElement | 
						anOriginAction cull: theElement.
						aSemaphore signal ].
				anUpdater ];
			onScripter;
			play ].

	^ aScripter syncContinue
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
