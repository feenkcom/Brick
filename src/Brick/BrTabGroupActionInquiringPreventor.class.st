Class {
	#name : #BrTabGroupActionInquiringPreventor,
	#superclass : #Object,
	#traits : 'TBrTabGroupActionPreventor',
	#classTraits : 'TBrTabGroupActionPreventor classTrait',
	#category : #'Brick-Tabs - Support'
}

{ #category : #'api - testing' }
BrTabGroupActionInquiringPreventor >> selectedTabShouldBeRetainedInTabGroup: aTabGroup [
	"Return true if a selected tab cannot be closed.
	 Return false if a selected tab can be closed."

	<return: #Boolean>
	| anEvent |
	anEvent := BrTabGroupCanBeClosedQuestionEvent new.

	aTabGroup content
		allChildrenBreadthFirstDo: [ :eachElement | 
			eachElement dispatchEvent: anEvent.
			anEvent isPrevented ifTrue: [ ^ true ] ].

	^ false
]
