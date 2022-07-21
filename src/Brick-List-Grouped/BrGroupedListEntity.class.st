Class {
	#name : #BrGroupedListEntity,
	#superclass : #Object,
	#instVars : [
		'group'
	],
	#category : #'Brick-List-Grouped-Models'
}

{ #category : #accessing }
BrGroupedListEntity >> group [

	^ group
]

{ #category : #accessing }
BrGroupedListEntity >> group: anObject [

	group := anObject
]

{ #category : #controlling }
BrGroupedListEntity >> ifHeader: aHeaderBlock ifItem: anItemBlock [
	^ self isHeader
		ifTrue: [ aHeaderBlock value ]
		ifFalse: [ self isItem
			ifTrue: [ anItemBlock value ]
			ifFalse: [ self error: ('Unsupported entity type: {1}' format: { self class }) ] ]
]

{ #category : #testing }
BrGroupedListEntity >> isHeader [
	^ false
]

{ #category : #testing }
BrGroupedListEntity >> isItem [
	^ false
]

{ #category : #accessing }
BrGroupedListEntity >> object [
	^ self subclassResponsibility
]
