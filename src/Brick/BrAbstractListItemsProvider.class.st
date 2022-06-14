Class {
	#name : #BrAbstractListItemsProvider,
	#superclass : #Object,
	#instVars : [
		'listModel'
	],
	#category : #'Brick-List - Model'
}

{ #category : #converting }
BrAbstractListItemsProvider >> asBrItemsProvider [
	^ self
]

{ #category : #accessing }
BrAbstractListItemsProvider >> attachToListModel: aListModel [
	listModel := aListModel
]

{ #category : #accessing }
BrAbstractListItemsProvider >> currentItems [
	^ self subclassResponsibility
]

{ #category : #accessing }
BrAbstractListItemsProvider >> isDone [

	^ self subclassResponsibility
]

{ #category : #accessing }
BrAbstractListItemsProvider >> itemAt: anIndex [
	^ self subclassResponsibility
]

{ #category : #accessing }
BrAbstractListItemsProvider >> itemCount [
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #accessing }
BrAbstractListItemsProvider >> listModel [

	^ listModel
]

{ #category : #'private - notifying' }
BrAbstractListItemsProvider >> notifyItemsChangedSynchronously: isSynchronous [
	listModel ifNotNil: [ :aListModel |
		aListModel dispatchEvent: (BrListModelItemsChangedEvent new
			viewModel: aListModel;
			isSynchronous: isSynchronous) ]
]

{ #category : #'api - loading' }
BrAbstractListItemsProvider >> preloadUntilFoundSuchThat: aBlock [
	<return: #TAsyncPromise>

	^ self subclassResponsibility
]
