"
I am a special marker attribute that is intended to be used together with {{gtMethod:BlText>>#findAttribute:indicesDo:}} to dynamically find text interval indices

"
Class {
	#name : #BrTextInvisibleMarkerAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'purpose'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #printing }
BrTextInvisibleMarkerAttribute >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Marker'.

	purpose ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		print: purpose;
		nextPut: $)
]

{ #category : #printing }
BrTextInvisibleMarkerAttribute >> printOn: aStream [
	super printOn: aStream.

	purpose ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		print: purpose;
		nextPut: $)
]

{ #category : #accessing }
BrTextInvisibleMarkerAttribute >> purpose [
	^ purpose
]

{ #category : #accessing }
BrTextInvisibleMarkerAttribute >> purpose: anObject [
	purpose := anObject
]

{ #category : #comparing }
BrTextInvisibleMarkerAttribute >> type [
	^ self
]
