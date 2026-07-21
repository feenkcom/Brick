Class {
	#name : #BrTextHoverDynamicAttribute,
	#superclass : #BrTextHoverProtoAttribute,
	#category : 'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextHoverDynamicAttribute >> enterAction: anObject [
	enterAction := anObject
]

{ #category : #accessing }
BrTextHoverDynamicAttribute >> leaveAction: aBlock [
	self 
		assert: [ aBlock notNil ] 
		description: [ 'Leave action should be initialized' ].

	leaveAction := aBlock
]
