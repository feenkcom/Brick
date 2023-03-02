"
Display a context menu to the left of an anchor.
#Example
{{gtExample: BrAnchoredByScripterExamples >> #longContextMenuTheLeft | codeExpanded=false | previewExpanded=true | previewShow=#gtSpaceFor: | previewHeight=600}}
"
Class {
	#name : #BrContextMenuLeftAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'element',
		'positionInElement'
	],
	#category : #'Brick-Context Menu - Look'
}

{ #category : #accessing }
BrContextMenuLeftAptitude >> element: anObject [
	element := anObject
]

{ #category : #initialization }
BrContextMenuLeftAptitude >> initialize [
	super initialize.
	self
		addChange: (BrLookChange new
				up: [ :e | 
					| handle content |
					handle := widget childNamed: #handle.
					content := widget childNamed: #content.
					widget
						layout: BlLinearLayout horizontal;
						constraintsDo: [ :c | 
							c horizontal fitContentLimited.
							c vertical fitContentLimited.
							c frame horizontal alignRight.
							c frame vertical alignCenter ];
						padding: (BlInsets
								top: 0
								left: 0
								bottom: 0
								right: 0);
						removeChild: handle;
						addChild: handle.
					content
						constraintsDo: [ :c | 
							c horizontal fitContentLimited.
							c vertical fitContentLimited ];
						margin: (BlInsets
								top: 0
								left: 0
								bottom: 0
								right: 0).
					handle
						constraintsDo: [ :c | 
							"We use this workaround to display the handle
							in the place of click."
							c margin: (BlInsets top: (widget
								globalPointToMine: positionInElement 
								fromParent: element) y - 4).
							c linear horizontal alignLeft.
							c linear vertical alignTop ] ];
				down: [ :e | 
					| handle |
					handle := widget childNamed: #handle.
					handle margin: (BlInsets top: 0) ];
				yourself)
]

{ #category : #accessing }
BrContextMenuLeftAptitude >> position: anEventPointInSpaceRoot [
	positionInElement := anEventPointInSpaceRoot
]
