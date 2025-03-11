Class {
	#name : #BrMenuModelUpdateSpecification,
	#superclass : #Object,
	#instVars : [
		'announcementBlock',
		'announcerBlock'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - initialization' }
BrMenuModelUpdateSpecification >> announcement [
	^ announcementBlock value
]

{ #category : #'api - initialization' }
BrMenuModelUpdateSpecification >> announcement: anAnnouncementClassOrBlock [
	announcementBlock := anAnnouncementClassOrBlock
]

{ #category : #'api - initialization' }
BrMenuModelUpdateSpecification >> announcer [
	^ announcerBlock value
]

{ #category : #'api - initialization' }
BrMenuModelUpdateSpecification >> announcer: anAnnouncerOrBlock [
	announcerBlock := anAnnouncerOrBlock
]
