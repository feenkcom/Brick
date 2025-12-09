"
I notify that a search text activity is in progress, providing partial results.
I may be announced from a non-UI process.

"
Class {
	#name : #BrEditorSearchTextProgressAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'items',
		'context',
		'selectedIndex'
	],
	#category : #'Brick-Editor - Search Events'
}

{ #category : #accessing }
BrEditorSearchTextProgressAnnouncement >> context [
	<return: #BrEditorSearchTextMarkerContext>
	^ context
]

{ #category : #accessing }
BrEditorSearchTextProgressAnnouncement >> context: aMarkContext [
	context := aMarkContext
]

{ #category : #views }
BrEditorSearchTextProgressAnnouncement >> gtFoundItemsFor: aView [
	<gtView>
	items ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Found items';
		items: [ items ifNil: [ #() ] ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'From' text: [ :each | each startIndex ];
		column: 'To' text: [ :each | each stopIndex ];
		column: 'Text' text: [ :each | each subtext ]
]

{ #category : #accessing }
BrEditorSearchTextProgressAnnouncement >> items [
	<return: #Collection of: #BrEditorSearchTextItem>
	^ items ifNil: [ #() ]
]

{ #category : #accessing }
BrEditorSearchTextProgressAnnouncement >> items: aCollectionOfMarks [
	items := aCollectionOfMarks
]

{ #category : #accessing }
BrEditorSearchTextProgressAnnouncement >> itemsCount [
	^ self items size
]

{ #category : #accessing }
BrEditorSearchTextProgressAnnouncement >> selectedIndex [
	^ selectedIndex
]

{ #category : #accessing }
BrEditorSearchTextProgressAnnouncement >> selectedIndex: anObject [
	selectedIndex := anObject
]
