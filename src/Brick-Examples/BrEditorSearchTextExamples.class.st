Class {
	#name : #BrEditorSearchTextExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Editor - Search'
}

{ #category : #'examples - marker' }
BrEditorSearchTextExamples >> basicMarker [
	<gtExample>
	| aMarker |
	aMarker := BrEditorSearchTextMarker new
			computation: BrEditorSearchTextSameProcessComputation new.

	^ aMarker
]

{ #category : #'examples - marker' }
BrEditorSearchTextExamples >> markAB [
	<gtExample>
	| aMarker aContext aText aPreviousText aVisibleText allItems aVisibleItems aPreviousItems allAnnouncements |
	aMarker := self basicMarker.
	aText := self simple500Lines asRopedText.
	aPreviousText := aText from: 1 to: 999.
	aVisibleText := aText from: 1000 to: 2000.

	aContext := BrEditorSearchTextMarkerContext new
			fromText: aText visibleText: aVisibleText;
			subtext: 'a b' asRopedText.

	allItems := aContext pattern findAllIndexesIn: aText.
	aPreviousItems := aContext pattern findAllIndexesIn: aPreviousText.
	aVisibleItems := aContext pattern findAllIndexesIn: aVisibleText.
	self assert: aVisibleItems isNotEmpty.

	allAnnouncements := OrderedCollection new.
	
	aMarker
		when: BrEditorSearchTextFinishedAnnouncement
		send: #add:
		to: allAnnouncements.
	aMarker mark: aContext.
	
	self assert: allAnnouncements size equals: 1.
	self assert: allAnnouncements anyOne itemsCount equals: allItems size.
	self assert: allAnnouncements anyOne itemsCount equals: 2000.
	self assert: allAnnouncements anyOne selectedIndex equals: aPreviousItems size + 1.
	self assert: allAnnouncements anyOne selectedIndex equals: 20.

	self assert: aContext selectedItem isNotNil.
	self assert: aContext selectedItem isSelected.
	self assert: aContext selectedItem startIndex >= 1000.
	self
		assert: aContext selectedItem stopIndex equals: (aContext selectedItem startIndex + 2).
	self assert: aContext selectedIndex isNotNil.
	self assert: aContext selectedIndex > 1.

	^ BrEditorSearchTextExampleResult new
		marker: aMarker;
		context: aContext;
		text: aText
]

{ #category : #'examples - marker' }
BrEditorSearchTextExamples >> markNextAB [
	<gtExample>
	| aResult aMarker aContext allAnnouncements |
	aResult := self markAB.
	aMarker := aResult marker.
	aContext := aResult context.

	allAnnouncements := OrderedCollection new.
	aMarker
		when: BrEditorSearchTextFinishedAnnouncement
		send: #add:
		to: allAnnouncements.
	aMarker markNext: aContext.

	self assert: allAnnouncements size equals: 1.
	self assert: allAnnouncements anyOne itemsCount equals: 2000.
	self assert: allAnnouncements anyOne selectedIndex equals: 21.
	
	self assert: aResult selectedItem isSelected not.
	self assert: aContext selectedItem ~= aResult selectedItem.
	self assert: aContext selectedItem isSelected.
	self assert: aContext selectedItem startIndex >= aResult selectedItem stopIndex.
	self
		assert: aContext selectedItem stopIndex
		equals: aContext selectedItem startIndex + 2.
	self assert: aContext selectedIndex isNotNil.
	self assert: aContext selectedIndex equals: aResult selectedIndex + 1.

	^ BrEditorSearchTextExampleResult new
		marker: aMarker;
		context: aContext;
		text: aResult text
]

{ #category : #'examples - marker' }
BrEditorSearchTextExamples >> markPreviousAB [
	<gtExample>
	| aResult aMarker aContext allAnnouncements |
	aResult := self markAB.
	aMarker := aResult marker.
	aContext := aResult context.

	allAnnouncements := OrderedCollection new.
	aMarker
		when: BrEditorSearchTextFinishedAnnouncement
		send: #add:
		to: allAnnouncements.
	aMarker markPrevious: aContext.

	self assert: allAnnouncements size equals: 1.
	self assert: allAnnouncements anyOne itemsCount equals: 2000.
	self assert: allAnnouncements anyOne selectedIndex equals: 19.
	
	self assert: aResult selectedItem isSelected not.
	self assert: aContext selectedItem ~= aResult selectedItem.
	self assert: aContext selectedItem isSelected.
	self assert: aContext selectedItem stopIndex <= aResult selectedItem stopIndex.
	self
		assert: aContext selectedItem startIndex = (aContext selectedItem stopIndex - 2).
	self assert: aContext selectedIndex isNotNil.
	self assert: aContext selectedIndex equals: aResult selectedIndex - 1.

	^ BrEditorSearchTextExampleResult new
		marker: aMarker;
		context: aContext;
		text: aResult text
]

{ #category : #support }
BrEditorSearchTextExamples >> simple500Lines [
	^ String
		new: 5000
		streamContents: [ :aStream | 
			1
				to: 500
				do: [ :anIndex | 
					aStream
						print: anIndex;
						nextPutAll: '. '.

					4
						timesRepeat: [ ($a to: $z)
								do: [ :each | 
									aStream
										nextPut: each;
										space ] ].
					aStream cr ] ]
]
