Class {
	#name : #BrTextEditorDeleter,
	#superclass : #BrTextEditorOperator,
	#instVars : [
		'deletionIntervals',
		'shouldUpdateCursor',
		'shouldUpdateSelection'
	],
	#category : #'Brick-Editor-Model - Operators'
}

{ #category : #'api - configuration' }
BrTextEditorDeleter >> afterCursor [
	"Delete all text after all cursors"

	self cursor do: [ :aCursor |
		self
			from: aCursor position
			to: self text size ]
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> beforeCurrentLineIfIndent [
	"We delete indents at the beginning of lines"

	self cursor
		do:
			[ :aCursor | 
			| start aPosition |
			aPosition := aCursor position.
			start := self findLineStartBefore: aPosition.
			self ifIndentAfter: start ]
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> beforeCursor [
	"Delete all text before the cursors"
		
	self cursor do: [ :aCursor |
		self
			from: 0
			to: aCursor position ]
]

{ #category : #accessing }
BrTextEditorDeleter >> beforeSelectedLinesIfIndent [
	"We delete indents at the beginning of all selected lines"

	| aCollectionOfLineStarts |
	aCollectionOfLineStarts := OrderedCollection new.
	self selection
		do:
			[ :aMonotoneSelection | 
			aCollectionOfLineStarts add: (self findLineStartBefore: aMonotoneSelection from + 1).
			aCollectionOfLineStarts addAll: (self findLineStartsBetween: aMonotoneSelection from + 1 and: aMonotoneSelection to) ].
	aCollectionOfLineStarts asSet do: [ :start | self ifIndentAfter: start ]
]

{ #category : #private }
BrTextEditorDeleter >> computeCursorMovement: aCursor [
	"Cumpute by how much a given cursor should be moved after text deletion within current deletion intervals"

	^ self computeIndexMovement: aCursor position
]

{ #category : #private }
BrTextEditorDeleter >> computeIndexMovement: anIndex [
	"Compute by how much a given text index should be moved after text deletion within current deletion intervals"
	| aCursorDelta |

	aCursorDelta := 0.

	deletionIntervals do: [ :aMonotoneSelection |
		(aMonotoneSelection to <= anIndex)
			ifTrue: [ aCursorDelta := aCursorDelta - (aMonotoneSelection to - aMonotoneSelection from) ]
			ifFalse: [ aMonotoneSelection from < anIndex
				ifTrue: [ aCursorDelta := aCursorDelta - (anIndex - aMonotoneSelection from) ] ] ].

	^ aCursorDelta
]

{ #category : #private }
BrTextEditorDeleter >> computeSelectionMovement: aMonotoneSelection [
	"Cumpute by how much a given selection should be moved after text deletion within current deletion intervals.
	Note: a given monotone selection must not overlap with any deletion intervals"
	| aSelectionDelta |
	
	aSelectionDelta := 0.
	
	deletionIntervals do: [ :eachDeletion |
		| size |
		size := eachDeletion to - eachDeletion from.
		eachDeletion to <= aMonotoneSelection from
			ifTrue: [ aSelectionDelta := aSelectionDelta - size  ] ].

	^ aSelectionDelta
]

{ #category : #'api - processing' }
BrTextEditorDeleter >> delete [
	"Perform deletion operation"

	shouldUpdateCursor
		ifTrue: [ self updateCursors ].

	shouldUpdateSelection
		ifTrue: [ self updateSelection ].

	deletionIntervals reverseDo: [ :aMonotoneSelection | self privateDelete: aMonotoneSelection from to: aMonotoneSelection to ]
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> from: aFromIndex to: aToIndex [
	"Mark a text interval given by from an to indices as the one to be deleted in cursor coordinates"

	aFromIndex = aToIndex
		ifTrue: [ ^ self ].

	deletionIntervals select: aFromIndex to: aToIndex
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> ifIndentAfter: start [
	^ (self text at: start + 1) == Character tab ifTrue: [ self from: start to: start + 1 ]
]

{ #category : #initialization }
BrTextEditorDeleter >> initialize [
	super initialize.
	
	deletionIntervals := BlCompositeSelection new.
	shouldUpdateCursor := true.
	shouldUpdateSelection := true
]

{ #category : #testing }
BrTextEditorDeleter >> isDeleter [
	^ true
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> oneAfterCursor [
	"Delete one symbol after the cursors"

	self cursor do: [ :aCursor | self oneAfterCursor: aCursor ]
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> oneAfterCursor: aCursor [
	| dist | 
	dist := (self hasString: String crlf afterCursor: aCursor) ifTrue: [ 2 ] ifFalse: [ 1 ].
	^ self from: aCursor position to: (aCursor position + dist min: self text size)
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> oneAfterCursorIfOutsideOfSelection [
	"Delete one symbol after the cursors but only if there is no selection nearby"

	self cursor do: [ :aCursor | (self selection contains: aCursor position) ifFalse: [ self oneAfterCursor: aCursor ] ]
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> oneBeforeCursor [
	"Delete one symbol before the cursor"

	self cursor do: [ :aCursor | self oneBeforeCursor: aCursor ]
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> oneBeforeCursor: aCursor [
	"Delete one symbol before the specified cursor "

	| dist |
	dist := (self hasString: String crlf beforeCursor: aCursor) ifTrue: [ 2 ] ifFalse: [ 1 ].
	self from: (aCursor position - dist max: 0) to: aCursor position
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> oneBeforeCursorIfOutsideOfSelection [
	"Delete one symbol before the cursor but only if there is no selection nearby"

	self cursor do: [ :aCursor |
		(self selection contains: aCursor position)
			ifFalse: [ self oneBeforeCursor: aCursor ] ]
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> oneWordAfterCursor [
	"Delete one word after the cursors"

	self cursor do: [ :aCursor | self oneWordAfterCursor: aCursor ]
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> oneWordAfterCursor: aCursor [
	^ self
		from: aCursor position
		to: (self findWordEndAfter: (aCursor position + 1 min: self text size))
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> oneWordBeforeCursor [
	"Delete one word before the cursors"

	self cursor do: [ :aCursor | self oneWordBeforeCursor: aCursor ]
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> oneWordBeforeCursor: aCursor [
	^ self from: (self findWordStartBefore: aCursor position) to: aCursor position
]

{ #category : #private }
BrTextEditorDeleter >> privateDelete: aFromTextIndex to: aToTextIndex [
	"I delete a piece of text within a given text interval without cursor or selection update.
	Note: cursor or selection location after deletion may be invalid!"
	| aCommand |

	self
		assert: [ aFromTextIndex >= 0 and: [ aFromTextIndex <= self editor text size ] ]
		description: [ 'From deletion index must be within interval [0... text size]' ].
	self
		assert: [ aToTextIndex >= 0 and: [ aToTextIndex <= self editor text size ] ]
		description: [ 'To deletion index must be within interval [0... text size]' ].
	self
		assert: [ aToTextIndex >= aFromTextIndex ]
		description: [ 'To index must be greater or equal from index' ].

	aCommand := BrTextEditorDeleteCommand new
		fromIndex: aFromTextIndex;
		toIndex: aToTextIndex.
	self editor enqueueCommand: aCommand
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> selected [
	"Mark currenty selected text as the one to be deleted"

	self selection do: [ :aMonotoneSelection | self from: aMonotoneSelection from to: aMonotoneSelection to ]
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> surroundings: aDictionaryOrArray [
	"Delete the surrounding around each cursor (if there is any) but only if the cursor is not part of the selection"
	| theAssociations |
	
	theAssociations := aDictionaryOrArray isArray
		ifFalse: [ aDictionaryOrArray associations ]
		ifTrue: [ aDictionaryOrArray ].
	
	
	self cursor do: [ :aCursor |
		(self selection contains: aCursor position)
			ifFalse: [
				theAssociations
					detect: [ :eachReplacement |
						(self hasString: eachReplacement key beforeCursor: aCursor)
							and: [ self hasString: eachReplacement value afterCursor: aCursor ] ]
					ifFound: [ :aReplacement |
						self
							from: aCursor position - aReplacement key size
							to: aCursor position + aReplacement value size ] ] ]
]

{ #category : #private }
BrTextEditorDeleter >> updateCursors [
	
	self cursor do: [ :aCursor |
		| aCursorDelta |
		aCursorDelta := self computeCursorMovement: aCursor.
		aCursorDelta isZero
			ifFalse: [ self editor navigator
				dueTo: self;
				move: aCursor by: aCursorDelta;
				apply ] ]
]

{ #category : #private }
BrTextEditorDeleter >> updateSelection [
	| aSelectionCopy newSelection |
	
	deletionIntervals do: [ :aMonotoneSelection | self editor deselect: aMonotoneSelection from to: aMonotoneSelection to ].
	
	aSelectionCopy := BlCompositeSelection new select: self selection.
	aSelectionCopy deselect: deletionIntervals.

	newSelection := BlCompositeSelection new.
	aSelectionCopy do: [ :eachSelection |
		| aSelectionDelta |

		aSelectionDelta := self computeSelectionMovement: eachSelection.
		newSelection select: (eachSelection from + aSelectionDelta) to: (eachSelection to + aSelectionDelta) ].

	self editor selection: newSelection
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> withoutCursorUpdate [
	shouldUpdateCursor := false
]

{ #category : #'api - configuration' }
BrTextEditorDeleter >> withoutSelectionUpdate [
	shouldUpdateSelection := false
]
