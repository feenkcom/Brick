"
I am a {{gtClass:BrWish}} indicating that whole menu (with its submenus and parents) should be hidden.
I am used internally. 
Users should use dedicated events to hide specific menu widgets:
- for dropdowns: {{gtClass:BrDropdownHideWish}}, 
- for context menus: {{gtClass:BrContextMenuHideWish}}, 
- for tooltips: {{gtClass:BrTooltipHideWish}}. 
"
Class {
	#name : #BrMenuHideAllWish,
	#superclass : #BrMenuWish,
	#instVars : [
		'menuModel',
		'menuElement'
	],
	#category : #'Brick-Menu - Events'
}
