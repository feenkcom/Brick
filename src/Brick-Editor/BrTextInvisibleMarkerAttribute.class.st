"
I am a special marker attribute that is intended to be used together with {{gtMethod:BlText>>#findAttribute:indicesDo:}} to dynamically find text interval indices

"
Class {
	#name : #BrTextInvisibleMarkerAttribute,
	#superclass : #BlTextAttribute,
	#category : #'Brick-Editor-Attributes'
}

{ #category : #printing }
BrTextInvisibleMarkerAttribute >> gtDisplayOn: stream [
	stream nextPutAll: 'Marker'
]

{ #category : #comparing }
BrTextInvisibleMarkerAttribute >> type [
	^ self
]
