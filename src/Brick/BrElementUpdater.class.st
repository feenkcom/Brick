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
		'postponedDuration'
	],
	#category : 'Brick-! Core - Support'
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
	^ 100 milliSeconds
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
BrElementUpdater >> enqueueUpdate [
	self elementDo: [ :anElement | 
		anElement enqueueTask: (BlTaskAction new action: [
			self updateNow ]) ].
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
BrElementUpdater >> onElementAddedTooSceneGraph [
	self mayUpdateNow
]

{ #category : #'private - updating' }
BrElementUpdater >> postponeUpdate [
	self elementDo: [ :anElement | 
		self beUpdateRequestedIfDoneEarlierDo: [ ^ self ].
		BlUseAsyncFeatures 
			ifEnabledDo: [ 
				anElement isAttachedToSceneGraph
					ifFalse: [ ^ self ].
				
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
					ifFalse: [
						BlTaskAtQueue default
							schedule: [ self enqueueUpdate ]
							at: self postponedTime ] ]
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

{ #category : #'private - updating' }
BrElementUpdater >> resetUpdateRequested [
	mutex critical: [ 
		isUpdateRequested := false ].
]

{ #category : #'private - subscriptions' }
BrElementUpdater >> subscribeToElement [
	self element
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | self onElementAddedTooSceneGraph ]
]

{ #category : #'private - updating' }
BrElementUpdater >> updateElement [
	"I should be called from a UI process."
	self elementDo: [ :anElement | 
		self action cull: anElement ]
]

{ #category : #'private - updating' }
BrElementUpdater >> updateNow [
	self resetUpdateRequested.
	self updateElement.
]
