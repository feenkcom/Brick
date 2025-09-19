Class {
	#name : #BrTabGroupActionPreventionContentChildReason,
	#superclass : #BrTabGroupActionPreventionReason,
	#instVars : [
		'contentElement',
		'childElement',
		'feedback'
	],
	#category : #'Brick-Tabs - Support'
}

{ #category : #accessing }
BrTabGroupActionPreventionContentChildReason >> childElement [
	^ childElement
]

{ #category : #accessing }
BrTabGroupActionPreventionContentChildReason >> childElement: anObject [
	childElement := anObject
]

{ #category : #accessing }
BrTabGroupActionPreventionContentChildReason >> contentElement [
	^ contentElement
]

{ #category : #accessing }
BrTabGroupActionPreventionContentChildReason >> contentElement: anObject [
	contentElement := anObject
]

{ #category : #'api - feedback' }
BrTabGroupActionPreventionContentChildReason >> feedback [
	^ feedback
]

{ #category : #'api - feedback' }
BrTabGroupActionPreventionContentChildReason >> feedback: aFeedback [
	<return: #TBrTabGroupPreventedCloseAttemptFeedback or: nil>
	feedback := aFeedback
]

{ #category : #'api - feedback' }
BrTabGroupActionPreventionContentChildReason >> feedbackOnPreventedClose [
	feedback ifNil: [ ^ self ].
	feedback provide
]
