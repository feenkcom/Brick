Class {
	#name : #BrMenuItemGroup,
	#superclass : #Object,
	#instVars : [
		'items',
		'configuration'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'add / remove' }
BrMenuItemGroup >> addItem: aMenuItem [
	self items ifEmpty: [ 
		self configuration: aMenuItem group ].
	self items add: aMenuItem
]

{ #category : #'api - converting' }
BrMenuItemGroup >> asElement [
	^ BrHorizontalPane new
		hMatchParent;
		vFitContent;
		addChild: (BrLabel new
				fitContent;
				constraintsDo: [ :c | c linear vertical alignCenter ];
				text: self name;
				aptitude: (BrGlamorousLabelAptitude new foreground: Color veryLightGray);
				constraintsDo: [ :c | 
					c linear vertical alignCenter ]);
		addChild: (BrFrame new
				hMatchParent;
				vExact: 1;
				margin: (BlInsets left: 3);
				background: Color veryLightGray;
				constraintsDo: [ :c | 
					c linear vertical alignCenter ])
]

{ #category : #'api - configuration' }
BrMenuItemGroup >> configuration [
	<return: #BrMenuItemGroupConfiguration>
	^ configuration
]

{ #category : #'api - configuration' }
BrMenuItemGroup >> configuration: anObject [
	configuration := anObject
]

{ #category : #'gt - extensions' }
BrMenuItemGroup >> gtItemChildren [
	^ self items
]

{ #category : #'gt - extensions' }
BrMenuItemGroup >> gtItemDepth [
	^ ''
]

{ #category : #'api - configuration' }
BrMenuItemGroup >> id [
	^ self configuration id
]

{ #category : #initalization }
BrMenuItemGroup >> initialize [
	super initialize.
	items := OrderedCollection new
]

{ #category : #accessing }
BrMenuItemGroup >> items [
	^ items
]

{ #category : #accessing }
BrMenuItemGroup >> items: anObject [
	items := anObject
]

{ #category : #accessing }
BrMenuItemGroup >> itemsCount [
	^ self items size
]

{ #category : #'api - configuration' }
BrMenuItemGroup >> name [
	^ self configuration name
]

{ #category : #printing }
BrMenuItemGroup >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self id asString;
		nextPut: $);
		space;
		nextPut: $[;
		print: self itemsCount;
		space;
		nextPutAll: ('item' asPluralBasedOn: self itemsCount);
		nextPut: $]
]

{ #category : #accessing }
BrMenuItemGroup >> priority [
	^ self configuration priority
]
