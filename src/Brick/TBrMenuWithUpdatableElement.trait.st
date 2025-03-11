Trait {
	#name : #TBrMenuWithUpdatableElement,
	#category : #'Brick-Menu - UI'
}

{ #category : #'event handling' }
TBrMenuWithUpdatableElement >> onUpdateRequestedAnnouncement: anAnnouncement [
	"This is called from the UI process."

	
]

{ #category : #'event handling' }
TBrMenuWithUpdatableElement >> subscribeToUpdatableMenuModel [
	super subscribeToMenuModel.
	self menuModel announcer weak
		when: BrMenuModelUpdateRequestedAnnouncement
		send: #onUpdateRequestedAnnouncement:
		to: self
]

{ #category : #'event handling' }
TBrMenuWithUpdatableElement >> unsubscribeFromUpdatableMenuModel [
	self userData
		at: BrMenuUpdateSubscriptions
		ifPresent: [ :aSubscriptions | 
			aSubscriptions unsubscribe.
			self userData removeKey: BrMenuUpdateSubscriptions ifAbsent: [  ] ]
		ifAbsent: [  ]
]

{ #category : #'private - updating' }
TBrMenuWithUpdatableElement >> updateElementSubscriptions [
	self unsubscribeFromUpdatableMenuModel.

	self menuModel updateSpecifications
		installOnMenuElement: self
		menuModel: self menuModel
]
