Class {
	#name : #BrThemeableLook,
	#superclass : #BrLook,
	#instVars : [
		'delegate',
		'addedToSceneGraphEventHandler'
	],
	#category : #'Brick-Theme'
}

{ #category : #accessing }
BrThemeableLook >> delegate: aLook [
	| widget_ |
	widget_ := widget.
	widget_ ifNotNil: [ self onUninstalledIn: widget_ ].
	delegate
		ifNil: [ actors := actors copyWithFirst: aLook ]
		ifNotNil: [ self
				assert: [ delegate == actors at: 1 ]
				description:
					'delegate must be first child, otherwise someone else messed with the array'.
			actors at: 1 put: aLook ].
	delegate := aLook.
	widget_ ifNotNil: [ self onInstalledIn: widget_ ]
]

{ #category : #accessing }
BrThemeableLook >> initialize [
	super initialize.
	addedToSceneGraphEventHandler := BlEventHandler
		on: BlElementAddedToSceneGraphEvent
		do: [ self delegate: (widget theme newLookFor: widget) ].
	self
		addChange:
			(BrLookChange new
				up: [ :e | widget addEventHandler: addedToSceneGraphEventHandler ];
				down: [ :e | widget removeEventHandler: addedToSceneGraphEventHandler ];
				yourself)
]