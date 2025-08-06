"
I collect {{gtClass:BrMenuItem}} instances for a given {{gtMethod:BrMenuItemsPragmaBuilder >> #pragmas | label=#selector}} and return a {{gtClass:BrMenuItems}} instance.
"
Class {
	#name : #BrMenuItemsPragmaBuilder,
	#superclass : #Object,
	#instVars : [
		'pragmas',
		'object',
		'upToSuperclass',
		'pragmaSortBlock',
		'methodArguments'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #building }
BrMenuItemsPragmaBuilder >> build [
	<return: #BrMenuItems or: nil>
	| somePragmas someMenuItems |
	self assert: [ self pragmas isNotNil ].
	self assert: [ self pragmas isCollection ].
	self assert: [ self pragmas isNotEmpty ].
	self assert: [ self upToSuperclass isNotNil ].
	self assert: [ self object isKindOf: self upToSuperclass ].

	somePragmas := self pragmas
			flatCollect: [ :eachSymbol | 
				Pragma
					allNamed: eachSymbol asSymbol
					from: self object class
					to: self upToSuperclass ]
			as: Array.

	self pragmaSortBlock ifNotNil: [ :aBlock | somePragmas sort: aBlock ].

	someMenuItems := somePragmas
			collect: [ :eachPragma | 
				[ (self object
					perform: eachPragma methodSelector
					withArguments: self methodArguments)
					ifNotNil: [ :aMenuItem | aMenuItem definition: [ eachPragma method ] ] ]
					onErrorDo: [ :anException | self createExceptionItemFor: anException andPragma: eachPragma ] ]
			thenSelect: #isNotNil.

	someMenuItems ifNil: [ ^ nil ].
	^ BrMenuItems new addItems: someMenuItems
]

{ #category : #building }
BrMenuItemsPragmaBuilder >> buildIfNil: aNilBlock [
	^ self build ifNil: aNilBlock
]

{ #category : #private }
BrMenuItemsPragmaBuilder >> createExceptionItemFor: anException andPragma: aPragma [
	| frozenException anExceptionCopy |
	anExceptionCopy := anException copy.
	anExceptionCopy signalContext ifNotNil: [ anExceptionCopy freeze ].
	frozenException := anExceptionCopy
			tag: aPragma;
			yourself.
	^ anException
		return: (BrMenuActionItem new
				label: 'Error' preview: frozenException messageText;
				action: [ :anElement :aButtonModel :anEvent | anElement phlow spawnObject: frozenException ])
]

{ #category : #initialization }
BrMenuItemsPragmaBuilder >> initialize [
	super initialize.
	upToSuperclass := Object.
	methodArguments := #()
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> methodArguments [
	^ methodArguments
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> methodArguments: aCollection [
	"Set arguments that are used to perform collected methods on a given object.
	It is used as the second argument in `Object>>#perform:withArguments:` calls."

	methodArguments := aCollection
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> object [
	^ object
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> object: anObject [
	"Set an object for which pragmas are searched for."

	object := anObject
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> pragma: aSymbol [
	"Set pragma that should be searched for a given object."

	self pragmas: {aSymbol}
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> pragmaSortBlock [
	^ pragmaSortBlock
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> pragmaSortBlock: aBlock [
	"The block should take two arguments (both arguments are pragma objects)
	and return true if the first element should preceed the second one.
	The block is used as an argument for `SequenceableCollection>>#sort:`."

	pragmaSortBlock := aBlock
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> pragmas [
	^ pragmas
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> pragmas: aCollectionOfSymbols [
	"Set a collection of pragmas that should be searched for a given object."

	pragmas := aCollectionOfSymbols
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> sortByFirstPragmaArgument [
	self sortByPragmaArgumentAt: 1
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> sortByPragmaArgumentAt: anInteger [
	self pragmaSortBlock: [ :a :b | (a argumentAt: anInteger) < (b argumentAt: anInteger) ]
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> upToSuperclass [
	^ upToSuperclass
]

{ #category : #accessing }
BrMenuItemsPragmaBuilder >> upToSuperclass: anObject [
	upToSuperclass := anObject
]
