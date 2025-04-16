"
I am a common aptitude for menu elements that displays defining method source code.
"
Class {
	#name : #BrGlamorousPopoverDefiningMethodAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'menuModel'
	],
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #initialization }
BrGlamorousPopoverDefiningMethodAptitude >> initialize [
	super initialize.

	self add: BrPopoverCommonAptitude new.

	self
		addChange: (BrLookChange new
				up: [ :aLook | 
					aLook widgetDo: [ :aCoderElement | 
						aCoderElement 
							hExact: 500;
							vFitContentLimited;
							background: aCoderElement theme default contentBackgroundColor ] ];
				down: [ :aLook |  ];
				yourself).

	self
		addChange: (BrLookChange new
				up: [ :aLook | 
					aLook widgetDo: [ :aCoderElement | 
						menuModel ifNotNil: [ :aMenuModel | 
							aMenuModel id ifNotNil: [ :anId | 
								aCoderElement id: anId ] ] ] ];
				down: [ :aLook | 
					aLook widgetDo: [ :aCoderElement |
						menuModel ifNotNil: [ :aMenuModel | 
							aMenuModel id ifNotNil: [ :anId | 
								aCoderElement id: BlElementId noId ] ] ] ];
				yourself)
]

{ #category : #accessing }
BrGlamorousPopoverDefiningMethodAptitude >> menuModel [
	<return: #BrMenuModel>
	^ menuModel
]

{ #category : #accessing }
BrGlamorousPopoverDefiningMethodAptitude >> menuModel: aMenuModel [
	menuModel := aMenuModel.

	aMenuModel ifNil: [ ^ self ].

	self
		add: (BrGlamorousPopoverPinnableAptitude new
				menuModel: aMenuModel;
				withResizers;
				withAllPinActions);
		add: (BrPopoverHideableAptitude new menuModel: aMenuModel)
]
