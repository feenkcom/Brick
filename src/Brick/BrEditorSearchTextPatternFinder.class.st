Class {
	#name : #BrEditorSearchTextPatternFinder,
	#superclass : #Object,
	#instVars : [
		'computation',
		'announcer'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextPatternFinder >> computation [
	<return: #BrEditorSearchTextComputation>
	^ computation
]

{ #category : #accessing }
BrEditorSearchTextPatternFinder >> computation: aBrEditorSearchTextComputation [
	computation := aBrEditorSearchTextComputation
]

{ #category : #initialization }
BrEditorSearchTextPatternFinder >> initialize [
	super initialize.
	announcer := Announcer new.
	computation := BrEditorSearchTextSameProcessComputation new
]

{ #category : #'api - styling' }
BrEditorSearchTextPatternFinder >> mark: aMarkContext [
	"It must be called from a UI process"

	| someItems |
	aMarkContext hasText ifNil: [ ^ nil ].

	aMarkContext hasVisibleText ifTrue: [ 
		someItems := self markVisibleText: aMarkContext ].

	aMarkContext computedPatternItems: someItems.
	
	computation markText: aMarkContext using: self
]

{ #category : #'api - styling' }
BrEditorSearchTextPatternFinder >> markNextGenerationText: aMarkContext [ 
]

{ #category : #'api - styling' }
BrEditorSearchTextPatternFinder >> markText: aText context: aMarkContext [
	<return: #Collection of: #BrEditorSearchTextPatternItem>
	| someIndexes |
	someIndexes := aMarkContext pattern findAllIndexesIn: aText.
	^ self
		markText: aText
		indexes: someIndexes
		context: aMarkContext
]

{ #category : #'api - styling' }
BrEditorSearchTextPatternFinder >> markText: aText indexes: someItems context: aMarkContext [
	<return: #Collection of: #BrEditorSearchTextPatternItem>
	someItems
		doWithIndex: [ :eachItem :eachIndex | 
			| isCurrentItem |
			isCurrentItem := aMarkContext currentIndex = eachIndex.
			(aText from: eachItem startIndex to: eachItem stopIndex)
				attribute: (BrEditorSearchTextMark new
						index: eachIndex;
						isCurrent: isCurrentItem);
				highlight: (isCurrentItem
						ifTrue: [ BrGlamorousColors failureBackgroundColor ]
						ifFalse: [ BrGlamorousColors disabledButtonTextColor ]) ].

	^ someItems
]

{ #category : #'api - styling' }
BrEditorSearchTextPatternFinder >> markVisibleText: aMarkContext [
	^ self markText: aMarkContext visibleText context: aMarkContext
]

{ #category : #'api - notifying' }
BrEditorSearchTextPatternFinder >> notifyFoundItems: somePatternItems context: aMarkContext [
	"Notification may be called from a non-UI process."

	announcer
		announce: (BrEditorSearchTextFinishedAnnouncement new
				items: somePatternItems;
				context: aMarkContext)
]

{ #category : #'api - subscriptions' }
BrEditorSearchTextPatternFinder >> unsubscribe: anObject [
	^ announcer unsubscribe: anObject
]

{ #category : #'api - subscriptions' }
BrEditorSearchTextPatternFinder >> when: anEventSelector send: aMessageSelector to: anObject [
	^ announcer weak
		when: anEventSelector
		send: aMessageSelector
		to: anObject
]
