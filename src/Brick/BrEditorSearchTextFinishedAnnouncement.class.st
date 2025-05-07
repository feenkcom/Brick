Class {
	#name : #BrEditorSearchTextFinishedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'items',
		'context'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextFinishedAnnouncement >> context [
	<return: #BrEditorSearchTextContext>
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
	<return: #Collection of: #BrEditorSearchTextPatternItem>
	^ items
]

{ #category : #accessing }
BrEditorSearchTextFinishedAnnouncement >> items: aCollectionOfMarks [
	items := aCollectionOfMarks
]
