Trait {
	#name : #TBrMenuWithMenuModel,
	#instVars : [
		'menuModel'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - menu' }
TBrMenuWithMenuModel >> menuModel [
	<return: #BrMenuModel>
	^ menuModel
]

{ #category : #'api - menu' }
TBrMenuWithMenuModel >> menuModel: aMenuModel [
	menuModel = aMenuModel ifTrue: [ ^ self ].

	menuModel ifNotNil: [ self unsubscribeFromMenuModel ].
	menuModel := aMenuModel.
	self onMenuModelChanged.
	self subscribeToMenuModel
]

{ #category : #'event handling' }
TBrMenuWithMenuModel >> onMenuModelChanged [
	
]

{ #category : #'event handling' }
TBrMenuWithMenuModel >> subscribeToMenuModel [
]

{ #category : #'event handling' }
TBrMenuWithMenuModel >> unsubscribeFromMenuModel [
]
