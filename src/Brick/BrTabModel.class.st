Class {
	#name : #BrTabModel,
	#superclass : #BrWidgetModel,
	#instVars : [
		'contentStencilBuilder',
		'cachedContentElement',
		'toolbarStencilBuilder',
		'actionbarStencilBuilder',
		'selected'
	],
	#category : #'Brick-Tabs - Model'
}

{ #category : #'api - tab' }
BrTabModel >> actionbarStencil: anActionbarStencilBuilder [
	"Set a stencil to be used to create an action bar for this tab.
	An action bar is usually located inside of the tab itself, for example a close button"

	actionbarStencilBuilder := anActionbarStencilBuilder asStencilBuilder: BrTabStencilBuilder.
	self notifyActionbarChanged: actionbarStencilBuilder
]

{ #category : #accessing }
BrTabModel >> actionbarStencilBuilder [
	<return: #BrStencilBuilder>

	^ actionbarStencilBuilder
]

{ #category : #'api - tab' }
BrTabModel >> actionsStencil: anActionStencilBuilder [
	self
		deprecated: 'Please use #toolbarStencil: instead'
		transformWith: '`@receiver actionsStencil:: `@statements1' 
						-> '`@receiver toolbarStencil: `@statements1'.
	
	self toolbarStencil: anActionStencilBuilder
]

{ #category : #accessing }
BrTabModel >> cachedContentElementDo: aBlock ifAbsent: anotherBlock [
	^ cachedContentElement
		ifNotNil: aBlock
		ifNil: anotherBlock
]

{ #category : #'mouse handlers' }
BrTabModel >> clickEvent: anEvent [
	(self widget states hasState: BlElementState disabled)
		ifTrue: [ ^ self ].

	anEvent consumed: true.
	self select
]

{ #category : #accessing }
BrTabModel >> contentElement [
	"Return a cached content element for the tab if already present,
	otherwise use a content stencil to instantiate tab's content"
	
	cachedContentElement
		ifNotNil: [ :anElement | ^ anElement ].

	cachedContentElement := self contentStencilBuilder
		tabModel: self;
		asElement.
	
	^ cachedContentElement
]

{ #category : #accessing }
BrTabModel >> contentStencilBuilder [
	<return: #BrTabStencilBuilder>
	
	^ contentStencilBuilder
]

{ #category : #'api - selection' }
BrTabModel >> deselect [
	self isSelected
		ifFalse: [ ^ self ].
		
	selected := false.
	self dispatchEvent: (BrTabDeselectedEvent new tab: self)
]

{ #category : #hooks }
BrTabModel >> initialize [
	super initialize.
	
	selected := false.
	cachedContentElement := nil
]

{ #category : #hooks }
BrTabModel >> initializeListeners [
	super initializeListeners.

	self when: BlClickEvent do: [ :anEvent | self clickEvent: anEvent ].
	self when: BrTabActionbarRequest reply: [ :aResponse | aResponse stencil: actionbarStencilBuilder ].
	self when: BrTabToolbarRequest reply: [ :aResponse | aResponse stencil: toolbarStencilBuilder ].
]

{ #category : #'api - selection' }
BrTabModel >> isSelected [
	<return: #Boolean>

	^ selected
]

{ #category : #notifying }
BrTabModel >> notifyActionbarChanged: aStencil [
	self dispatchEvent: (BrTabActionbarChangedEvent new tab: self; stencil: aStencil)
]

{ #category : #notifying }
BrTabModel >> notifyStencilChanged: aStencil [
	self dispatchEvent: (BrTabStencilChangedEvent new tab: self; stencil: aStencil)
]

{ #category : #notifying }
BrTabModel >> notifyToolbarChanged: aStencil [
	self dispatchEvent: (BrTabToolbarChangedEvent new tab: self; stencil: aStencil)
]

{ #category : #'api - selection' }
BrTabModel >> select [
	self isSelected
		ifTrue: [ ^ self ].
		
	selected := true.
	self dispatchEvent: (BrTabSelectedEvent new tab: self)
]

{ #category : #'api - selection' }
BrTabModel >> selected: aBoolean [
	aBoolean
		ifTrue: [ self select ]
		ifFalse: [ self deselect ]
]

{ #category : #'api - tab' }
BrTabModel >> stencil: aStencilBuilder [
	"Set a stencil to be used to create a content of a tab.
	It should be computed lazily by the Tab widget on demand"

	contentStencilBuilder := aStencilBuilder asStencilBuilder: BrTabStencilBuilder.
	cachedContentElement := nil.

	self notifyStencilChanged: contentStencilBuilder
]

{ #category : #accessing }
BrTabModel >> tabLabel [
	^ self findActor: BrLabelModel
]

{ #category : #'api - tab' }
BrTabModel >> toolbarStencil: aToolbarStencilBuilder [
	"Set a stencil to be used to create a toolbar for this tab.
	A toolbar is usually located on the right side of a tab group header and changes depending
	on the currently selected tab"

	toolbarStencilBuilder := aToolbarStencilBuilder asStencilBuilder: BrTabStencilBuilder.
	self notifyToolbarChanged: toolbarStencilBuilder
]

{ #category : #accessing }
BrTabModel >> toolbarStencilBuilder [
	<return: #BrStencilBuilder>

	^ toolbarStencilBuilder
]
