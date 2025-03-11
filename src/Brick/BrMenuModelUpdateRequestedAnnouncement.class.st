"
I am a {{gtClass:BrMenuModelAnnouncement}}. 
I notify menu elements that they should update, e.g., {{gtClass:BrMenuItemLabeledElement}} should updated its label text. 
Note: This announcement can be announced only from the UI process.
# Example
In the following example, users can right-click on the circle to open a context menu. The context menu updates as users click on the `Increase` menu item:  {{gtExample: BrMenuWithScripterExamples >> #menuWithUpdatableMenuItems_demo | noCode=true | previewShow=#gtLiveFor: }}

"
Class {
	#name : #BrMenuModelUpdateRequestedAnnouncement,
	#superclass : #BrMenuModelAnnouncement,
	#category : #'Brick-Menu - Events'
}
