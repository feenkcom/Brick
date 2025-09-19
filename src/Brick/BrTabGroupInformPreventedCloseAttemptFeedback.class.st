Class {
	#name : #BrTabGroupInformPreventedCloseAttemptFeedback,
	#superclass : #Object,
	#traits : 'TBrTabGroupPreventedCloseAttemptFeedback',
	#classTraits : 'TBrTabGroupPreventedCloseAttemptFeedback classTrait',
	#instVars : [
		'element'
	],
	#category : #'Brick-Tabs - Support'
}

{ #category : #accessing }
BrTabGroupInformPreventedCloseAttemptFeedback >> element [
	^ element
]

{ #category : #accessing }
BrTabGroupInformPreventedCloseAttemptFeedback >> element: anElement [
	element := anElement
]

{ #category : #'api - feedback' }
BrTabGroupInformPreventedCloseAttemptFeedback >> provide [
	element ifNil: [ ^ self ].
	element dispatchEvent: BrTagGroupPreventedCloseAttemptEvent new
]
