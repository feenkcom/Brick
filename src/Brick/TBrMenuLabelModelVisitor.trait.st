Trait {
	#name : #TBrMenuLabelModelVisitor,
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
TBrMenuLabelModelVisitor >> visitMenuIconTextLabelModel: aLabelModel [
	^ self visitMenuTextLabelModel: aLabelModel
]

{ #category : #visiting }
TBrMenuLabelModelVisitor >> visitMenuLabelModel: aLabelModel [
	
]

{ #category : #visiting }
TBrMenuLabelModelVisitor >> visitMenuTextLabelModel: aLabelModel [
	^ self visitMenuLabelModel: aLabelModel
]
