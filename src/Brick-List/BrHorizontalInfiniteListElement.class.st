"
I am a {{gtClass:BlInfiniteElement}}
I am a horizontal infinite list.


"
Class {
	#name : #BrHorizontalInfiniteListElement,
	#superclass : #BlInfiniteElement,
	#category : #'Brick-List-Support'
}

{ #category : #initialization }
BrHorizontalInfiniteListElement >> defaultDataSource [
	^ BrSimpleListDataSource new
]

{ #category : #initialization }
BrHorizontalInfiniteListElement >> defaultLayout [
	^ BlInfiniteLinearLayout horizontal
]

{ #category : #initialization }
BrHorizontalInfiniteListElement >> defaultMouseScrollEventHandler [
	^ BlInfiniteMouseOrientationRestrictedScrollListener new
]
