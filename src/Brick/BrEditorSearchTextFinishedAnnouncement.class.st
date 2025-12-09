"
I notify that a search text activity is finished.
I may be announced from a non-UI process.
Note, that a given {{gtClass:BlText}} in which a searched happened may not be completelly marked yet.

"
Class {
	#name : #BrEditorSearchTextFinishedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'items',
		'context',
		'selectedIndex'
	],
	#category : #'Brick-Editor - Search Events'
}

{ #category : #accessing }
BrEditorSearchTextFinishedAnnouncement >> context [
	<return: #BrEditorSearchTextMarkerContext>
	^ context
]

{ #category : #accessing }
BrEditorSearchTextFinishedAnnouncement >> context: aMarkContext [
	context := aMarkContext
]

{ #category : #views }
BrEditorSearchTextFinishedAnnouncement >> gtFoundItemsFor: aView [
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
BrEditorSearchTextFinishedAnnouncement >> items [
	<return: #Collection of: #BrEditorSearchTextItem>
	^ items ifNil: [ #() ]
]

{ #category : #accessing }
BrEditorSearchTextFinishedAnnouncement >> items: aCollectionOfMarks [
	items := aCollectionOfMarks
]

{ #category : #accessing }
BrEditorSearchTextFinishedAnnouncement >> itemsCount [
	^ self items size
]

{ #category : #accessing }
BrEditorSearchTextFinishedAnnouncement >> selectedIndex [
	^ selectedIndex
]

{ #category : #accessing }
BrEditorSearchTextFinishedAnnouncement >> selectedIndex: anObject [
	selectedIndex := anObject
]
