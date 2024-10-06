Class {
	#name : #BrTextEditorUpdateCommand,
	#superclass : #BrTextEditorCommand,
	#instVars : [
		'fromIndex',
		'toIndex'
	],
	#category : #'Brick-Editor-Commands'
}

{ #category : #executing }
BrTextEditorUpdateCommand >> executeOn: aTextEditor [
	| changedFrom changedTo |

	"convert from text => to segment index"
	changedFrom := aTextEditor segmentCollector
		cachedSegmentAt: self fromIndex
		ifFound: [ :aSegment | aSegment index ]
		ifNotFound: [ aTextEditor segmentCollector firstIndex ].

	"convert from text => to segment index"
	changedTo := aTextEditor segmentCollector
		cachedSegmentAt: self toIndex
		ifFound: [ :aSegment | aSegment index ]
		ifNotFound: [ aTextEditor segmentCollector lastIndex ].
	
	(changedFrom isZero or: [ changedTo isZero ])
		ifTrue: [ ^ self ].

	changedFrom
		to: changedTo
		do: [ :anIndex | (aTextEditor segmentCollector cachedAt: anIndex) clearCache ].

	aTextEditor notifyItemsChanged: (changedFrom to: changedTo)
]

{ #category : #accessing }
BrTextEditorUpdateCommand >> fromIndex [
	^ fromIndex
]

{ #category : #accessing }
BrTextEditorUpdateCommand >> fromIndex: aFromTextIndex [
	fromIndex := aFromTextIndex
]

{ #category : #printing }
BrTextEditorUpdateCommand >> printOn: aStream [
	aStream
		nextPutAll: 'Text changed from ';
		print: self fromIndex;
		nextPutAll: ' to ';
		print: self toIndex
]

{ #category : #accessing }
BrTextEditorUpdateCommand >> toIndex [
	^ toIndex
]

{ #category : #accessing }
BrTextEditorUpdateCommand >> toIndex: aToTextIndex [
	toIndex := aToTextIndex
]
