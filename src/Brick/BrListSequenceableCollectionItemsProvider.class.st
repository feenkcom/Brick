Class {
	#name : #BrListSequenceableCollectionItemsProvider,
	#superclass : #BrAbstractListItemsProvider,
	#instVars : [
		'collection'
	],
	#category : #'Brick-List - Model'
}

{ #category : #'instance creation' }
BrListSequenceableCollectionItemsProvider class >> forCollection: aSequenceableCollection [
	^ self new collection: aSequenceableCollection
]

{ #category : #accessing }
BrListSequenceableCollectionItemsProvider >> attachToListModel: aListModel [
	super attachToListModel: aListModel.

	self notifyItemsChangedSynchronously: true
]

{ #category : #accessing }
BrListSequenceableCollectionItemsProvider >> collection [

	^ collection
]

{ #category : #accessing }
BrListSequenceableCollectionItemsProvider >> collection: aSequenceableCollection [
	self
		assert: [
			[ aSequenceableCollection size isZero
				or: [ aSequenceableCollection at: 1 ]. true ]
			on: Error do: [ :e | false ] ]
		description: [ 'Collection must be indexable but was {1}' format: { aSequenceableCollection class } ].

	collection := aSequenceableCollection
]

{ #category : #accessing }
BrListSequenceableCollectionItemsProvider >> currentItems [
	^ collection
]

{ #category : #initialization }
BrListSequenceableCollectionItemsProvider >> initialize [
	super initialize.
	
	collection := #()
]

{ #category : #accessing }
BrListSequenceableCollectionItemsProvider >> isDone [
	^ true
]

{ #category : #accessing }
BrListSequenceableCollectionItemsProvider >> itemAt: anIndex [
	^ self collection at: anIndex
]

{ #category : #accessing }
BrListSequenceableCollectionItemsProvider >> itemCount [
	<return: #Number>

	^ self collection size
]

{ #category : #'api - loading' }
BrListSequenceableCollectionItemsProvider >> preloadUntilFoundSuchThat: aBlock [
	<return: #TAsyncPromise>

	^ AsyncFulfilledPromise new value: (collection
		detectIndex: aBlock
		ifNone: [ 0 ])
]
