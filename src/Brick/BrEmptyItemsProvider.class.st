Class {
	#name : #BrEmptyItemsProvider,
	#superclass : #BrItemsProvider,
	#category : #'Brick-! Core - Item Providers'
}

{ #category : #accessing }
BrEmptyItemsProvider >> currentItems [
	^ #()
]

{ #category : #accessing }
BrEmptyItemsProvider >> isDone [
	^ true
]

{ #category : #accessing }
BrEmptyItemsProvider >> itemAt: anIndex [
	^ self currentItems at: anIndex
]

{ #category : #accessing }
BrEmptyItemsProvider >> itemCount [
	<return: #Number>

	^ 0
]

{ #category : #'api - loading' }
BrEmptyItemsProvider >> preloadUntilFoundSuchThat: aBlock [
	<return: #TAsyncPromise>

	^ AsyncFulfilledPromise new value: 0
]
