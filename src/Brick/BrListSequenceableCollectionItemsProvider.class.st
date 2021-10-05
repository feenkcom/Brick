Class {
	#name : #BrListSequenceableCollectionItemsProvider,
	#superclass : #BrAbstractListItemsProvider,
	#instVars : [
		'collection'
	],
	#category : 'Brick-List - Model'
}

{ #category : #'instance creation' }
BrListSequenceableCollectionItemsProvider class >> forCollection: aSequenceableCollection [
	^ self new collection: aSequenceableCollection
]

{ #category : #accessing }
BrListSequenceableCollectionItemsProvider >> attachToListModel: aListModel [
	super attachToListModel: aListModel.

	aListModel dispatchEvent: (BrListModelItemsChangedEvent new viewModel: aListModel).
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
BrListSequenceableCollectionItemsProvider >> itemAt: anIndex [
	^ self collection at: anIndex
]

{ #category : #accessing }
BrListSequenceableCollectionItemsProvider >> itemCount [
	<return: #Number>

	^ self collection size
]
