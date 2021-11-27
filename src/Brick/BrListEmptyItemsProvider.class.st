Class {
	#name : #BrListEmptyItemsProvider,
	#superclass : #BrAbstractListItemsProvider,
	#category : #'Brick-List - Model'
}

{ #category : #accessing }
BrListEmptyItemsProvider >> currentItems [
	^ #()
]

{ #category : #accessing }
BrListEmptyItemsProvider >> itemAt: anIndex [
	^ self currentItems at: anIndex
]

{ #category : #accessing }
BrListEmptyItemsProvider >> itemCount [
	<return: #Number>

	^ 0
]

{ #category : #'api - loading' }
BrListEmptyItemsProvider >> preloadUntilFoundSuchThat: aBlock [
	<return: #TAsyncPromise>

	^ AsyncFulfilledPromise new value: 0
]
