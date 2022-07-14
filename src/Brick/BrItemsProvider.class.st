Class {
	#name : #BrItemsProvider,
	#superclass : #Object,
	#instVars : [
		'listModel'
	],
	#category : #'Brick-! Core - Item Providers'
}

{ #category : #converting }
BrItemsProvider >> asBrItemsProvider [
	^ self
]

{ #category : #accessing }
BrItemsProvider >> attachToListModel: aListModel [
	listModel := aListModel
]

{ #category : #accessing }
BrItemsProvider >> currentItems [
	^ self subclassResponsibility
]

{ #category : #accessing }
BrItemsProvider >> isDone [

	^ self subclassResponsibility
]

{ #category : #accessing }
BrItemsProvider >> itemAt: anIndex [
	^ self subclassResponsibility
]

{ #category : #accessing }
BrItemsProvider >> itemCount [
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #accessing }
BrItemsProvider >> listModel [

	^ listModel
]

{ #category : #'private - notifying' }
BrItemsProvider >> notifyItemsChangedSynchronously: isSynchronous [
	listModel ifNotNil: [ :aListModel |
		aListModel dispatchEvent: (BrItemsProviderItemsChangedEvent new
			viewModel: aListModel;
			isSynchronous: isSynchronous) ]
]

{ #category : #'api - loading' }
BrItemsProvider >> preloadUntilFoundSuchThat: aBlock [
	<return: #TAsyncPromise>

	^ self subclassResponsibility
]
