"
BrTextLineMap keeps a map of line number to character index for a BrTextEditorSegmentCollector. 

Public API and Key Messages

- addLine:offset: 	Add the supplied line number to character offset mapping
- mapEntryFor: 		Answer the map entry for the supplied line number
 
## Internal Representation and Key Implementation Points.

### Instance Variables

	map:					<SortedCollection>
	minEntrySpacing:	<Integer>


### Implementation Points

As part of initialisation the text editor provides the map with its cacheLimit.  This is used to determine the minimum spacing between map entries to avoid growing the map unreasonably.


"
Class {
	#name : #BrTextLineMap,
	#superclass : #Object,
	#instVars : [
		'map',
		'minEntrySpacing'
	],
	#category : #'Brick-Editor-Model - Segment-Text'
}

{ #category : #adding }
BrTextLineMap >> addLine: lineNumber offset: offsetNumber [
	"Add the supplied known index."

	| closestMapEntry |
	"Ensure there are no close entries"
	closestMapEntry := self mapEntryFor: lineNumber.
	(lineNumber - closestMapEntry key < minEntrySpacing
		and: [ lineNumber <= map last key ]) ifTrue: [ ^ self ].

	map add: lineNumber -> offsetNumber
]

{ #category : #accessing }
BrTextLineMap >> cacheLimit: aNumber [

	minEntrySpacing := (aNumber * 0.25) rounded.
	self assert: minEntrySpacing >= 10.
]

{ #category : #initialization }
BrTextLineMap >> initialize [ 

	super initialize.
	map := SortedCollection sortBlock: [ :a :b | a key < b key ].
	map add: 1 -> 1.
	minEntrySpacing := 10.
]

{ #category : #private }
BrTextLineMap >> mapEntryFor: anInteger [
	"Answer the map entry with largest line number less than or equal to anInteger"
	| left right mid midVal |

	map size = 1 ifTrue: [ ^ map first ].
	map size = 2 ifTrue:
		[ ^ map second key > anInteger
			ifTrue: [ map first ]
			ifFalse: [ map second ]].

	"Modified binary search"
	left := 1.
	right := map size.

	[ left <= right ] whileTrue:
		[ mid := left + ((right - left) // 2).
		midVal := map at: mid.
		anInteger < midVal key ifTrue: 
			[ right := mid - 1 ]
		ifFalse:
			[ anInteger = midVal key
				ifTrue: [ ^ midVal ]
				ifFalse: [ left := mid + 1 ] ] ].

	^ anInteger > midVal key 
		ifTrue: [ midVal ]
		ifFalse: [ map at: mid-1 ]

]
