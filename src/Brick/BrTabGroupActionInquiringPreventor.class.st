Class {
	#name : #BrTabGroupActionInquiringPreventor,
	#superclass : #Object,
	#traits : 'TBrTabGroupActionPreventor',
	#classTraits : 'TBrTabGroupActionPreventor classTrait',
	#category : #'Brick-Tabs - Support'
}

{ #category : #'api - testing' }
BrTabGroupActionInquiringPreventor >> retainReasonInTabGroup: aTabGroup [
	<return: #BrTabGroupActionPreventionReason>
	| anEvent |
	anEvent := BrTabGroupCanBeClosedQuestionEvent new.

	aTabGroup content
		allChildrenBreadthFirstDo: [ :eachElement | 
			eachElement dispatchEvent: anEvent.
			anEvent isPrevented ifTrue: [ 
				^ BrTabGroupActionPreventionReason 
					preventedByContent: aTabGroup content 
					child: eachElement ] ].

	^  BrTabGroupActionPreventionReason noReason 
]
