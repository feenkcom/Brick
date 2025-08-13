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
BrWidgetPermanentlyRemovedEvent class >> notifyWithAllChildren: aParentElement [
	"All children are notified that are permanently removed.
	Note: aParentElement must be already removed from the scene graph (space),
	so that it does not schedule any tasks, e.g., due to canceled future promises."
	
	self assert: [ aParentElement isAttachedToSceneGraph not ].

	aParentElement withAllChildrenBreadthFirstDo: [ :anElement | 
		anElement dispatchEvent: self new ]
]

{ #category : #sending }
BrWidgetPermanentlyRemovedEvent >> sendTo: anObject [
	^ anObject widgetPermanentlyRemovedEvent: self
]
