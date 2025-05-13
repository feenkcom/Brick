Class {
	#name : #BrDeletableFileWidget,
	#superclass : #BrAsyncFileWidget,
	#instVars : [
		'isDeletable',
		'file',
		'onDeletion',
		'deleter'
	],
	#category : #'Brick-Async-Widget'
}

{ #category : #accessing }
BrDeletableFileWidget >> buildDeleter [
	^ deleter := BrButton new beTinySize
			aptitude: BrGlamorousButtonWithIconCircularAptitude;
			visibility: BlVisibility gone;
			icon: BrGlamorousVectorIcons cancel;
			label: 'Remove file';
			action: [ self onDeletion value: self file ];
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal alignRight.
				c ignored vertical alignTop ];
			margin: (BlInsets top: -8 right: -14)
]

{ #category : #accessing }
BrDeletableFileWidget >> defaultPostAction [
	^ [ :anElement | self isDeletable ifTrue: [ anElement addChild: self buildDeleter ] ]
]

{ #category : #accessing }
BrDeletableFileWidget >> file [
	^ file
]

{ #category : #accessing }
BrDeletableFileWidget >> file: aFile [
	file := aFile.
	super file: aFile
]

{ #category : #accessing }
BrDeletableFileWidget >> initialize [
	super initialize.
	self clipChildren: false.
	isDeletable := true.

	self postAction: self defaultPostAction.
	
	self initializeStyle
]

{ #category : #accessing }
BrDeletableFileWidget >> initializeStyle [
	self
		when: BlMouseEnterEvent
		do: [ :anEvent | deleter ifNotNil: [ deleter visibility: BlVisibility visible ] ].
	self
		when: BlMouseLeaveEvent
		do: [ :anEvent | deleter ifNotNil: [ deleter visibility: BlVisibility gone ] ]
]

{ #category : #accessing }
BrDeletableFileWidget >> isDeletable [
	^ isDeletable
]

{ #category : #accessing }
BrDeletableFileWidget >> isDeletable: anObject [
	isDeletable := anObject
]

{ #category : #accessing }
BrDeletableFileWidget >> onDeletion [
	^ onDeletion
]

{ #category : #accessing }
BrDeletableFileWidget >> onDeletion: anObject [
	onDeletion := anObject
]
