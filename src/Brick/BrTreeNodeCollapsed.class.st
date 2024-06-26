Class {
	#name : #BrTreeNodeCollapsed,
	#superclass : #BrTreeNodeAnnouncement,
	#instVars : [
		'from',
		'to',
		'node'
	],
	#category : 'Brick-Tree - Events'
}

{ #category : #accessing }
BrTreeNodeCollapsed >> from [
	^ from
]

{ #category : #accessing }
BrTreeNodeCollapsed >> from: anObject [
	from := anObject
]

{ #category : #accessing }
BrTreeNodeCollapsed >> node [
	^ node
]

{ #category : #accessing }
BrTreeNodeCollapsed >> node: anObject [
	node := anObject
]

{ #category : #accessing }
BrTreeNodeCollapsed >> to [
	^ to
]

{ #category : #accessing }
BrTreeNodeCollapsed >> to: anObject [
	to := anObject
]
