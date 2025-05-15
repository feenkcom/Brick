"
I am a core class for the search text activity.
I {{gtMethod:BrEditorSearchTextMarker>>#mark: | label=mark}} all places for a given {{gtMethod:BrEditorSearchTextMarkerContext >> #pattern | label=#selector}}. 
Main methods:
- {{gtMethod:BrEditorSearchTextMarker>>#mark: | label=#selector}}, 
- {{gtMethod:BrEditorSearchTextMarker>>#markNext: | label=#selector}}, 
- {{gtMethod:BrEditorSearchTextMarker>>#markPrevious: | label=#selector}}, 
- {{gtMethod:BrEditorSearchTextMarker>>#unmark: | label=#selector}}. 

"
Class {
	#name : #BrEditorSearchTextMarker,
	#superclass : #Object,
	#instVars : [
		'computation',
		'announcer'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextMarker >> computation [
	<return: #BrEditorSearchTextComputation>
	^ computation
]

{ #category : #accessing }
BrEditorSearchTextMarker >> computation: aBrEditorSearchTextComputation [
	computation := aBrEditorSearchTextComputation
]

{ #category : #initialization }
BrEditorSearchTextMarker >> initialize [
	super initialize.
	announcer := Announcer new.
	computation := BrEditorSearchTextSameProcessComputation new
]

{ #category : #'api - styling' }
BrEditorSearchTextMarker >> mark: aMarkContext [
	"It must be called from a UI process"

	| someItems |
	aMarkContext hasText ifFalse: [ ^ self ].

	aMarkContext hasVisibleText ifTrue: [ 
		someItems := self markVisibleText: aMarkContext ].

	aMarkContext patternItems: someItems.
	
	computation markText: aMarkContext using: self
]

{ #category : #'api - styling' }
BrEditorSearchTextMarker >> markNext: aMarkContext [
	aMarkContext editorModelTextDo: [ :aCurrentText | 
		| aCurrentItem aNewItem |
	
		aCurrentItem := aMarkContext selectedItem.
		aNewItem := aMarkContext computeNextItem.
	
		self switchText: aCurrentText attributeFor: aCurrentItem.
		self switchText: aCurrentText attributeFor: aNewItem.
		
		self notifyFoundItems: aMarkContext patternItems context: aMarkContext ]
]

{ #category : #'api - styling' }
BrEditorSearchTextMarker >> markPrevious: aMarkContext [
	aMarkContext editorModelTextDo: [ :aCurrentText | 
		| aCurrentItem aNewItem |
	
		aCurrentItem := aMarkContext selectedItem.
		aNewItem := aMarkContext computePreviousItem.
	
		self switchText: aCurrentText attributeFor: aCurrentItem.
		self switchText: aCurrentText attributeFor: aNewItem.
		
		self notifyFoundItems: aMarkContext patternItems context: aMarkContext ]
]

{ #category : #'api - styling' }
BrEditorSearchTextMarker >> markText: aText context: aMarkContext [
	<return: #Collection of: #BrEditorSearchTextItem>
	| someIndexes |
	someIndexes := aMarkContext pattern findAllIndexesIn: aText.
	^ self
		markText: aText
		indexes: someIndexes
		context: aMarkContext
]

{ #category : #'api - styling' }
BrEditorSearchTextMarker >> markText: aText indexes: someItems context: aMarkContext [
	<return: #Collection of: #BrEditorSearchTextItem>
	aText
		clearAttributes: [ :eachAttribute | eachAttribute class = BrEditorSearchTextMark ].

	someItems
		doWithIndex: [ :eachItem :eachIndex | 
			| isCurrentItem anAttribute |
			isCurrentItem := aMarkContext isSelectedItem: eachItem index: eachIndex.
			eachItem isSelected: isCurrentItem.
			anAttribute := BrEditorSearchTextMark new
					index: eachIndex;
					isSelected: isCurrentItem;
					paint: (self newTextMarkPaint: isCurrentItem).
			(aText from: eachItem startIndex to: eachItem stopIndex)
				attribute: anAttribute.
			eachItem textAttribute: anAttribute ].

	^ someItems
]

{ #category : #'api - styling' }
BrEditorSearchTextMarker >> markVisibleText: aMarkContext [
	^ self markText: aMarkContext visibleText context: aMarkContext
]

{ #category : #private }
BrEditorSearchTextMarker >> newTextMarkPaint: isCurrentItem [
	^ isCurrentItem
		ifTrue: [ BrGlamorousColors failureBackgroundColor ]
		ifFalse: [ BrGlamorousColors disabledButtonTextColor ]
]

{ #category : #'api - notifying' }
BrEditorSearchTextMarker >> notifyFoundItems: somePatternItems context: aMarkContext [
	"Notification may be called from a non-UI process."

	announcer
		announce: (BrEditorSearchTextFinishedAnnouncement new
				items: somePatternItems;
				selectedIndex: aMarkContext selectedIndex; 
				context: aMarkContext)
]

{ #category : #private }
BrEditorSearchTextMarker >> switchText: aText attributeFor: aPatternItem [
	| anOldAttribute aNewAttribute aSelection aSubText |
	anOldAttribute := aPatternItem textAttribute.
	aSelection := aPatternItem isSelected.
	aNewAttribute := BrEditorSearchTextMark new
			isSelected: aSelection;
			index: anOldAttribute index;
			paint: (self newTextMarkPaint: aSelection).
	aSubText := aText
			from: aPatternItem absoluteStartIndex
			to: aPatternItem absoluteStopIndex.
	aSubText removeAttribute: anOldAttribute.
	aSubText attribute: aNewAttribute.
	aPatternItem textAttribute: aNewAttribute
]

{ #category : #'api - styling' }
BrEditorSearchTextMarker >> unmark: aMarkContext [
	"It must be called from a UI process"

	aMarkContext
		editorModelTextDo: [ :aCurrentText | 
			aCurrentText
				removeAttributes: (aMarkContext patternItems collect: #textAttribute as: IdentitySet) ].

	self notifyFoundItems: #() context: aMarkContext
]

{ #category : #'api - subscriptions' }
BrEditorSearchTextMarker >> unsubscribe: anObject [
	^ announcer unsubscribe: anObject
]

{ #category : #'api - subscriptions' }
BrEditorSearchTextMarker >> when: anEventSelector send: aMessageSelector to: anObject [
	^ announcer weak
		when: anEventSelector
		send: aMessageSelector
		to: anObject
]
