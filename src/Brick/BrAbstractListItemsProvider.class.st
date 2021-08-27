Class {
	#name : 'BrAbstractListItemsProvider',
	#superclass : 'BrWidgetModel',
	#instVars : [
		'listModel'
	],
	#category : 'Brick-List - Model'
}

{ #category : 'converting' }
BrAbstractListItemsProvider >> asBrItemsProvider [
	^ self
]

{ #category : 'accessing' }
BrAbstractListItemsProvider >> attachToListModel: aListModel [
	listModel := aListModel
]

{ #category : 'accessing' }
BrAbstractListItemsProvider >> currentItems [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
BrAbstractListItemsProvider >> itemAt: anIndex [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
BrAbstractListItemsProvider >> itemCount [
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : 'accessing' }
BrAbstractListItemsProvider >> listModel [

	^ listModel
]
