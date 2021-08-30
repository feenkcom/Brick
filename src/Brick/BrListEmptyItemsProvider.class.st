Class {
	#name : 'BrListEmptyItemsProvider',
	#superclass : 'BrAbstractListItemsProvider',
	#category : 'Brick-List - Model'
}

{ #category : 'accessing' }
BrListEmptyItemsProvider >> currentItems [
	^ #()
]

{ #category : 'accessing' }
BrListEmptyItemsProvider >> itemAt: anIndex [
	^ self currentItems at: anIndex
]

{ #category : 'accessing' }
BrListEmptyItemsProvider >> itemCount [
	<return: #Number>

	^ 0
]
