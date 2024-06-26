Class {
	#name : #BrTabGroupContentAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'content'
	],
	#category : #'Brick-Tabs - Look'
}

{ #category : #'api - accessing' }
BrTabGroupContentAptitude >> content [
	<return: #BlElement>

	^ content
]

{ #category : #'api - accessing' }
BrTabGroupContentAptitude >> contentDo: aBlock [
	aBlock value: self content
]

{ #category : #initialization }
BrTabGroupContentAptitude >> initialize [
	super initialize.

	content := BlElement new 
		layout: BlLinearLayout horizontal;
		labeled: 'Content'.
	
	self add: (BrLayoutResizerAptitude new inherit: content).

	self addChangeAddChildAs: #(content) with: [ content ]
]

{ #category : #initialization }
BrTabGroupContentAptitude >> initializeListeners [
	super initializeListeners.

	self when: BrTabSelectedEvent do: [ :anEvent | self onTabSelected: anEvent tab ].
	self when: BrTabDeselectedEvent do: [ :anEvent | self onTabDeselected: anEvent tab ].
	self when: BrTabRemovedEvent do: [ :anEvent | self onTabRemoved: anEvent tab ].
	self when: BrTabStencilChangedEvent do: [ :anEvent | self onTabStencilChanged: anEvent tab ].
]

{ #category : #initialization }
BrTabGroupContentAptitude >> initializeRequests [
	super initializeRequests.
	
	self request: BrSelectionRequest new
]

{ #category : #hooks }
BrTabGroupContentAptitude >> onTabDeselected: aTabModel [
	self widgetContent removeChildren
]

{ #category : #hooks }
BrTabGroupContentAptitude >> onTabRemoved: aTabModel [
	aTabModel
		cachedContentElementDo: [ :aRemovedContentElement |
			aRemovedContentElement withAllChildrenBreadthFirstDo: [ :anElement |
				anElement dispatchEvent: BrWidgetPermanentlyRemovedEvent new ] ]
		ifAbsent: [ ^ self ]
]

{ #category : #hooks }
BrTabGroupContentAptitude >> onTabSelected: aTabModel [

	self widgetContent
		removeChildren;
		addChild: aTabModel contentElement
]

{ #category : #hooks }
BrTabGroupContentAptitude >> onTabStencilChanged: aTabModel [
	self onTabRemoved: aTabModel.	
	aTabModel isSelected ifTrue: [ 
		self onTabSelected: aTabModel ]
]
