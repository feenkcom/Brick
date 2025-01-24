Class {
	#name : #BrMenuWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-Menu'
}

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> buttonWithDropdown [
	<gtExample>
	^ BrFrame new
		matchParent;
		addChild: (BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude;
				label: 'Dropdown';
				constraintsDo: [ :c | 
					c margin: (BlInsets all: 10).
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				addAptitude: (BrWithExplicitDropdownAptitude new
						handle: [ BrButton new
								aptitude: BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude;
								label: 'Dropdown' ]
						submenu: BrMenuExamples new menuItems))
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> clickButtonWithDropdown [
	<gtExample>
	| aScripter |
	aScripter := self displayButtonWithDropdown.

	aScripter click
		label: 'Open dropdown';
		/ BrButton;
		play.
		
	aScripter assert
		label: 'Assert dropdown is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> clickDropdownHandle [
	<gtExample>
	| aScripter |
	aScripter := self clickButtonWithDropdown.

	aScripter click
		label: 'Click dropdown handle';
		onSpaceRoot;
		// BrMenuSteppedElement;
		onChildAt: 1;
		play.

	aScripter assert
		label: 'Assert dropdown is closed';
		notExists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	aScripter assert
		label: 'Assert empty dropdown aptitude caches';
		do: [ :aButton | 
			aButton aptitude
				findActor: BrWithExplicitDropdownAptitude
				ifFound: [ :anAptitude | 
					self
						assert: anAptitude menuContainer elementCache isEmpty
						description: [ 'Menu container cache must be empty: {1}'
								format: {anAptitude menuContainer elementCache} ] ]
				ifNone: [ AssertionFailure signal: 'Dropdown aptitude must exist' ] ];
		/ BrButton;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> clickDropdownInDropdownHandle [
	<gtExample>
	| aScripter |
	aScripter := self clickElementWithDropdownInDropdown.

	aScripter click
		label: 'Click dropdown handle';
		onSpaceRoot;
		// #'menu-in-submenu-handle';
		play.

	aScripter assert
		label: 'Assert dropdown handle does not exist';
		notExists;
		onSpaceRoot;
		// #'menu-in-submenu-handle';
		play.

	aScripter assert
		label: 'Assert one dropdown is opened';
		value: [ :aRootElement | (aRootElement query // BrMenuSteppedElement) result size ]
			equals: 1;
		onSpaceRoot;
		play.

	aScripter assert
		label: 'Assert complex submenu is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu-in-submenu';
		play.

	aScripter assert
		label: 'Assert dropdown has no other submenus';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude submenus size ]
					ifNone: [ -1 ] ]
			equals: 0;
		/ BrButton;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> clickElementWithDropdownInDropdown [
	<gtExample>
	| aScripter |
	aScripter := self hoverComplexSubmenu.

	aScripter click
		label: 'Display dropdown-in-dropdown';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu-in-submenu';
		play.

	aScripter assert
		label: 'Assert two dropdowns are opened';
		value: [ :aRootElement | (aRootElement query // BrMenuSteppedElement) result size ]
			equals: 2;
		onSpaceRoot;
		play.
		
	aScripter assert
		label: 'Assert dropdown has one submenu';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude submenus size ]
					ifNone: [ -1 ] ]
			equals: 1;
		/ BrButton;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> displayButtonWithDropdown [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithDropdown ]
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> hoverComplexSubmenu [
	<gtExample>
	| aScripter |
	aScripter := self clickButtonWithDropdown.

	aScripter mouseMoveOver
		label: 'Display submenu';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu-complex-submenu';
		play.

	aScripter assert
		label: 'Assert dropdown is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]
