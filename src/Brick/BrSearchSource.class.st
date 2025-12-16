Class {
	#name : #BrSearchSource,
	#superclass : #Object,
	#category : #'Brick-List - Search Model'
}

{ #category : #'api - search' }
BrSearchSource >> findAllItems: aMarkContext using: aMarker [
	<return: #TAsyncPromise of: #Array of: #BrSearchFoundItem>
	^ self subclassResponsibility
]

{ #category : #'api - search' }
BrSearchSource >> findVisibleItems: aMarkContext using: aMarker [
	^ self subclassResponsibility
]

{ #category : #'api - testing' }
BrSearchSource >> hasSource [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #'api - testing' }
BrSearchSource >> hasVisibleSource [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #'api - markers' }
BrSearchSource >> markAll: aMarkContext using: aMarker [
	^ self subclassResponsibility
]
