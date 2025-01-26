Trait {
	#name : #TBrMenuModelVisitor,
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
TBrMenuModelVisitor >> visitMenu: aMenuModel [
	^ self visitMenuModel: aMenuModel
]

{ #category : #visiting }
TBrMenuModelVisitor >> visitMenuActionItem: aMenuModel [
	^ self visitMenuLabeledItem: aMenuModel
]

{ #category : #visiting }
TBrMenuModelVisitor >> visitMenuExplicit: aMenuModel [
	^ self visitMenu: aMenuModel
]

{ #category : #visiting }
TBrMenuModelVisitor >> visitMenuExplicitHandle: aMenuModel [
	^ self visitMenuHandle: aMenuModel
]

{ #category : #visiting }
TBrMenuModelVisitor >> visitMenuHandle: aMenuModel [
	^ self visitMenuModel: aMenuModel
]

{ #category : #visiting }
TBrMenuModelVisitor >> visitMenuItem: aMenuModel [
	^ self visitMenuModel: aMenuModel
]

{ #category : #visiting }
TBrMenuModelVisitor >> visitMenuItems: aMenuModel [
	^ self visitMenu: aMenuModel
]

{ #category : #visiting }
TBrMenuModelVisitor >> visitMenuLabeledItem: aMenuModel [
	^ self visitMenuItem: aMenuModel
]

{ #category : #visiting }
TBrMenuModelVisitor >> visitMenuModel: aMenuModel [
]

{ #category : #visiting }
TBrMenuModelVisitor >> visitMenuSubmenuItem: aMenuModel [
	^ self visitMenuLabeledItem: aMenuModel
]
