Class {
	#name : #BrMenuUpdateSubscriptions,
	#superclass : #Object,
	#instVars : [
		'subscriptions',
		'menuModel',
		'elementUpdater'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #initialization }
BrMenuUpdateSubscriptions >> initialize [
	super initialize.
	subscriptions := OrderedCollection new: 1
]

{ #category : #'api - initialization' }
BrMenuUpdateSubscriptions >> menuElement: aMenuElement [
	elementUpdater := BrElementUpdater new
			postponedDuration: 100 milliSeconds;
			element: aMenuElement;
			action: (MessageSend receiver: self selector: #updateMenuElement)
]

{ #category : #accessing }
BrMenuUpdateSubscriptions >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrMenuUpdateSubscriptions >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #'event handling' }
BrMenuUpdateSubscriptions >> onAnnouncement: anAnnouncement [
	elementUpdater ifNil: [ ^ self ].

	elementUpdater requestUpdate
]

{ #category : #accessing }
BrMenuUpdateSubscriptions >> subscriptions [
	^ subscriptions
]

{ #category : #'api - subscriptions' }
BrMenuUpdateSubscriptions >> unsubscribe [
	self subscriptions
		do: [ :eachSubscription | eachSubscription announcer removeSubscription: eachSubscription ]
]

{ #category : #'event handling' }
BrMenuUpdateSubscriptions >> updateMenuElement [
	menuModel onUpdateRequest
]

{ #category : #'api - initialization' }
BrMenuUpdateSubscriptions >> updateWhen: anAnnouncement from: anAnnouncer [
	| aSubscription |
	aSubscription := anAnnouncer weak
			when: anAnnouncement
			send: #onAnnouncement:
			to: self.
			
	subscriptions add: aSubscription
]
