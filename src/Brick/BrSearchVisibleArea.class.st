Class {
	#name : #BrSearchVisibleArea,
	#superclass : #BrSearchArea,
	#category : #'Brick-List - Search Model'
}

{ #category : #'api - search' }
BrSearchVisibleArea >> findItems: aMarkContext using: aMarker [
	<return: #Array of: #BrSearchFoundItem>
	^ aMarkContext source 
		findVisibleItems: aMarkContext 
		using: aMarker
]
