Class {
	#name : #BrSimpleListExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-List'
}

{ #category : #'examples - vertical list' }
BrSimpleListExamples >> allClasses [
	<gtExample>
	^ BrSimpleList new
		itemStencil: [
			BrLabel new
				"hMatchParent;"
				aptitude: BrGlamorousLabelAptitude new + (BrStyleCommonAptitude new
					selected: [ :aStyle | aStyle background: Color veryVeryLightGray ]);
				padding: (BlInsets all: 5) ];
		itemDataBinder: [ :eachElement :eachClass :eachIndex | eachElement text: eachClass name ];
		items: (SystemNavigation new allClasses sorted: [ :a :b | a name < b name ])
]

{ #category : #'examples - vertical list' }
BrSimpleListExamples >> allClassesMultiSelect [
	<gtExample>
	^ self allClasses
		aptitude: BrMultiListAptitude new
]

{ #category : #'examples - horizontal list' }
BrSimpleListExamples >> horizontalAllClasses [
	<gtExample>
	| aList |
	aList := self allClasses.
	aList beHorizontal.
	
	^ aList
]

{ #category : #'examples - nested lists' }
BrSimpleListExamples >> horizontalAndVerticalNumbers [
	<gtExample>
	| aList |
	aList := self 
		horizontalListFor: (0 to: 10000 by: 100)
		verticalListFor: [ :aNumber | aNumber to: aNumber + 99 ].
	^ aList
]

{ #category : #'examples - support' }
BrSimpleListExamples >> horizontalListFor: aCollection [
	<gtExample>
	| aList aScrollable |
	aList := BrSimpleList horizontal
		itemType: [ :aFactory :anItem :anIndex | 
			Integer ];
		itemStencil: [ :anItemType | 
			self label ];
		itemDataBinder: [ :anElement :anItem :anIndex | 
			anElement text: anItem asString ];
		items: aCollection.
	
	aList enqueueTask: (BlTaskAction new action: [ 
		aScrollable := aList childNamed: #scrollable.
		aScrollable margin: aScrollable margin + (BlInsets bottom: 5) ]).
	
	^ aList
]

{ #category : #'examples - support' }
BrSimpleListExamples >> horizontalListFor: aCollection verticalListFor: aHorizontalBlock [
	<gtExample>
	| aList aScrollable |
	aList := BrSimpleList horizontal
		itemType: [ :aFactory :anItem :anIndex | 
			Integer ];
		itemStencil: [ :anItemType | 
			| aNestedList |
			aNestedList := self verticalListFor: #().
			aNestedList hFitContent. ];
		itemDataBinder: [ :anElement :anItem :anIndex | 
			| aNestedCollection |
			aNestedCollection := aHorizontalBlock cull: anItem cull: anIndex.
			anElement items: aNestedCollection ];
		items: aCollection.
	
	aList enqueueTask: (BlTaskAction new action: [ 
		aScrollable := aList childNamed: #scrollable.
		aScrollable margin: aScrollable margin + (BlInsets bottom:5) ]).
	
	^ aList
]

{ #category : #'examples - horizontal list' }
BrSimpleListExamples >> horizontalNumbers [
	<gtExample>
	| aList |
	aList := self horizontalListFor: (1 to: 1000).
	
	^ aList
]

{ #category : #'examples - support' }
BrSimpleListExamples >> label [
	<gtExample>
	| aLabel |
	aLabel := BrLabel new
		beHugeSize;
		aptitude: BrGlamorousLabelAptitude.
	aLabel margin: aLabel margin + (BlInsets all: 5).
	aLabel padding: aLabel padding + (BlInsets top: 5 right: 10 bottom: 5 left: 10).
	aLabel border: (BlBorder paint: Color lightGray width: 1).
	aLabel geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	^ aLabel
]

{ #category : #'examples - vertical list' }
BrSimpleListExamples >> scripterAllClassesMultiSelect [
	<gtExample>
	| aScripter |
	aScripter := BlScripter new element: self allClassesMultiSelect.
	
	aScripter check
		label: 'Check that nothing is selected';
		satisfies: [:anElement | anElement selectedIndices isEmpty ];
		play.
	
	^ aScripter
]

{ #category : #'examples - vertical list' }
BrSimpleListExamples >> scripterAllClassesMultiSelectSelected [
	<gtExample>
	| aScripter |
	aScripter := self scripterAllClassesMultiSelect.

	aScripter click
		label: 'Select items in list';
		id: #scrollable;
		onChildAt: 2;
		play.


	aScripter click
		label: 'Select items in list';
		id: #scrollable;
		onChildAt: 5;
		modifiers: BlKeyModifiers shift;
		play.

	aScripter check
		label: 'Check that selection works';
		satisfies: [ :anElement | anElement selectedIndices size = 4 ];
		play.

	^ aScripter
]

{ #category : #'examples - vertical list' }
BrSimpleListExamples >> scripterAllClassesMultiSelectSelectedDiscontinuous [
	<gtExample>
	| aScripter |
	aScripter := self scripterAllClassesMultiSelectSelected.


	aScripter click
		label: 'Select discontinuous item in list';
		id: #scrollable;
		onChildAt: 7;
		modifiers: BlKeyModifiers cmd;
		play.

	aScripter check
		label: 'Check that discontinuous selection works';
		satisfies: [ :anElement | anElement selectedIndices size = 5 ];
		play.

	^ aScripter
]

{ #category : #'examples - performance' }
BrSimpleListExamples >> simpleListWithItemsBindsOnce [
	"This example makes sure that when the list is displayed for the first time, the items are created and bound just once."
	<gtExample>
	| aList aScripter aCreationAmount aBindingAmount theItemsChangedEvents |

	aCreationAmount := 0.
	aBindingAmount := 0.

	aList := BrSimpleList new.
	aList vExact: 300.
	aList itemStencil: [
			aCreationAmount := aCreationAmount + 1.
			BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				hMatchParent;
				vExact: 50 ];
		itemDataBinder: [ :aCellElement :aClass |
			aBindingAmount := aBindingAmount + 1.
			aCellElement text: aClass name asString ].
	
	theItemsChangedEvents := OrderedCollection new.
	aList when: BrItemsProviderItemsChangedEvent do: [ :anEvent | theItemsChangedEvents add: anEvent ].

	aScripter := BlScripter new.
	aScripter element: aList.

	aScripter do
		action: [ :anElement | anElement items: Smalltalk allClasses ];
		play.

	self assert: aCreationAmount equals: 6.
	self assert: aBindingAmount equals: 6.
	self assert: theItemsChangedEvents size equals: 1.
	self assert: theItemsChangedEvents first isSynchronous.

	^ aScripter
]

{ #category : #'examples - stream' }
BrSimpleListExamples >> streamingList [
	<gtExample>
	<noTest>
	| json stream |
	
	json := [ 'https://unsplash.it/list' asUrl retrieveContents ] asAsyncFuture.
	json := json map: [ :jsonString | (STONJSON fromString: jsonString) asAsyncStream ].
	stream := json asAsyncStream flatten.
	stream := stream map: [ :eachDictionary |
			| width height id 	maxHeight |

			id := eachDictionary at: #id.
			width := eachDictionary at: #width.
			height := eachDictionary at: #height.

		 	maxHeight := 200.
			width := (width / (height / maxHeight)) rounded.
			height := maxHeight.

			'https://unsplash.it/', width asString, '/', height asString,'?image=', id asString ].

	stream := stream map: [ :eachUrl | eachUrl asUrl retrieveContents ].
	stream := stream filter: [ :eachContents | eachContents notNil ].
	stream := stream map: [ :eachContents | Form fromBinaryStream: eachContents readStream ].
	stream := stream take: 50.

	^ BrSimpleList new
		itemsProvider: (BrStreamItemsProvider new
			stream: stream;
			preloadAmount: 1);
		stencil: [ :eachImage | eachImage asElement ]
]

{ #category : #'examples - nested lists' }
BrSimpleListExamples >> verticalAndHorizontalNumbers [
	<gtExample>
	| aList |
	aList := self 
		verticalListFor: (0 to: 10000 by: 100)
		horizontalListFor: [ :aNumber | aNumber to: aNumber + 99 ].
	^ aList
]

{ #category : #'examples - support' }
BrSimpleListExamples >> verticalListFor: aCollection [
	<gtExample>
	| aList aScrollable |
	aList := BrSimpleList vertical
		itemType: [ :aFactory :anItem :anIndex | 
			Integer ];
		itemStencil: [ :anItemType | 
			self label ];
		itemDataBinder: [ :anElement :anItem :anIndex | 
			anElement text: anItem asString ];
		items: aCollection.
	
	aList enqueueTask: (BlTaskAction new action: [ 
		aScrollable := aList childNamed: #scrollable.
		aScrollable margin: aScrollable margin + (BlInsets right: 5) ]).
	
	^ aList
]

{ #category : #'examples - support' }
BrSimpleListExamples >> verticalListFor: aCollection horizontalListFor: aHorizontalBlock [
	<gtExample>
	| aList aScrollable |
	aList := BrSimpleList vertical
		itemType: [ :aFactory :anItem :anIndex | 
			Integer ];
		itemStencil: [ :anItemType | 
			| aNestedList |
			aNestedList := self horizontalListFor: #().
			aNestedList vFitContent. ];
		itemDataBinder: [ :anElement :anItem :anIndex | 
			| aNestedCollection |
			aNestedCollection := aHorizontalBlock cull: anItem cull: anIndex.
			anElement items: aNestedCollection ];
		items: aCollection.
	
	aScrollable := aList childNamed: #scrollable.
	aScrollable margin: aScrollable margin + (BlInsets right: 5).
	
	^ aList
]

{ #category : #'examples - vertical list' }
BrSimpleListExamples >> verticalNumbers [
	<gtExample>
	| aList |
	aList := self verticalListFor: (1 to: 1000).
	
	^ aList
]
