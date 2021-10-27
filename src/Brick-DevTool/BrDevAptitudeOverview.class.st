Class {
	#name : #BrDevAptitudeOverview,
	#superclass : #BrVerticalPane,
	#instVars : [
		'aptitudeClass'
	],
	#category : 'Brick-DevTool'
}

{ #category : #accessing }
BrDevAptitudeOverview >> aptitudeClass [
	^ aptitudeClass
]

{ #category : #accessing }
BrDevAptitudeOverview >> aptitudeClass: anObject [
	aptitudeClass := anObject.
		
	self addChild: (BrScrollPane new
		aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
		content: (BrVerticalPane new
			hMatchParent;
			vFitContent;
			addChildren: { 
				self buildRequestsSection beInSeparateCompositionLayer.
				self buildWishesSection beInSeparateCompositionLayer.
				self buildEventsSection beInSeparateCompositionLayer
			}
		))
]

{ #category : #'private - instance creation' }
BrDevAptitudeOverview >> buildCategoryLabel: aString [
	^ BrLabel new
		beSmallSize;
		aptitude:
			(BrGlamorousLabelAptitude new
				foreground: (self theme button defaultTextColor alpha: 0.5));
		margin: (BlInsets bottom: 5);
		text: aString
]

{ #category : #'private - instance creation' }
BrDevAptitudeOverview >> buildCategoryLabel: aString content: anElement [
	^ BrVerticalPane new
		matchParent;
		addChild: (self buildCategoryLabel: aString);
		addChild: anElement
]

{ #category : #'private - references' }
BrDevAptitudeOverview >> buildCoderArtifactReferenceList: aListOfWishReferences [
	| aList theMethodsAndTheirReference theMethodGroups |
	
	"method -> reference"
	theMethodsAndTheirReference := aListOfWishReferences flatCollect: [ :eachReference | eachReference methods collect: [ :eachMethod | eachMethod -> eachReference ] ].
	
	"dict method -> { (method -> reference) }"
	theMethodGroups := theMethodsAndTheirReference groupedBy: [ :eachAssociation | eachAssociation key ].
	
	"dict method -> { reference }"
	theMethodGroups := theMethodGroups collect: [ :eachAssociation | eachAssociation value collect: [ :each | each value ] as: Set ].

	aList := BrSimpleList new
		matchParent;
		items: theMethodGroups associations;
		stencil: [ :eachReferenceGroup |
			| aHighlighter |
			
			aHighlighter := GtCompositeHighlighter forHighlighters: (eachReferenceGroup value collect: [ :eachReference |
				(GtPharoVariableReferenceHighlighter forVariableName: eachReference artifact name) ]).
			
			(GtPharoMethodCoder forMethod: eachReferenceGroup key)
				highlighter: aHighlighter;
				asElement ].

	^ aList
]

{ #category : #'private - instance creation' }
BrDevAptitudeOverview >> buildEventsList [
	| aList |
	
	aList := BrSimpleList new
		matchParent;
		items: (self aptitudeClass withAllSuperclassEvents);
		itemStencil: [ BrLabel new hMatchParent beSmallSize aptitude: BrGlamorousLabelAptitude ];
		itemDataBinder: [ :anItemElement :anItem | anItemElement text: anItem name ].

	^ aList
]

{ #category : #'private - section events' }
BrDevAptitudeOverview >> buildEventsSection [
	| aContainer theEvents |
	
	theEvents := self aptitudeClass withAllSuperclassEventReferences.
	theEvents ifEmpty: [ ^ BlElement new size: 0@0 ].

	aContainer := BrVerticalPane new
		hMatchParent;
		vFitContent.

	aContainer addChild: (self buildSectionLabel: 'Events').

	aContainer addChild: (BrEditor new
		aptitude: BrGlamorousEditorAptitude new;
		padding: (BlInsets all: 3);
		hMatchParent;
		vFitContent;
		beReadOnlyWithSelection;
		text: (self whatIsEvent asRopedText, (String cr, String cr) asRopedText glamorousRegularSmallSize, self aptitudeClass name asRopedText glamorousCodeFont,
			' listens to ' asRopedText glamorousRegularFont,
			(theEvents size asRopedText bold attribute: (self buildExpandArtifctReferencesAttribute: theEvents)),
			' events in:' asRopedText glamorousRegularFont)).
	
	aContainer addChild: (self buildCoderArtifactReferenceList: theEvents).

	^ aContainer
]

{ #category : #'private - references' }
BrDevAptitudeOverview >> buildExpandArtifctReferencesAttribute: theWishes [
	^ BrGlamorousTrangleExpanderTextAttribute new 
		attributesCreatingBlock: [
			BrTextAdornmentDynamicAttribute new 	
				beAppend;
				stencil:  [
					(self buildSmallReferencesList: theWishes)
						addAptitude: BrShadowAptitude;
						background: Color white;
						margin: (BlInsets all: 10);
						constraintsDo: [ :c | c textFlow pushLine ] ] ]
]

{ #category : #'private - instance creation' }
BrDevAptitudeOverview >> buildLookHierarchy [
	^ BrSimpleTree new
		matchParent;
		nodeStencil: [ BrLabel new beSmallSize aptitude: BrGlamorousLabelAptitude ];
		nodeDataBinder: [ :anItemElement :anItem |
			anItemElement text: (anItem rootClass = self aptitudeClass
				ifTrue: [ anItem rootClass name asRopedText bold ]
				ifFalse: [ anItem rootClass name ]) ];
		items: (GtCoderClassesHierarchyTree fromClasses: self aptitudeClass withAllSuperclassAndSubclassAptitudes) sortByClassName subclassTrees
		children: [ :anItem | anItem subclassTrees ];
		expandAll
]

{ #category : #'private - instance creation' }
BrDevAptitudeOverview >> buildRequestsList [
	| aList |
	
	aList := BrSimpleList new
		matchParent;
		items: (self aptitudeClass withAllSuperclassRequests);
		itemStencil: [ BrLabel new hMatchParent beSmallSize aptitude: BrGlamorousLabelAptitude ];
		itemDataBinder: [ :anItemElement :anItem | anItemElement text: anItem name ].

	^ aList
]

{ #category : #'private - section requests' }
BrDevAptitudeOverview >> buildRequestsSection [
	| aContainer theRequests |
	
	theRequests := self aptitudeClass withAllSuperclassRequestReferences.
	theRequests ifEmpty: [ ^ BlElement new size: 0@0 ].

	aContainer := BrVerticalPane new
		hMatchParent;
		vFitContent.

	aContainer addChild: (self buildSectionLabel: 'Requests').

	aContainer addChild: (BrEditor new
		aptitude: BrGlamorousEditorAptitude new;
		padding: (BlInsets all: 3);
		hMatchParent;
		vFitContent;
		beReadOnlyWithSelection;
		text: (self whatIsRequest asRopedText, (String cr, String cr) asRopedText glamorousRegularSmallSize, self aptitudeClass name asRopedText glamorousCodeFont,
			' sends ' asRopedText glamorousRegularFont,
			(theRequests size asRopedText bold attribute: (self buildExpandArtifctReferencesAttribute: theRequests)),
			' requests' asRopedText glamorousRegularFont, ' in:' asRopedText glamorousRegularFont)).
	
	aContainer addChild: (self buildCoderArtifactReferenceList: theRequests).

	^ aContainer
]

{ #category : #'private - instance creation' }
BrDevAptitudeOverview >> buildSectionLabel: aString [
	^ BrLabel new
		beHugeSize;
		aptitude: BrGlamorousLabelAptitude;
		margin:
			(BlInsets
				top: 15
				right: 0
				bottom: 0
				left: 1);
		text: aString
]

{ #category : #'private - references' }
BrDevAptitudeOverview >> buildSmallReferencesList: aListOfLookArtifactReferences [
	| aList |
	
	aList := BrSimpleList new
		matchParent;
		addEventHandler: (GtPhlowListToSelectHandler new);
		items: aListOfLookArtifactReferences;
		itemStencil: [ BrLabel new
			hMatchParent;
			beSmallSize;
			aptitude: BrGlamorousListLabelAptitude ];
		itemDataBinder: [ :anItemElement :anItem | anItemElement text: anItem artifact name ].

	^ aList
]

{ #category : #'private - instance creation' }
BrDevAptitudeOverview >> buildWishesList [
	| aList |
	
	aList := BrSimpleList new
		matchParent;
		items: (self aptitudeClass withAllSuperclassWishes);
		itemStencil: [ BrLabel new hMatchParent beSmallSize aptitude: BrGlamorousLabelAptitude ];
		itemDataBinder: [ :anItemElement :anItem | anItemElement text: anItem name ].

	^ aList
]

{ #category : #'private - section wishes' }
BrDevAptitudeOverview >> buildWishesSection [
	| aContainer theWishes |

	theWishes := self aptitudeClass withAllSuperclassWishReferences.
	theWishes ifEmpty: [ ^ BlElement new size: 0@0 ].

	aContainer := BrVerticalPane new
		hMatchParent;
		vFitContent.

	aContainer addChild: (self buildSectionLabel: 'Wishes').

	aContainer addChild: (BrEditor new
		aptitude: BrGlamorousEditorAptitude new;
		padding: (BlInsets all: 3);
		hMatchParent;
		vFitContent;
		beReadOnlyWithSelection;
		text: (self whatIsWish  asRopedText, (String cr, String cr) asRopedText glamorousRegularSmallSize, self aptitudeClass name asRopedText glamorousCodeFont,
			' handles ' asRopedText glamorousRegularFont,
			(theWishes size asRopedText bold attribute: (self buildExpandArtifctReferencesAttribute: theWishes)),
			' wishes' asRopedText glamorousRegularFont, ' in:' asRopedText glamorousRegularFont)).
	
	aContainer addChild: (self buildCoderArtifactReferenceList: theWishes).

	^ aContainer
]

{ #category : #initialization }
BrDevAptitudeOverview >> initialize [
	super initialize.
	
	self matchParent.
	self padding: (BlInsets left: 10 right: 10)
]

{ #category : #'private - section events' }
BrDevAptitudeOverview >> whatIsEvent [
	^ ('Typically UI Events that are handled by the Look')
		asRopedText glamorousRegularFont glamorousRegularSmallSize
]

{ #category : #'private - section requests' }
BrDevAptitudeOverview >> whatIsRequest [
	^ ('Request is a special Event sent by the Look to request data from the Widget Model.')
		asRopedText glamorousRegularFont glamorousRegularSmallSize
]

{ #category : #'private - section wishes' }
BrDevAptitudeOverview >> whatIsWish [
	^ ('Wish is a special Event handled by the Look to perform various actions.')
		asRopedText glamorousRegularFont glamorousRegularSmallSize
]
