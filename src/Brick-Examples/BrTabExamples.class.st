Class {
	#name : #BrTabExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Tab'
}

{ #category : #'as yet unclassified' }
BrTabExamples >> addTabAfterSelectedTab [
	<gtExample>
	<return: #BrTabModel>
	| aTabGroupModel aTab1 aTab2 aTab3 |
	aTabGroupModel := self tabGroupModel.
	aTab1 := self tabModel.
	aTabGroupModel addTabAfterSelectedTab: aTab1.
	self assert: aTab1 isSelected.
	aTab2 := self tabModel.
	aTabGroupModel addTabAfterSelectedTab: aTab2.
	self assert: aTab1 isSelected.
	aTab3 := self tabModel.
	aTabGroupModel addTabAfterSelectedTab: aTab3.
	self assert: aTabGroupModel tabs size equals: 3.
	self assert: (aTabGroupModel indexOf: aTab1) equals: 1.
	self assert: (aTabGroupModel indexOf: aTab2) equals: 3.
	self assert: (aTabGroupModel indexOf: aTab3) equals: 2.
	^ aTabGroupModel
]

{ #category : #'examples - tab model' }
BrTabExamples >> changeStencilTabModel [
	<gtExample>
	<return: #BrTabModel>
	| aTabModel stencilChangedHander changed changedTabModel changedTabStencil |
	changed := 0.
	changedTabModel := nil.
	changedTabStencil := nil.

	aTabModel := self tabModel.
	aTabModel
		addEventHandler: (stencilChangedHander := BlEventHandler
					on: BrTabStencilChangedEvent
					do: [ :anEvent | 
						changedTabModel := anEvent tab.
						changedTabStencil := anEvent stencil.
						changed := changed + 1 ]).

	aTabModel stencil: [ BlElement new ].

	self assert: changed equals: 1.
	self assert: changedTabStencil isNotNil.
	self assert: aTabModel contentStencilBuilder equals: changedTabStencil.
	self assert: changedTabModel equals: aTabModel.

	aTabModel removeEventHandler: stencilChangedHander.

	^ aTabModel
]

{ #category : #'examples - tab model' }
BrTabExamples >> changeToolbarStencilModel [
	<gtExample>
	<return: #BrTabModel>
	| aTabModel stencilChangedHander changed changedTabModel changedTabStencil |
	changed := 0.
	changedTabModel := nil.
	changedTabStencil := nil.

	aTabModel := self tabModel.
	aTabModel
		addEventHandler: (stencilChangedHander := BlEventHandler
					on: BrTabToolbarChangedEvent
					do: [ :anEvent | 
						changedTabModel := anEvent tab.
						changedTabStencil := anEvent stencil.
						changed := changed + 1 ]).

	aTabModel toolbarStencil: [ BrToolbar new ].

	self assert: changed equals: 1.
	self assert: changedTabStencil isNotNil.
	self assert: aTabModel toolbarStencilBuilder equals: changedTabStencil.
	self assert: changedTabModel equals: aTabModel.

	aTabModel removeEventHandler: stencilChangedHander.

	^ aTabModel
]

{ #category : #'examples - tab model' }
BrTabExamples >> deselectTabModel [
	<gtExample>
	<return: #BrTabModel>
	| aTabModel selected deselected deselectedTab selectedHandler deselectedHandler |
	selected := deselected := 0.
	deselectedTab := nil.

	aTabModel := self selectTabModel.
	aTabModel
		addEventHandler: (selectedHandler := BlEventHandler
					on: BrTabSelectedEvent
					do: [ :anEvent | selected := selected + 1 ]).

	aTabModel
		addEventHandler: (deselectedHandler := BlEventHandler
					on: BrTabDeselectedEvent
					do: [ :anEvent | 
						deselected := deselected + 1.
						deselectedTab := anEvent currentTarget ]).

	aTabModel deselect.

	self assert: aTabModel isSelected not.
	self assert: selected equals: 0.
	self assert: deselected equals: 1.
	self assert: deselectedTab equals: aTabModel.

	aTabModel removeEventHandler: selectedHandler.
	aTabModel removeEventHandler: deselectedHandler.

	^ aTabModel
]

{ #category : #'examples - ui header' }
BrTabExamples >> groupHeaderLook [
	<gtExample>
	<return: #BrTabGroupHeaderWithToolbarAptitude>
	^ BrTabGroupHeaderWithToolbarAptitude asLook
]

{ #category : #'examples - ui header' }
BrTabExamples >> groupHeaderWithAddedTabAtFirstPosition [
	<gtExample>
	<return: #BlElement>
	| aTabGroupModel aHeaderElement aHeaderLook anExistingTabModel anAddedTabModel |
	aTabGroupModel := self tabGroupWithOneTab.
	aHeaderLook := self groupHeaderLook.
	aHeaderElement := BlElement new
			viewModel: aTabGroupModel;
			aptitude: aHeaderLook;
			layout: BlLinearLayout vertical;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].

	self assert: aHeaderLook tabs size equals: 1.
	anExistingTabModel := aHeaderLook tabModels first.

	anAddedTabModel := self tabModel.
	aTabGroupModel addTab: anAddedTabModel at: 1.

	self assert: aHeaderLook tabs size equals: 2.
	self assert: aHeaderLook tabModels first equals: anAddedTabModel.
	self assert: aHeaderLook tabModels second equals: anExistingTabModel.

	^ aHeaderElement
]

{ #category : #'examples - ui header' }
BrTabExamples >> groupHeaderWithBoundTabs [
	<gtExample>
	<return: #BlElement>
	| aHeaderElement tabElement1 tabElement2 tabElement3 |
	aHeaderElement := self groupHeaderWithoutBoundTabs.	"binding order does not matter"
	tabElement2 := BlElement new
			viewModel: aHeaderElement viewModel tabs second;
			aptitude: self groupTabLook.

	self
		assert: aHeaderElement children asArray
		equals: {aHeaderElement aptitude header}.
	self
		assert: aHeaderElement children first children asArray
		equals: {aHeaderElement aptitude scrollTabbar.
				aHeaderElement aptitude toolbar.
				aHeaderElement aptitude actionbar}.

	self
		assert: aHeaderElement aptitude tabbar children asArray
		equals: {tabElement2}.

	tabElement1 := BlElement new
			viewModel: aHeaderElement viewModel tabs first;
			aptitude: self groupTabLook.

	self
		assert: aHeaderElement children asArray
		equals: {aHeaderElement aptitude header}.
	self
		assert: aHeaderElement aptitude tabbar children asArray
		equals: {tabElement1.
				tabElement2}.

	tabElement3 := BlElement new
			viewModel: aHeaderElement viewModel tabs third;
			aptitude: self groupTabLook.

	self
		assert: aHeaderElement children asArray
		equals: {aHeaderElement aptitude header}.
	self
		assert: aHeaderElement aptitude tabbar children asArray
		equals: {tabElement1.
				tabElement2.
				tabElement3}.

	^ aHeaderElement
]

{ #category : #'examples - ui header' }
BrTabExamples >> groupHeaderWithoutBoundTabs [
	<gtExample>
	<return: #BlElement>
	| tab1 tab2 tab3 tabGroup headerElement headerLook tabsRequest tabsChanged |
	tabsRequest := nil.

	tab1 := BrTabModel new add: (BrLabelModel text: 'Tab 1').
	tab2 := BrTabModel new add: (BrLabelModel text: 'Tab 2').
	tab3 := BrTabModel new add: (BrLabelModel text: 'Tab 3').

	tabGroup := BrTabGroupModel
			with: {tab1.
					tab2.
					tab3}.
	tabGroup
		when: BrTabGroupTabsRequest
		do: [ :aTabsRequest | tabsRequest := aTabsRequest copy ].

	headerLook := self groupHeaderLook.
	headerLook
		when: BrTabGroupTabsChangedEvent
		do: [ :aTabsChanged | tabsChanged := aTabsChanged copy ].

	headerElement := BlElement new
			viewModel: tabGroup;
			aptitude: headerLook;
			layout: BlLinearLayout vertical;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].

	self assert: tabsRequest isNotNil.
	self assert: tabsRequest source equals: headerLook.

	self assert: tabsChanged isNotNil.
	self assert: tabsChanged source equals: tabGroup.

	self assert: headerElement children asArray equals: {headerLook header}.

	^ headerElement
]

{ #category : #'examples - ui header' }
BrTabExamples >> groupTabLook [
	<gtExample>
	<return: #BrTextLabelAptitude>
	^ BrTextLabelAptitude new
]

{ #category : #'examples - tab group model' }
BrTabExamples >> moveNotSelectedTabInGroupWithTwoTabs_FromOne_ToTwo [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroup aSelectedTab aNotSelectedTab |
	aTabGroup := self tabGroupWithTwoTabsSelectedAfterAdding.

	aSelectedTab := aTabGroup selectedTab.
	self assert: aSelectedTab equals: aTabGroup tabs second.
	aNotSelectedTab := aTabGroup tabs first.
	aTabGroup moveTab: aNotSelectedTab at: 2.

	self assert: aTabGroup tabs size equals: 2.
	self assert: aTabGroup tabs first equals: aSelectedTab.
	self assert: aTabGroup tabs second equals: aNotSelectedTab.

	self assert: aTabGroup isNotEmpty.
	self assert: aTabGroup hasSelectedTab.
	self assert: aTabGroup selectedTab equals: aSelectedTab.
	self assert: aTabGroup selectedTab equals: aTabGroup tabs first.
	self assert: aTabGroup tabs first isSelected.
	self assert: aTabGroup tabs second isSelected not.

	^ aTabGroup
]

{ #category : #'examples - tab group model' }
BrTabExamples >> moveSelectedTabInGroupWithTwoTabs_FromTwo_ToOne [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroup aSelectedTab aNotSelectedTab |
	aTabGroup := self tabGroupWithTwoTabsSelectedAfterAdding.

	aSelectedTab := aTabGroup selectedTab.
	self assert: aSelectedTab equals: aTabGroup tabs second.
	aNotSelectedTab := aTabGroup tabs first.
	aTabGroup moveTab: aSelectedTab at: 1.

	self assert: aTabGroup tabs size equals: 2.
	self assert: aTabGroup tabs first equals: aSelectedTab.
	self assert: aTabGroup tabs second equals: aNotSelectedTab.

	self assert: aTabGroup isNotEmpty.
	self assert: aTabGroup hasSelectedTab.
	self assert: aTabGroup selectedTab equals: aSelectedTab.
	self assert: aTabGroup selectedTab equals: aTabGroup tabs first.
	self assert: aTabGroup tabs first isSelected.
	self assert: aTabGroup tabs second isSelected not.

	^ aTabGroup
]

{ #category : #'examples - tab group model' }
BrTabExamples >> removeNotSelectedTabFromGroupWithTwoTabs [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroup |
	aTabGroup := self tabGroupWithTwoTabsSelectedAfterAdding.

	self assert: aTabGroup selectedTab equals: aTabGroup tabs second.
	aTabGroup removeTab: aTabGroup tabs first.

	self assert: aTabGroup isNotEmpty.
	self assert: aTabGroup hasSelectedTab.
	self assert: aTabGroup selectedTab equals: aTabGroup tabs first.
	self assert: aTabGroup tabs first isSelected.

	^ aTabGroup
]

{ #category : #accessing }
BrTabExamples >> removeSelectedTab [
	<gtExample>
	<return: #BrTabGroupModel>
	| tabGroup |
	tabGroup := self tabGroupWithSecondSelectedTabAddedAtFirstPosition.
	self assert: tabGroup tabs size = 2.
	tabGroup removeSelectedTab.
	self assert: tabGroup tabs size = 1.
	^ tabGroup
]

{ #category : #'examples - tab group model' }
BrTabExamples >> removeSelectedTabFromGroupWithTwoTabs [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroup |
	aTabGroup := self tabGroupWithTwoTabsSelectedAfterAdding.

	self assert: aTabGroup selectedTab equals: aTabGroup tabs second.
	aTabGroup removeTab: aTabGroup selectedTab.

	self assert: aTabGroup isNotEmpty.
	self assert: aTabGroup hasSelectedTab.
	self assert: aTabGroup selectedTab equals: aTabGroup tabs first.
	self assert: aTabGroup tabs first isSelected.

	^ aTabGroup
]

{ #category : #'examples - tab model' }
BrTabExamples >> selectTabModel [
	<gtExample>
	<return: #BrTabModel>
	| aTabModel selected selectedTab deselected selectedHandler deselectedHandler |
	selected := deselected := 0.
	selectedTab := nil.

	aTabModel := self tabModel.
	aTabModel
		addEventHandler: (selectedHandler := BlEventHandler
					on: BrTabSelectedEvent
					do: [ :anEvent | 
						selected := selected + 1.
						selectedTab := anEvent currentTarget ]).

	aTabModel
		addEventHandler: (deselectedHandler := BlEventHandler
					on: BrTabDeselectedEvent
					do: [ :anEvent | deselected := deselected + 1 ]).

	aTabModel select.

	self assert: aTabModel isSelected.
	self assert: selected equals: 1.
	self assert: deselected equals: 0.
	self assert: selectedTab equals: aTabModel.

	aTabModel removeEventHandler: selectedHandler.
	aTabModel removeEventHandler: deselectedHandler.

	^ aTabModel
]

{ #category : #accessing }
BrTabExamples >> selectTabOnTheLeftOfTheFirstTab [
	<gtExample>
	<return: #BrTabGroupModel>
	| tabGroup |
	tabGroup := self tabGroupWithSecondSelectedTabAddedAtFirstPosition.
	self assert: tabGroup tabs first isSelected.
	tabGroup selectTabToTheLeft.
	self assert: tabGroup tabs first isSelected.
	^ tabGroup
]

{ #category : #accessing }
BrTabExamples >> selectTabOnTheLeftOfTheLastTab [
	<gtExample>
	<return: #BrTabGroupModel>
	| tabGroup |
	tabGroup := self tabGroupWithSecondSelectedTabAddedAtFirstPosition.
	tabGroup selectTab: tabGroup tabs last.
	tabGroup selectTabToTheLeft.
	self assert: tabGroup tabs first isSelected.
	^ tabGroup
]

{ #category : #accessing }
BrTabExamples >> selectTabOnTheRightOfTheFirstTab [
	<gtExample>
	<return: #BrTabGroupModel>
	| tabGroup |
	tabGroup := self tabGroupWithSecondSelectedTabAddedAtFirstPosition.
	self assert: tabGroup tabs first isSelected.
	tabGroup selectTabToTheRight.
	self assert: tabGroup tabs second isSelected.
	^ tabGroup
]

{ #category : #accessing }
BrTabExamples >> selectTabOnTheRightOfTheLastTab [
	<gtExample>
	<return: #BrTabGroupModel>
	| tabGroup |
	tabGroup := self tabGroupWithSecondSelectedTabAddedAtFirstPosition.
	tabGroup selectTab: tabGroup tabs last.
	tabGroup selectTabToTheRight.
	self assert: tabGroup tabs second isSelected.
	^ tabGroup
]

{ #category : #'instance creation' }
BrTabExamples >> tabGroupModel [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroup |
	aTabGroup := BrTabGroupModel new.
	self assert: aTabGroup isEmpty.
	self assert: aTabGroup hasSelectedTab not.

	^ aTabGroup
]

{ #category : #'examples - tab group model' }
BrTabExamples >> tabGroupWithOneTab [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroupModel aTab theEvents |
	aTabGroupModel := self tabGroupModel.
	self assert: aTabGroupModel isEmpty.
	self assert: aTabGroupModel hasSelectedTab not.

	aTab := self tabModel.

	theEvents := OrderedCollection new.
	aTab when: BrTabSelectedEvent do: [ :anEvent | theEvents add: anEvent ].

	self assert: aTab isSelected not.

	aTabGroupModel addTab: aTab.

	self assert: aTab isSelected.	"make sure that a tab received a selection wish"
	self assert: theEvents size equals: 1.
	self assert: (theEvents first isKindOf: BrTabSelectedEvent).
	self assert: theEvents first tab = aTab.

	self assert: aTabGroupModel isNotEmpty.
	self assert: aTabGroupModel hasSelectedTab.
	self assert: aTabGroupModel selectedTab equals: aTab.

	^ aTabGroupModel
]

{ #category : #'examples - tab group model' }
BrTabExamples >> tabGroupWithOneTabChangingStencil [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroupModel aTabModel changed changedTabModel changedTabStencil stencilChangedHandler |
	changed := 0.
	changedTabModel := nil.
	changedTabStencil := nil.

	aTabGroupModel := self tabGroupModel.
	aTabGroupModel
		addEventHandler: (stencilChangedHandler := BlEventHandler
					on: BrTabStencilChangedEvent
					do: [ :anEvent | 
						changedTabModel := anEvent tab.
						changedTabStencil := anEvent stencil.
						changed := changed + 1 ]).

	aTabModel := self tabModel.
	aTabGroupModel addTab: aTabModel.

	aTabModel stencil: [ BlElement new ].

	self assert: changed equals: 1.
	self assert: changedTabStencil isNotNil.
	self assert: aTabModel contentStencilBuilder equals: changedTabStencil.
	self assert: changedTabModel equals: aTabModel.

	aTabModel removeEventHandler: stencilChangedHandler.

	self assert: aTabGroupModel isNotEmpty.
	self assert: aTabGroupModel hasSelectedTab.
	self assert: aTabGroupModel selectedTab equals: aTabModel.

	^ aTabGroupModel
]

{ #category : #'examples - tab group model' }
BrTabExamples >> tabGroupWithOneTabChangingToolbarStencil [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroupModel aTabModel changed changedTabModel changedTabStencil stencilChangedHandler |
	changed := 0.
	changedTabModel := nil.
	changedTabStencil := nil.

	aTabGroupModel := self tabGroupModel.
	aTabGroupModel
		addEventHandler: (stencilChangedHandler := BlEventHandler
					on: BrTabToolbarChangedEvent
					do: [ :anEvent | 
						changedTabModel := anEvent tab.
						changedTabStencil := anEvent stencil.
						changed := changed + 1 ]).

	aTabModel := self tabModel.
	aTabGroupModel addTab: aTabModel.

	aTabModel toolbarStencil: [ BrToolbar new ].

	self assert: changed equals: 1.
	self assert: changedTabStencil isNotNil.
	self assert: aTabModel toolbarStencilBuilder equals: changedTabStencil.
	self assert: changedTabModel equals: aTabModel.

	aTabModel removeEventHandler: stencilChangedHandler.

	self assert: aTabGroupModel isNotEmpty.
	self assert: aTabGroupModel hasSelectedTab.
	self assert: aTabGroupModel selectedTab equals: aTabModel.

	^ aTabGroupModel
]

{ #category : #'examples - tab group model' }
BrTabExamples >> tabGroupWithSecondSelectedTabAddedAtFirstPosition [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroup aTab |
	aTabGroup := self tabGroupWithOneTab.

	aTab := self tabModel.
	aTab select.

	aTabGroup addTab: aTab at: 1.

	self assert: aTab isSelected.
	self assert: aTabGroup isNotEmpty.
	self assert: aTabGroup hasSelectedTab.
	self assert: aTabGroup selectedTab equals: aTab.

	^ aTabGroup
]

{ #category : #'examples - tab group model' }
BrTabExamples >> tabGroupWithSecondTabAddedAtFirstPosition [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroup aTab theEvents |
	aTabGroup := self tabGroupWithOneTab.

	aTab := self tabModel.

	aTabGroup addTab: aTab at: 1.

	theEvents := OrderedCollection new.
	aTab when: BrTabSelectedEvent do: [ :anEvent | theEvents add: anEvent ].

	self assert: theEvents isEmpty.
	self assert: aTab isSelected not.
	self assert: aTabGroup isNotEmpty.
	self assert: aTabGroup hasSelectedTab.
	self assert: aTabGroup selectedTab equals: (aTabGroup tabs at: 2).
	self assert: aTabGroup selectedTab ~= aTab.

	^ aTabGroup
]

{ #category : #'examples - tab group model' }
BrTabExamples >> tabGroupWithTabAddedAtFirstPosition [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroup anExistingTab anAddedTab |
	aTabGroup := self tabGroupWithOneTab.
	anExistingTab := aTabGroup tabs first.

	anAddedTab := self tabModel.

	aTabGroup addTab: anAddedTab at: 1.	"anAddedTab should be first"
	self assert: aTabGroup tabs first equals: anAddedTab.
	self assert: aTabGroup tabs second equals: anExistingTab.	"a tab selected after adding must become selected"
	anAddedTab select.

	self assert: anAddedTab isSelected.
	self assert: aTabGroup isNotEmpty.
	self assert: aTabGroup hasSelectedTab.
	self assert: aTabGroup selectedTab equals: anAddedTab.

	^ aTabGroup
]

{ #category : #'examples - tab group model' }
BrTabExamples >> tabGroupWithTwoTabsSelectedAfterAdding [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroup aTab |
	aTabGroup := self tabGroupWithOneTab.

	aTab := self tabModel.

	aTabGroup addTab: aTab.	"a tab selected after adding must become selected"
	aTab select.

	self assert: aTab isSelected.
	self assert: aTabGroup isNotEmpty.
	self assert: aTabGroup hasSelectedTab.
	self assert: aTabGroup selectedTab equals: aTab.

	^ aTabGroup
]

{ #category : #'examples - tab group model' }
BrTabExamples >> tabGroupWithTwoTabsSelectedBeforeAdding [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroup aTab |
	aTabGroup := self tabGroupWithOneTab.

	aTab := self tabModel.	"a tab selected before adding it to a group must remain selected"
	aTab select.

	aTabGroup addTab: aTab.

	self assert: aTab isSelected.

	self assert: aTabGroup isNotEmpty.
	self assert: aTabGroup hasSelectedTab.
	self assert: aTabGroup selectedTab equals: aTab.

	^ aTabGroup
]

{ #category : #'examples - tab group model' }
BrTabExamples >> tabGroupWithTwoTabsWithoutExplicitSelection [
	<gtExample>
	<return: #BrTabGroupModel>
	| aTabGroup aTab |
	aTabGroup := self tabGroupWithOneTab.

	aTab := self tabModel.
	aTabGroup addTab: aTab.

	self assert: aTab isSelected not.
	self assert: aTabGroup isNotEmpty.
	self assert: aTabGroup hasSelectedTab.
	self assert: aTabGroup selectedTab equals: aTabGroup tabs first.

	^ aTabGroup
]

{ #category : #'instance creation' }
BrTabExamples >> tabModel [
	<gtExample>
	<return: #BrTabModel>
	| aTabModel |
	aTabModel := BrTabModel new.
	self assert: aTabModel isSelected not.

	^ aTabModel
]
