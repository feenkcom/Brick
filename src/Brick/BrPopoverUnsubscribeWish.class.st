"
I am a {{gtClass:BrPopoverWish}}. 
I am dispatched when 
- a menu element should be unsubscribed from its {{gtClass:BrMenuModel}}, and
- a menu element should be unsubscribed from {{gtClass:BrMenuUpdateSubscriptions | label=user subscriptions}}. 
# Example
In the following example, users can right-click on the circle to open a context menu. The context menu updates as users click on the `Increase` menu item. The update happens due to {{gtMethod: BrMenuItem>>#updateWhen:from: | label=a user announcement subscription }}. When the context menu is closed, the user subscriptions are unsubscribed: {{gtExample: BrMenuWithScripterExamples >> #menuWithUpdatableMenuItems_demo | noCode=true | previewShow=#gtLiveFor: }}

"
Class {
	#name : #BrPopoverUnsubscribeWish,
	#superclass : #BrPopoverWish,
	#instVars : [
		'alsoUserSubscriptions'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrPopoverUnsubscribeWish >> alsoUserSubscriptions [
	^ alsoUserSubscriptions ifNil: [ true ]
]

{ #category : #accessing }
BrPopoverUnsubscribeWish >> alsoUserSubscriptions: aBoolean [
	alsoUserSubscriptions := aBoolean
]
