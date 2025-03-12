Class {
	#name : #BrMenuUpdateSubscriptionsBuilder,
	#superclass : #Object,
	#instVars : [
		'menuElement',
		'menuModel',
		'specifications',
		'subscriptions'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - building' }
BrMenuUpdateSubscriptionsBuilder >> build [
	menuElement ifNil: [ ^ self ].
	menuModel ifNil: [ ^ self ].
	specifications ifNil: [ ^ self ].
	specifications ifEmpty: [ ^ self ].

	subscriptions := BrMenuUpdateSubscriptions new
		menuElement: menuElement;
		menuModel: menuModel.
	self buildSubscriptions.
]

{ #category : #'api - building' }
BrMenuUpdateSubscriptionsBuilder >> buildSubscriptions [
	specifications do: [ :eachSpecification | 
		| anAnnouncer anAnnouncement |
		anAnnouncer := eachSpecification announcer.
		anAnnouncement := eachSpecification announcement.
		subscriptions updateWhen: anAnnouncement from: anAnnouncer ]
]

{ #category : #'api - building' }
BrMenuUpdateSubscriptionsBuilder >> install [
	subscriptions ifNil: [ self build ].
	subscriptions ifNil: [ ^ self ].

	menuElement userData at: BrMenuUpdateSubscriptions put: subscriptions.
]

{ #category : #accessing }
BrMenuUpdateSubscriptionsBuilder >> menuElement [
	^ menuElement
]

{ #category : #accessing }
BrMenuUpdateSubscriptionsBuilder >> menuElement: anObject [
	menuElement := anObject
]

{ #category : #accessing }
BrMenuUpdateSubscriptionsBuilder >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrMenuUpdateSubscriptionsBuilder >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #accessing }
BrMenuUpdateSubscriptionsBuilder >> specifications [
	^ specifications
]

{ #category : #accessing }
BrMenuUpdateSubscriptionsBuilder >> specifications: anObject [
	specifications := anObject
]
