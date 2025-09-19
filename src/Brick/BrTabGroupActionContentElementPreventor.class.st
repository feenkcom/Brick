Class {
	#name : #BrTabGroupActionContentElementPreventor,
	#superclass : #Object,
	#traits : 'TBrTabGroupActionPreventor',
	#classTraits : 'TBrTabGroupActionPreventor classTrait',
	#instVars : [
		'contentElement'
	],
	#category : #'Brick-Tabs - Support'
}

{ #category : #accessing }
BrTabGroupActionContentElementPreventor >> contentElement [
	^ contentElement
]

{ #category : #accessing }
BrTabGroupActionContentElementPreventor >> contentElement: anObject [
	contentElement := anObject
]

{ #category : #'api - testing' }
BrTabGroupActionContentElementPreventor >> retainReasonInTabGroup: aTabGroup [
	^ aTabGroup content children
		detect: [ :each | each == contentElement ]
		ifFound: [ :anElement | 
			BrTabGroupActionPermanentTabPreventionReason new 
				contentElement: self contentElement ]
		ifNone: [ BrTabGroupActionPreventionReason noReason ]
]
