Class {
	#name : #BrMenuModelUpdateSpecifications,
	#superclass : #Object,
	#instVars : [
		'specifications'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #initialization }
BrMenuModelUpdateSpecifications >> initialize [
	super initialize.
	specifications := Array empty
]

{ #category : #'api - updating' }
BrMenuModelUpdateSpecifications >> installOnMenuElement: aMenuElement menuModel: aMenuModel [
	self specifications ifEmpty: [ ^ self ].

	BrMenuUpdateSubscriptionsBuilder new
		menuElement: aMenuElement;
		menuModel: aMenuModel;
		specifications: self specifications;
		build;
		install
]

{ #category : #'api - initialization' }
BrMenuModelUpdateSpecifications >> specification: anUpdateSpecification [
	self specifications: (self specifications copyWith: anUpdateSpecification)
]

{ #category : #accessing }
BrMenuModelUpdateSpecifications >> specifications [
	^ specifications ifNil: [ specifications := Array empty ]
]

{ #category : #accessing }
BrMenuModelUpdateSpecifications >> specifications: aCollection [
	specifications := aCollection
]

{ #category : #'api - initialization' }
BrMenuModelUpdateSpecifications >> updateWhen: anAnnouncementClassOrBlock from: anAnnouncerOrBlock [
	self
		specification: (BrMenuModelUpdateSpecification new
				announcement: anAnnouncementClassOrBlock;
				announcer: anAnnouncerOrBlock)
]
