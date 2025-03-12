"
I am a {{gtClass:BrMenuModelAnnouncement}}. 
I notify menu elements about menu item selection changes..
Note: This announcement can be announced only from the UI process.
#Example
In the following example, the `Paste` menu item is selected: {{gtExample:BrMenuWithScripterExamples>>#hoverPasteItemKeepingTheSecondDropdownOpened | noCode=true | previewHeight=700 | previewShow=#gtScreenshotFor: }}
"
Class {
	#name : #BrMenuItemSelectionChangedAnnouncement,
	#superclass : #BrMenuModelAnnouncement,
	#instVars : [
		'isSelected'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuItemSelectionChangedAnnouncement >> isSelected [
	<return: #Boolean>
	^ isSelected
]

{ #category : #accessing }
BrMenuItemSelectionChangedAnnouncement >> isSelected: aBoolean [
	isSelected := aBoolean
]
