Class {
	#name : #BrSearchEverything,
	#superclass : #BrSearchArea,
	#category : #'Brick-List - Search Model'
}

{ #category : #'api - search' }
BrSearchEverything >> findItems: aMarkContext using: aMarker [
	<return: #TAsyncPromise of: #Array of: #BrSearchFoundItem>
	^ aMarkContext source 
		findAllItems: aMarkContext 
		using: aMarker
]

{ #category : #'api - markers' }
BrSearchEverything >> mark: aMarkContext using: aMarker [
	| foundItemsPromise aPromise |
	foundItemsPromise := self findItems: aMarkContext using: aMarker.

	aPromise := foundItemsPromise
			then: [ :aCollection | 
				aMarker 
					asyncMarkFoundItems: aCollection 
					context: aMarkContext ]
			otherwise: [ :anException | 
				aMarker 
					notifyException: anException
					context: aMarkContext ].
			
	aMarkContext elementDo: [ :anElement |
		anElement enqueueTask: (BlPromiseTask new promise: aPromise) ]. 
]
