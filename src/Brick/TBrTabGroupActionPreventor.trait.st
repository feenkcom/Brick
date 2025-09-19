Trait {
	#name : #TBrTabGroupActionPreventor,
	#category : #'Brick-Tabs - Support'
}

{ #category : #'api - testing' }
TBrTabGroupActionPreventor >> selectedTabShouldBeRetainedInTabGroup: aTabGroup [
	"Return true if a selected tab cannot be closed.
	 Return false if a selected tab can be closed."

	<return: #Boolean>
	^ self explicitRequirement
]
