"
I am a {{gtClass:BrMenuModelAnnouncement}}. 
I notify that an {{gtClass:BrMenuModel}} action should be performed, e.g., {{gtMethod: BrMenuActionItem >> #action | label=menu item action}}. 
"
Class {
	#name : #BrMenuModelActionRequestedAnnouncement,
	#superclass : #BrMenuModelAnnouncement,
	#instVars : [
		'isConsumed'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuModelActionRequestedAnnouncement >> consumed: aBoolean [
	isConsumed := aBoolean
]

{ #category : #accessing }
BrMenuModelActionRequestedAnnouncement >> isConsumed [
	^ isConsumed ifNil: [ isConsumed := false ]
]
