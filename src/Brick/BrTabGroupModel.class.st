Class {
	#name : #BrTabGroupModel,
	#superclass : #BrWidgetModel,
	#instVars : [
		'tabs',
		'selectedTab',
		'tabEventHandler',
		'actionbarStencilBuilder'
	],
	#category : #'Brick-Tabs - Model'
}

{ #category : #'instance creation' }
BrTabGroupModel class >> with: aCollectionOfTabs [
	^ self new addTabs: aCollectionOfTabs
]

{ #category : #accessing }
BrTabGroupModel >> actionbarStencil: anActionbarStencilBuilder [
	"Set a stencil to be used to create an action bar in the header of the tabgroup.
	An action bar is usually located on the right side of the header"

	actionbarStencilBuilder := anActionbarStencilBuilder asStencilBuilder.
	self notifyActionbarChanged: actionbarStencilBuilder
]

{ #category : #'api - tabs' }
BrTabGroupModel >> addTab: aBrTabModel [
	self addTab: aBrTabModel at: self tabs size + 1
]

{ #category : #'api - tabs' }
BrTabGroupModel >> addTab: aBrTabModel at: anIndex [
	"Tab already exists, do nothing"
	(self hasTab: aBrTabModel)
		ifTrue: [ ^ self ].

	self tabs add: aBrTabModel beforeIndex: anIndex.
	self onTabAdded: aBrTabModel at: anIndex
]

{ #category : #'as yet unclassified' }
BrTabGroupModel >> addTabAfterSelectedTab: aBrTab [
	self hasSelectedTab
		ifTrue: [ self addTab: aBrTab at: (self indexOf: self selectedTab) + 1 ]
		ifFalse: [ self addTab: aBrTab ]
]

{ #category : #'api - tabs' }
BrTabGroupModel >> addTabs: aCollectionOfTabModels [
	aCollectionOfTabModels do: [ :aTabModel | self addTab: aTabModel ]
]

{ #category : #'api - tabs' }
BrTabGroupModel >> deselectTab: aBrTabModel [
	"there are no selected tabs, do nothing"
	self hasSelectedTab
		ifFalse: [ ^ self ].

	"tab is not selected, do nothing"
	(self selectedTab ~= aBrTabModel)
		ifTrue: [ ^ self ].
	
	"we nil it first so that by the time a listener receives an announcement,
	#hasSelectedTab will return false"
	selectedTab := nil.
	aBrTabModel deselect.

	self notifyTabDeselected: aBrTabModel
]

{ #category : #'api - testing' }
BrTabGroupModel >> hasSelectedTab [
	<return: #Boolean>
	
	^ selectedTab notNil
]

{ #category : #'api - testing' }
BrTabGroupModel >> hasTab: aBrTabModel [
	<return: #Boolean>
	
	^ self tabs identityIncludes: aBrTabModel
]

{ #category : #'api - tabs' }
BrTabGroupModel >> indexOf: aTab [
	"It returns 0 if a tab is not present"
	<return: #Number>

	^ self tabs indexOf: aTab
]

{ #category : #initialization }
BrTabGroupModel >> initialize [
	super initialize.

	tabs := OrderedCollection new.
	selectedTab := nil.
	tabEventHandler := BrTabGroupTabEventHandler new tabGroup: self.

	actionbarStencilBuilder := nil.
]

{ #category : #hooks }
BrTabGroupModel >> initializeListeners [
	super initializeListeners.
	
	"answer if somebody is interested in what tabs I have"
	self when: BrTabGroupTabsRequest reply: [ :aResponse | aResponse tabs: self tabs ].
	self when: BrTabGroupActionbarRequest reply: [ :aResponse | aResponse stencil: actionbarStencilBuilder ]
]

{ #category : #'api - testing' }
BrTabGroupModel >> isEmpty [
	"Return true if there are no tabs in a group, false otherwise"
	<return: #Boolean>
	
	^ self tabs isEmpty
]

{ #category : #'api - testing' }
BrTabGroupModel >> isNotEmpty [
	"Return true if there is at least one tab in a group, false otherwise"
	<return: #Boolean>

	^ self tabs isNotEmpty
]

{ #category : #'api - tabs' }
BrTabGroupModel >> moveTab: aBrTabModel at: aNewIndex [
	"Move a given tab so it appears at a given index"
	| currentIndex insertionIndex|

	self
		assert: (aNewIndex between: 1 and: self tabs size)
		description: [ 'A new tab index must be within bounds' ].

	currentIndex := self indexOf: aBrTabModel.
	
	self
		assert: [ currentIndex isZero not ]
		description: [ 'Only an existing tab can be moved' ].

	"trying to move a tab to the same position, do nothing"
	currentIndex = aNewIndex
		ifTrue: [ ^ self ].

	insertionIndex := aNewIndex.

	self tabs remove: aBrTabModel.
	self tabs add: aBrTabModel beforeIndex: insertionIndex.

	self notifyTabMoved: aBrTabModel from: currentIndex to: aNewIndex.
]

{ #category : #'api - tabs' }
BrTabGroupModel >> moveTab: aBrTabModel atCursor: aNewIndex [
	"Move a given tab so it appears at a given cursor index [0... tabs size]"
	| currentIndex beforeIndex insertionIndex |

	self
		assert: (aNewIndex between: 0 and: self tabs size)
		description: [ 'A new tab index must be within bounds' ].

	currentIndex := self indexOf: aBrTabModel.
	
	self
		assert: [ currentIndex isZero not ]
		description: [ 'Only an existing tab can be moved' ].

	"do nothing whe trying to move a tab to the same position"
	(currentIndex = aNewIndex or: [ (currentIndex - 1) = aNewIndex ])
		ifTrue: [ ^ self ].

		
	beforeIndex := aNewIndex > currentIndex
		ifTrue: [ aNewIndex ]
		ifFalse: [ (aNewIndex + 1) min: self tabs size ].

	self tabs remove: aBrTabModel.
	self tabs add: aBrTabModel beforeIndex: beforeIndex.
	
	insertionIndex := self indexOf: aBrTabModel.
	
	self notifyTabMoved: aBrTabModel from: currentIndex to: insertionIndex
]

{ #category : #notifying }
BrTabGroupModel >> notifyActionbarChanged: aStencil [
	self dispatchEvent: (BrTabGroupActionbarChangedEvent new stencil: aStencil)
]

{ #category : #notifying }
BrTabGroupModel >> notifyTabAdded: aBrTabModel at: anIndex [
	self dispatchEvent: ((BrTabAddedEvent tab: aBrTabModel) position: anIndex)
]

{ #category : #notifying }
BrTabGroupModel >> notifyTabDeselected: aBrTabModel [
	self dispatchEvent: (BrTabDeselectedEvent tab: aBrTabModel)
]

{ #category : #notifying }
BrTabGroupModel >> notifyTabMoved: aBrTabModel from: anOldIndex to: aNewIndex [
	self dispatchEvent: ((BrTabMovedEvent tab: aBrTabModel) 
		oldPosition: anOldIndex;
		newPosition: aNewIndex)
]

{ #category : #notifying }
BrTabGroupModel >> notifyTabRemoved: aBrTabModel [
	self dispatchEvent: (BrTabRemovedEvent tab: aBrTabModel)
]

{ #category : #notifying }
BrTabGroupModel >> notifyTabSelected: aBrTabModel [
	self dispatchEvent: (BrTabSelectedEvent tab: aBrTabModel)
]

{ #category : #notifying }
BrTabGroupModel >> notifyTabStencilChanged: anEvent [
	self dispatchEvent: anEvent
]

{ #category : #notifying }
BrTabGroupModel >> notifyTabToolbarChanged: anEvent [
	self dispatchEvent: anEvent
]

{ #category : #hooks }
BrTabGroupModel >> onTabAdded: aBrTabModel at: anIndex [

	aBrTabModel addEventHandler: tabEventHandler.
	self notifyTabAdded: aBrTabModel at: anIndex.

	"if user adds a tab marked as selected we should force select it"
	aBrTabModel isSelected
		ifTrue: [ ^ self selectTab: aBrTabModel ].

	"the first added tab should be selected by default"
	self tabs size = 1
		ifTrue: [ self selectTab: aBrTabModel ]
]

{ #category : #hooks }
BrTabGroupModel >> onTabRemoved: aBrTabModel at: anIndex [

	aBrTabModel removeEventHandler: tabEventHandler.
	self notifyTabRemoved: aBrTabModel.
]

{ #category : #accessing }
BrTabGroupModel >> removeSelectedTab [
	self selectedTabDo: [ :aTab | self removeTab: aTab].
]

{ #category : #'api - tabs' }
BrTabGroupModel >> removeTab: aBrTabModel [
	| aTabIndex wasSelected |

	"trying to remove a tab that does not exist"
	(self hasTab: aBrTabModel)
		ifFalse: [ ^ self ].

	"we have to deselect removed tab and select a new one before sending tab removed event
	otherwise deselection event will not bubble"
	wasSelected := aBrTabModel isSelected.
	self deselectTab: aBrTabModel.

	aTabIndex := self tabs indexOf: aBrTabModel.
	self tabs remove: aBrTabModel.
	self onTabRemoved: aBrTabModel at: aTabIndex.

	"if removed tab was selected we should select a tab that took its place"
	(wasSelected and: [ self isNotEmpty ])
		ifTrue: [ self selectTab: (self tabs at: (aTabIndex min: self tabs size)) ]
]

{ #category : #'api - tabs' }
BrTabGroupModel >> selectTab: aBrTabModel [
	"a given tab is already selected, do nothing"
	(self hasSelectedTab and: [ self selectedTab = aBrTabModel ])
		ifTrue: [ ^ self ].
	
	"deselected a previously selected tab"
	self hasSelectedTab
		ifTrue: [ self deselectTab: self selectedTab ].
	
	selectedTab := aBrTabModel.
	selectedTab select.

	self notifyTabSelected: aBrTabModel
]

{ #category : #accessing }
BrTabGroupModel >> selectTabToTheLeft [
	self selectedTabDo: [:aTab | 
		self selectTab: (self tabs 
			before: aTab 
			ifAbsent: [ aTab ]) ]
]

{ #category : #accessing }
BrTabGroupModel >> selectTabToTheRight [
	self selectedTabDo: [:aTab | 
		self selectTab: (self tabs 
			after: aTab 
			ifAbsent: [ aTab ]) ]
]

{ #category : #'api - tabs' }
BrTabGroupModel >> selectedTab [
	<return: #BrTabModel>
	
	self
		assert: [ self hasSelectedTab ]
		description: [ 'Can not access a selected tab if there is no one' ].
		
	^ selectedTab
]

{ #category : #accessing }
BrTabGroupModel >> selectedTabDo: aBlock [ 
	self hasSelectedTab ifFalse: [^ self].
	aBlock value: selectedTab
]

{ #category : #accessing }
BrTabGroupModel >> tabs [
	<return: #Collection of: #BrTabModel>

	^ tabs
]
