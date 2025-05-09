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
BrEditorSearchTextPatternMarker >> markNext: aMarkContext [
	aMarkContext editorElementDo: [ :anEditor | 
		| aCurrentItem aNewItem |
	
		aCurrentItem := aMarkContext computedCurrentPatternItem.
		aNewItem := aMarkContext computeNextPatternItem.
	
		self switchText: anEditor text attributeFor: aCurrentItem.
		self switchText: anEditor text attributeFor: aNewItem ]
]

{ #category : #'api - styling' }
BrEditorSearchTextPatternMarker >> markPrevious: aMarkContext [
	aMarkContext editorElementDo: [ :anEditor | 
		| aCurrentItem aNewItem |
	
		aCurrentItem := aMarkContext computedCurrentPatternItem.
		aNewItem := aMarkContext computePreviousPatternItem.
	
		self switchText: anEditor text attributeFor: aCurrentItem.
		self switchText: anEditor text attributeFor: aNewItem ]
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
	oldAttributes := Array
			streamContents: [ :aStream | 
				aText
					findAttributesSuchThat: [ :eachAttribute | eachAttribute class = BrEditorSearchTextMark ]
					indicesDo: [ :aStart :aStop :anAttribute | aStream nextPut: anAttribute ] ].

	aText removeAttributes: oldAttributes.

	someItems
		doWithIndex: [ :eachItem :eachIndex | 
			| isCurrentItem anAttribute |
			isCurrentItem := aMarkContext isCurrentPatternItem: eachItem index: eachIndex.
			eachItem isSelected: isCurrentItem.
			anAttribute := BrEditorSearchTextMark new
					index: eachIndex;
					isCurrent: isCurrentItem;
					paint: (self newTextMarkPaint: isCurrentItem).
			(aText from: eachItem startIndex to: eachItem stopIndex)
				attribute: anAttribute.
			eachItem textAttribute: anAttribute ].

	^ someItems
]

{ #category : #'api - styling' }
BrEditorSearchTextPatternMarker >> markVisibleText: aMarkContext [
	^ self markText: aMarkContext visibleText context: aMarkContext
]

{ #category : #private }
BrEditorSearchTextPatternMarker >> newTextMarkPaint: isCurrentItem [
	^ isCurrentItem
		ifTrue: [ BrGlamorousColors failureBackgroundColor ]
		ifFalse: [ BrGlamorousColors disabledButtonTextColor ]
]

{ #category : #'api - notifying' }
BrEditorSearchTextPatternMarker >> notifyFoundItems: somePatternItems context: aMarkContext [
	"Notification may be called from a non-UI process."

	announcer
		announce: (BrEditorSearchTextFinishedAnnouncement new
				items: somePatternItems;
				context: aMarkContext)
]

{ #category : #private }
BrEditorSearchTextPatternMarker >> switchText: aText attributeFor: aPatternItem [
	| anOldAttribute aNewAttribute aSelection aSubText |
	anOldAttribute := aPatternItem textAttribute.
	aSelection := aPatternItem isSelected.
	aNewAttribute := BrEditorSearchTextMark new
			isCurrent: aSelection;
			index: anOldAttribute index;
			paint: (self newTextMarkPaint: aSelection).
	aSubText := aText
			from: aPatternItem absoluteStartIndex
			to: aPatternItem absoluteStopIndex.
	aSubText removeAttribute: anOldAttribute.
	aSubText attribute: aNewAttribute.
	aPatternItem textAttribute: aNewAttribute
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
