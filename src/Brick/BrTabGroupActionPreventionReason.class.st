Class {
	#name : #BrTabGroupActionPreventionReason,
	#superclass : #Object,
	#classVars : [
		'NoReason'
	],
	#category : #'Brick-Tabs - Support'
}

{ #category : #'api - preventors' }
BrTabGroupActionPreventionReason class >> noReason [
	^ NoReason ifNil: [ NoReason := BrTabGroupActionNoPreventionReason new ]
]

{ #category : #'api - preventors' }
BrTabGroupActionPreventionReason class >> preventedByContent: aContentElement child: aChildElement [
	^ BrTabGroupActionPreventionContentChildReason new
		contentElement: aContentElement;
		childElement: aChildElement;
		feedback: (BrTabGroupInformPreventedCloseAttemptFeedback new
			element: aChildElement)
]

{ #category : #'api - feedback' }
BrTabGroupActionPreventionReason >> feedbackOnPreventedClose [
	"Reasons may provide a feedback on prevented close attempt"

	
]

{ #category : #'api - preventors' }
BrTabGroupActionPreventionReason >> ifReason: aReasonBlock ifNone: aNoneBlock [
	^ self isReason 
		ifTrue: [ aReasonBlock cull: self ] 
		ifFalse: aNoneBlock
]

{ #category : #'api - preventors' }
BrTabGroupActionPreventionReason >> isReason [
	^ true
]
