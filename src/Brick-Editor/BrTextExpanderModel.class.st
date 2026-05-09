Class {
	#name : #BrTextExpanderModel,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'isExpanded'
	],
	#category : #'Brick-Editor-Attributes - Support'
}

{ #category : #accessing }
BrTextExpanderModel >> announcer [
	^ announcer
]

{ #category : #initialization }
BrTextExpanderModel >> initialize [
	super initialize.
	announcer := Announcer new.
	isExpanded := false.
]

{ #category : #accessing }
BrTextExpanderModel >> isExpanded [
	^ isExpanded ifNil: [ false ]
]

{ #category : #accessing }
BrTextExpanderModel >> isExpanded: aBoolean [
	self assert: [ aBoolean == true or: [ aBoolean == false ] ].

	isExpanded = aBoolean ifTrue: [ ^ self ].
	
	isExpanded := aBoolean.
	
	self notifyExpansionChanged
]

{ #category : #'private - notifying' }
BrTextExpanderModel >> notifyExpansionChanged [
	announcer
		announce: (BrTextExpanderModelExpansionChangedAnnouncement new
				expanderModel: self;
				isExpanded: self isExpanded)
]

{ #category : #'api - subscriptions' }
BrTextExpanderModel >> unsubscribe: aSubscriber [
	^ announcer unsubscribe: aSubscriber
]

{ #category : #'api - subscriptions' }
BrTextExpanderModel >> when: anAnnouncementClass send: aMessageSelector to: aSubscriber [
	^ announcer weak
		when: anAnnouncementClass
		send: aMessageSelector
		to: aSubscriber
]

{ #category : #'api - subscriptions' }
BrTextExpanderModel >> whenExpansionChangedSend: aMessageSelector to: aSubscriber [
	^ announcer weak
		when: BrTextExpanderModelExpansionChangedAnnouncement
		send: aMessageSelector
		to: aSubscriber
]
