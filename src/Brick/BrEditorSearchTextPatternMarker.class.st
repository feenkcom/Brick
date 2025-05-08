Class {
	#name : #BrEditorSearchTextPatternMarker,
	#superclass : #Object,
	#instVars : [
		'computation',
		'announcer'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextPatternMarker >> computation [
	<return: #BrEditorSearchTextComputation>
	^ computation
]

{ #category : #accessing }
BrEditorSearchTextPatternMarker >> computation: aBrEditorSearchTextComputation [
	computation := aBrEditorSearchTextComputation
]

{ #category : #initialization }
BrEditorSearchTextPatternMarker >> initialize [
	super initialize.
	announcer := Announcer new.
	computation := BrEditorSearchTextSameProcessComputation new
]

{ #category : #'api - styling' }
BrEditorSearchTextPatternMarker >> mark: aMarkContext [
	"It must be called from a UI process"

	| someItems |
	aMarkContext hasText ifNil: [ ^ nil ].

	aMarkContext hasVisibleText ifTrue: [ 
		someItems := self markVisibleText: aMarkContext ].

	aMarkContext computedPatternItems: someItems.
	
	computation markText: aMarkContext using: self
]

{ #category : #'api - styling' }
BrEditorSearchTextPatternMarker >> markText: aText context: aMarkContext [
	<return: #Collection of: #BrEditorSearchTextPatternItem>
	| someIndexes |
	someIndexes := aMarkContext pattern findAllIndexesIn: aText.
	^ self
		markText: aText
		indexes: someIndexes
		context: aMarkContext
]

{ #category : #'api - styling' }
BrEditorSearchTextPatternMarker >> markText: aText indexes: someItems context: aMarkContext [
	<return: #Collection of: #BrEditorSearchTextPatternItem>
	| oldAttributes |
	oldAttributes := Array streamContents: [ :aStream | 
		aText
			findAttributesSuchThat: [ :eachAttribute | 
				eachAttribute class = BrEditorSearchTextMark ]
			indicesDo: [ :aStart :aStop :anAttribute | 
				aStream nextPut: anAttribute ] ].

	aText removeAttributes: oldAttributes.
	
	someItems
		doWithIndex: [ :eachItem :eachIndex | 
			| isCurrentItem |
			isCurrentItem := aMarkContext isCurrentPatternItem: eachItem index: eachIndex.
			eachItem isSelected: isCurrentItem.
			(aText from: eachItem startIndex to: eachItem stopIndex)
				attribute: (BrEditorSearchTextMark new
						index: eachIndex;
						isCurrent: isCurrentItem;
						paint: (isCurrentItem
								ifTrue: [ BrGlamorousColors failureBackgroundColor ]
								ifFalse: [ BrGlamorousColors disabledButtonTextColor ])) ].
	
	^ someItems
]

{ #category : #'api - styling' }
BrEditorSearchTextPatternMarker >> markVisibleText: aMarkContext [
	^ self markText: aMarkContext visibleText context: aMarkContext
]

{ #category : #'api - notifying' }
BrEditorSearchTextPatternMarker >> notifyFoundItems: somePatternItems context: aMarkContext [
	"Notification may be called from a non-UI process."

	announcer
		announce: (BrEditorSearchTextFinishedAnnouncement new
				items: somePatternItems;
				context: aMarkContext)
]

{ #category : #'api - subscriptions' }
BrEditorSearchTextPatternMarker >> unsubscribe: anObject [
	^ announcer unsubscribe: anObject
]

{ #category : #'api - subscriptions' }
BrEditorSearchTextPatternMarker >> when: anEventSelector send: aMessageSelector to: anObject [
	^ announcer weak
		when: anEventSelector
		send: aMessageSelector
		to: anObject
]
