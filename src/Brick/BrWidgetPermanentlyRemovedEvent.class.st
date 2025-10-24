"
Is emitted by a widget from top to bottom when that widget or part of it is permanently removed from the space.
For example it should be emitted when a tab of a tab group is closed or a page is removed from a pager.
This event allow widgets to perform a cleanup such as stopping background tasks when they are permanently removed.
Use the {{gtMethod:BrWidgetPermanentlyRemovedEvent class>>#notifyWithAllChildren:}} convenience method all removed elements.
"
Class {
	#name : #BrWidgetPermanentlyRemovedEvent,
	#superclass : #BlEvent,
	#category : #'Brick-! Core - Events'
}

{ #category : #'api - convenience' }
BrWidgetPermanentlyRemovedEvent class >> notifyElements: aCollectionOfElements [
	"All elements and their children are notified that are permanently removed.
	Note: Elements must be already removed from the scene graph (space),
	so that it does not schedule any tasks, e.g., due to canceled future promises."

	aCollectionOfElements do: [ :aParentElement |
		self notifyWithAllChildren: aParentElement ]
]

{ #category : #'api - convenience' }
BrWidgetPermanentlyRemovedEvent class >> notifyWithAllChildren: aParentElement [
	"All children are notified that are permanently removed.
	Note: aParentElement must be already removed from the scene graph (space),
	so that it does not schedule any tasks, e.g., due to canceled future promises."
	
	self assert: [ aParentElement isAttachedToSceneGraph not ].

	aParentElement withAllChildrenBreadthFirstDo: [ :anElement | 
		anElement dispatchEvent: self new ]
]

{ #category : #'api - convenience' }
BrWidgetPermanentlyRemovedEvent class >> removeElement: anElement [
	"Given alement is removed from its parent and
	the element and its children are notified that are permanently removed."

	anElement removeFromParent.
	self notifyElements: {anElement}
]

{ #category : #'api - convenience' }
BrWidgetPermanentlyRemovedEvent class >> removeElements: aCollectionOfElements [
	"Given alements are removed from their parents and
	all elements and their children are notified that are permanently removed."

	aCollectionOfElements do: #removeFromParent.
	self notifyElements: aCollectionOfElements
]

{ #category : #sending }
BrWidgetPermanentlyRemovedEvent >> sendTo: anObject [
	^ anObject widgetPermanentlyRemovedEvent: self
]
