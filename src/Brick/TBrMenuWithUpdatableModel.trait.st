Trait {
	#name : #TBrMenuWithUpdatableModel,
	#instVars : [
		'updateSpecifications'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - updates' }
TBrMenuWithUpdatableModel >> defaultUpdateSpecifications [
	^ BrMenuModelUpdateSpecifications new
]

{ #category : #'api - updates' }
TBrMenuWithUpdatableModel >> onUpdateRequest [
	"Must be called from the UI process."

	self announcer
		announce: (BrMenuModelUpdateRequestedAnnouncement new menuModel: self)
]

{ #category : #'api - updates' }
TBrMenuWithUpdatableModel >> updateSpecifications [
	^ updateSpecifications ifNil: [ updateSpecifications := self defaultUpdateSpecifications ]
]

{ #category : #'api - updates' }
TBrMenuWithUpdatableModel >> updateWhen: anAnnouncementClassOrBlock from: anAnnouncerOrBlock [
	self updateSpecifications updateWhen: anAnnouncementClassOrBlock from: anAnnouncerOrBlock
]
