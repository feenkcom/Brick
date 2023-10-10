Class {
	#name : #BrTabGroupByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-Tab'
}

{ #category : #'examples - scripter actions' }
BrTabGroupByScripterExamples >> clickOnButton: aScripter [
	<gtExample>
	aScripter
		substeps: 'Click and assert click events'
		do: [ :aStep | 
			| aClickCount |
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert has click button';
						exists;
						// BlClicksElementId ].

			aStep
				doStep: [ :s | 
					s
						label: 'Get number of existing clicks';
						block: [ :aButton | 
							aClickCount := aButton userData
									at: BlClicksElementId
									ifPresent: #size
									ifAbsent: [ 0 ] ];
						// BlClicksElementId ].

			aStep
				clickStep: [ :s | 
					s
						label: 'Click on the click button';
						// BlClicksElementId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert number of click events';
						value: [ :aButton | 
								aButton userData
									at: BlClicksElementId
									ifPresent: #size
									ifAbsent: [ 0 ] ]
							equals: [ aClickCount + 1 ];
						// BlClicksElementId ] ]
]

{ #category : #'examples - scripter actions' }
BrTabGroupByScripterExamples >> clickThenDisplayTabTwoThenMoveTabGroupThenClickTabOne [
	"Issue [feenkcom/gtoolkit#3200](https://github.com/feenkcom/gtoolkit/issues/3200)"

	<gtExample>
	| aScripter |
	aScripter := self displayTabGroupContainer.


	aScripter
		substeps: 'Display the second tab'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on the second tab';
						// BrTabGroup;
						/ #header;
						// #tabbar;
						onChildAt: 2 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert has NOT click button';
						notExists;
						// BlClicksElementId ] ].

	aScripter
		substeps: 'Relocate tab group'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Relocate';
						block: [ :aTabGroup | aTabGroup relocate: 150 @ 150 ];
						// BrTabGroup ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert tab group position';
						value: [ :aTabGroup | aTabGroup position ] equals: [ 150 @ 150 ];
						// BrTabGroup ] ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Display the first tab';
				// BrTabGroup;
				/ #header;
				// #tabbar;
				onChildAt: 1 ].

	self clickOnButton: aScripter.

	^ aScripter
]

{ #category : #'examples - scripter actions' }
BrTabGroupByScripterExamples >> displayTabGroupContainer [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement: [ self tabGroupContainer ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert tab group position';
				value: [ :aTabGroup | aTabGroup position ] equals: [ 0 @ 0 ];
				// BrTabGroup ].

	self clickOnButton: aScripter.

	^ aScripter
]

{ #category : #'examples - elements' }
BrTabGroupByScripterExamples >> tabGroupContainer [
	<gtExample>
	| aContainer |
	aContainer := BlElement new
			size: 300 @ 300;
			border: (BlBorder paint: Color lightGray width: 1).
	
	aContainer addChild: self tabGroupWithTwoTabs.

	^ aContainer
]

{ #category : #'examples - elements' }
BrTabGroupByScripterExamples >> tabGroupWithTwoTabs [
	<gtExample>
	| aTabGroup |
	aTabGroup := BrTabGroup new.
	aTabGroup aptitude: BrGlamorousTabGroupAptitude.
	aTabGroup size: 150 @ 150.
	aTabGroup border: (BlBorder paint: Color lightGray width: 1).

	aTabGroup addTab: self tabOne.
	aTabGroup addTab: self tabTwo.

	^ aTabGroup
]

{ #category : #'examples - elements' }
BrTabGroupByScripterExamples >> tabOne [
	<gtExample>
	| aTab |
	aTab := BrTab new.
	aTab
		aptitude: BrGlamorousTabAptitude;
		label: 'One';
		stencil: [ self tabOneContent ].

	^ aTab
]

{ #category : #'examples - elements' }
BrTabGroupByScripterExamples >> tabOneContent [
	<gtExample>
	| aFrame aButton |
	aFrame := BrFrame new
			matchParent;
			background: (Color purple alpha: 0.3).

	aButton := BrButton new
			aptitude: BrGlamorousButtonWithLabelAptitude;
			label: 'Click';
			action: [ :theButton :_ :anEvent | 
				theButton userData
					at: BlClicksElementId
					ifPresent: [ :aCollection | aCollection add: anEvent ]
					ifAbsentPut: [ OrderedCollection with: anEvent ] ];
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ].

	aFrame addChild: aButton as: BlClicksElementId.

	^ aFrame
]

{ #category : #'examples - elements' }
BrTabGroupByScripterExamples >> tabTwo [
	<gtExample>
	| aTab |
	aTab := BrTab new.
	aTab
		aptitude: BrGlamorousTabAptitude;
		label: 'Two';
		stencil: [ self tabTwoContent ].

	^ aTab
]

{ #category : #'examples - elements' }
BrTabGroupByScripterExamples >> tabTwoContent [
	<gtExample>
	^ BrFrame new
		matchParent;
		background: (Color orange alpha: 0.3)
]
