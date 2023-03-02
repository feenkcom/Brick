Class {
	#name : #BrContextMenuRightAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'element',
		'positionInElement'
	],
	#category : #'Brick-Context Menu - Look'
}

{ #category : #accessing }
BrContextMenuRightAptitude >> element: anObject [
	element := anObject
]

{ #category : #initialization }
BrContextMenuRightAptitude >> initialize [
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
							c frame horizontal alignLeft.
							c frame vertical alignCenter ];
						padding: (BlInsets
								top: 0
								left: 0
								bottom: 0
								right: handle width);
						removeChild: handle;
						addChildFirst: handle.
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
								fromParent: element) y).
							c linear horizontal alignLeft.
							c linear vertical alignTop ] ];
				down: [ :e | 
					| handle |
					handle := widget childNamed: #handle.
					handle margin: (BlInsets top: 0) ];
				yourself)
]

{ #category : #accessing }
BrContextMenuRightAptitude >> position: anEventPointInSpaceRoot [
	positionInElement := anEventPointInSpaceRoot
]
