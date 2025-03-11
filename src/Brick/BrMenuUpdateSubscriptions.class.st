Class {
	#name : #BrMenuUpdateSubscriptions,
	#superclass : #Object,
	#instVars : [
		'subscriptions',
		'elementFuture',
		'menuModel'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'event handling' }
BrMenuUpdateSubscriptions >> handleAnnouncement: anAnnouncement [
	^ true
]

{ #category : #initialization }
BrMenuUpdateSubscriptions >> initialize [
	super initialize.
	subscriptions := OrderedCollection new: 1
]

{ #category : #'api - initialization' }
BrMenuUpdateSubscriptions >> menuElement: aMenuElement [
	elementFuture := (BrAsyncElementFuture on: aMenuElement)
			whenSuccess: [ :anElement :aBoolean | self updateMenuElement: anElement with: aBoolean ]
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
	elementFuture ifNil: [ ^ self ].
	
	elementFuture future: [ self handleAnnouncement: anAnnouncement ] asAsyncFuture.
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
BrMenuUpdateSubscriptions >> updateMenuElement: anElement with: aBoolean [
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
