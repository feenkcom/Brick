"
Is emitted by a widget from top to bottom when that widget or part of it is permanently removed from the space.
For example it should be emitted when a tab of a tab group is closed or a page is removed from a pager.
This event allow widgets to perform a cleanup such as stopping background tasks when they are permanently removed.
"
Class {
	#name : #BrWidgetPermanentlyRemovedEvent,
	#superclass : #BlEvent,
	#category : #'Brick-! Core - Events'
}
