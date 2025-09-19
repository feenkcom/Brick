Trait {
	#name : #TBrTabGroupActionPreventor,
	#category : #'Brick-Tabs - Support'
}

{ #category : #'api - testing' }
TBrTabGroupActionPreventor >> retainReasonInTabGroup: aTabGroup [
	<return: #BrTabGroupActionPreventionReason>
	^ self explicitRequirement
]
