"
I handle asynchronous {{gtClass:BlElement}} update requests.
When {{gtMethod:BrElementUpdater>>#requestUpdate|label=#selector}} is called, I {{gtMethod:BrElementUpdater>>#postponeUpdate|label=schedule}} an update and execute an {{gtMethod:BrElementUpdater>>#action|label=#selector}}, when the {{gtClass:BlElement}} is  {{gtMethod:BlElement>>#isAttachedToSceneGraph|label=attached to a scene graph}}.
# Public API
- {{gtMethod:BrElementUpdater>>#element:|label=#selector}} a {{gtClass:BlElement}} on which updates are performed,
- {{gtMethod:BrElementUpdater>>#action:|label=#selector}} a valuable which is evaluated when it is time to update the {{gtClass:BlElement}},
- {{gtMethod:BrElementUpdater>>#element:selector:|label=#selector}} an utility method that combines the above two methods,
- {{gtMethod:BrElementUpdater >> #postponedDuration: | label=#selector}} a {{gtClass:Duration}} value defining how long to delay {{gtClass:BlElement}} updates,
- {{gtMethod:BrElementUpdater>>#requestUpdate|label=#selector}} schedules the {{gtClass:BlElement}} update.
# Example
### Requester Initialization
The following example indicates how I can be initialized, having a {{gtClass:BlElement}} with a given background: {{gtExample:BrElementUpdaterByScripterExamples >> #updaterInScripterAndElementInSpace | codeExpanded=false | previewExpanded=true}}
## Requesting Update
The background is updated on the {{gtMethod:BrElementUpdater>>#requestUpdate|label=request}} when the {{gtClass:BlElement}} is attached to a scene graph: {{gtExample:BrElementUpdaterByScripterExamples >> #updateRequest_AfterElementAddedInSceneGraph | codeExpanded=false | previewExpanded=true}}  

"
Class {
	#name : #BrElementUpdater,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'element',
		'mutex',
		'isUpdateRequested',
		'action',
		'postponedDuration',
		'payload'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #'private - accessing' }
BrElementUpdater >> action [
	"Return a valuable object that understands #cull:, receiving [ :anElement | ... ]"
	^ action 
]

{ #category : #'api - initialization' }
BrElementUpdater >> action: anAction [
	"Set an update action, an object that understands #cull:, receiving [ :anElement | ... ]"
	self assertAction: anAction.
	action := anAction.
]

{ #category : #'private - asserting' }
BrElementUpdater >> assertAction: anAction [ 
	self 
		assert: [ anAction isNotNil ] 
		description: [ 'Update action must be non-nil' ].
]

{ #category : #'private - asserting' }
BrElementUpdater >> assertElement: anElement [ 
	self 
		assert: [ anElement isNotNil ] 
		description: [ 'Element must be non-nil' ].
	self 
		assert: [ element isNil ] 
		description: [ 'Element can be initialized only once' ].
]

{ #category : #'private - asserting' }
BrElementUpdater >> assertPostponedDuration: aDuration [
	self 
		assert: [ aDuration isNotNil ] 
		description: [ 'Posponed duration must be non-nil' ].
]

{ #category : #'private - updating' }
BrElementUpdater >> beUpdateRequestedIfDoneEarlierDo: aBlock [
	mutex critical: [ 
		self isUpdateRequested ifTrue: aBlock.
		isUpdateRequested := true. ]
]

{ #category : #defaults }
BrElementUpdater >> defaultAction [
	^ [ :anElement | "do nothing" ]
]

{ #category : #defaults }
BrElementUpdater >> defaultPostponedDuration [
	^ 0 milliSeconds
]

{ #category : #'private - accessing' }
BrElementUpdater >> element [
	<return: #BlElement>
	^ element
]

{ #category : #'api - initialization' }
BrElementUpdater >> element: anElement [
	self assertElement: anElement.
	element := anElement.
	self subscribeToElement.
]

{ #category : #'api - initialization' }
BrElementUpdater >> element: anElement selector: aSelector [
	self element: anElement.
	self action: (MessageSend receiver: anElement selector: aSelector).
]

{ #category : #'private - accessing' }
BrElementUpdater >> elementDo: aBlock [
	self element ifNotNil: aBlock
]

{ #category : #'private - updating' }
BrElementUpdater >> emitEnqueueUpdateSignal [
	(BrElementUpdaterEnqueueUpdateSignal forUpdater: self) emit.
]

{ #category : #'private - updating' }
BrElementUpdater >> emitPerformUpdateSignal [
	(BrElementUpdaterPerformUpdateSignal forUpdater: self) emit.
]

{ #category : #'private - updating' }
BrElementUpdater >> enqueuePostponedUpdate [
	self
		elementDo: [ :anElement | 
			| aTask |
			anElement
				enqueueTask: (aTask := BrElementUpdaterPendingUpdateTask new updater: self).

			TaskAtQueue default 
				schedule: [ self enqueueUpdate. aTask beUpdated ] 
				at: self postponedTime ]
]

{ #category : #'private - updating' }
BrElementUpdater >> enqueueUpdate [
	self
		elementDo: [ :anElement | 
			self emitEnqueueUpdateSignal.

			anElement enqueueTask: (BrElementUpdaterUpdateTask new updater: self) ]
]

{ #category : #'gt-extensions' }
BrElementUpdater >> gtPreviewFor: aView [
	<gtView>
	self element ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		object: [ self element ];
		view: #gtLiveFor:
]

{ #category : #initialization }
BrElementUpdater >> initialize [
	super initialize.
	mutex := Mutex new.
	isUpdateRequested := false.
	action := self defaultAction.
	postponedDuration := self defaultPostponedDuration.
	payload := AsyncMutex for: nil
]

{ #category : #'private - testing' }
BrElementUpdater >> isUpdateRequested [
	<return: #Boolean>
	^ isUpdateRequested
]

{ #category : #'private - updating' }
BrElementUpdater >> mayUpdateNow [
	mutex critical: [ 
		self isUpdateRequested ifFalse: [ ^ self ] ]. 
	self updateNow
]

{ #category : #'private - event handling' }
BrElementUpdater >> onElementAddedToSceneGraph [
	self mayUpdateNow
]

{ #category : #'private - updating' }
BrElementUpdater >> postponeUpdate [
	self
		elementDo: [ :anElement | 
			self beUpdateRequestedIfDoneEarlierDo: [ ^ self ].
			BlUseAsyncFeatures
				ifEnabledDo: [ anElement isAttachedToSceneGraph ifFalse: [ ^ self ].	
				"Update requester should perform an update as soon as possible, especially if
				postponed delay (duration) is zero. It means that there should be no unnecessary skipped frames.
				What does it mean? Let's take a look at the frame phase order, roughly:
					- handle events
					- run tasks
					- redraw
				From usability and smoothness perspective all zero delay updates that are scheduled during event processing phase
				must be handled during tasks phase so that UI related changes appear on the screen within the same frame, without delays.
				If even one frame is skipped users would notice UI jumping/jiggling/flickering.

				We explicitly handle zero delay case by instantly enqueuing an update task to the element so that it can be processed
				as soon as possible. If there is a non-zero delay we schedule an update with the help of a TaskAt queue which may skip
				an undefined amount of frames."
					self postponedDuration isZero
						ifTrue: [ self enqueueUpdate ]
						ifFalse: [ self enqueuePostponedUpdate ] ]
				otherwise: [ self updateNow ] ]
]

{ #category : #'private - accessing' }
BrElementUpdater >> postponedDuration [
	<return: #Duration>
	^ postponedDuration ifNil: [ self defaultPostponedDuration ]
]

{ #category : #'api - initialization' }
BrElementUpdater >> postponedDuration: aDuration [
	self assertPostponedDuration: aDuration.
	postponedDuration := aDuration.
]

{ #category : #'private - updating' }
BrElementUpdater >> postponedTime [
	| aNow |
	self elementDo: [ :anElement | 
		aNow := anElement space 
			ifNotNil: [ :aSpace | aSpace time now ] 
			ifNil: [ BlTime real now ] ].
	aNow ifNil: [ aNow := BlTime real now ].
	^ aNow + self postponedDuration.
]

{ #category : #'api - updating' }
BrElementUpdater >> requestUpdate [
	self postponeUpdate.
]

{ #category : #'api - updating' }
BrElementUpdater >> requestUpdate: aPayloadObject [
	payload
		lock: [ :anExistingValue |
			payload value: aPayloadObject.
			self postponeUpdate ]
		ifNilPut: [ aPayloadObject ]
]

{ #category : #'private - updating' }
BrElementUpdater >> resetUpdateRequested [
	mutex critical: [ 
		isUpdateRequested := false ].
]

{ #category : #'private - subscriptions' }
BrElementUpdater >> subscribeToElement [

	self element
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | self onElementAddedToSceneGraph ]
]

{ #category : #'private - updating' }
BrElementUpdater >> updateElement [
	"I should be called from a UI process."
	self elementDo: [ :anElement |
		self action cull: anElement cull: payload value ]
]

{ #category : #'private - updating' }
BrElementUpdater >> updateNow [
	self emitPerformUpdateSignal.
	
	BrElementUpdaterTelemetry
		rootTimeSync: [ 
			Processor activeProcess name, ' - ', self class name]
		during: [
			self resetUpdateRequested.
			self updateElement. ]
]
