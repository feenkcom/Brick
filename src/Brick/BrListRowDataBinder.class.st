Class {
	#name : #BrListRowDataBinder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'itemNode',
		'itemPosition',
		'rowElement'
	],
	#category : #'Brick-List - Stencil'
}

{ #category : #'api - instantiation' }
BrListRowDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ nil
]

{ #category : #accessing }
BrListRowDataBinder >> itemNode [
	^ itemNode
]

{ #category : #accessing }
BrListRowDataBinder >> itemNode: anObject [
	itemNode := anObject
]

{ #category : #accessing }
BrListRowDataBinder >> itemPosition [
	^ itemPosition
]

{ #category : #accessing }
BrListRowDataBinder >> itemPosition: anObject [
	itemPosition := anObject
]

{ #category : #'api - instantiation' }
BrListRowDataBinder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self rowElement;
		push: self itemNode;
		push: self itemPosition
]

{ #category : #initialization }
BrListRowDataBinder >> reset [
	super reset.
	
	rowElement := nil.
	itemNode := nil.
	itemPosition := nil
]

{ #category : #accessing }
BrListRowDataBinder >> rowElement [
	^ rowElement
]

{ #category : #accessing }
BrListRowDataBinder >> rowElement: anObject [
	rowElement := anObject
]
