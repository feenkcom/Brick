"
I am a special marker attribute that is intended to be used together with {{gtMethod:BlText>>#findAttribute:indicesDo:}} to dynamically find text interval indices

"
Class {
	#name : #BrTextInvisibleMarkerAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'purpose',
		'userData'
	],
	#category : 'Brick-Editor-Attributes'
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

{ #category : #initialization }
BrTextInvisibleMarkerAttribute >> initialize [
	super initialize.

	"initialized lazily"
	userData := nil.
]

{ #category : #accessing }
BrTextInvisibleMarkerAttribute >> model [
	"Returns an application dependent model."

	userData ifNil: [ ^ nil ].
	^ self userData at: #model ifAbsent: [ nil ]
]

{ #category : #accessing }
BrTextInvisibleMarkerAttribute >> model: aModel [
	"Sets an application dependent model."

	self userData at: #model put: aModel
]

{ #category : #accessing }
BrTextInvisibleMarkerAttribute >> modelIfPresent: aPresentBlock ifAbsent: anAbsentBlock [
	userData ifNil: [ ^ anAbsentBlock value ].
	^ self userData
		at: #model
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
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
	"Returns an application dependent purpose id to easily identify who uses this marker."

	^ purpose
]

{ #category : #accessing }
BrTextInvisibleMarkerAttribute >> purpose: aSymbol [
	"Sets an application dependent purpose id to easily identify who uses this marker."

	purpose := aSymbol
]

{ #category : #comparing }
BrTextInvisibleMarkerAttribute >> type [
	^ self
]

{ #category : #accessing }
BrTextInvisibleMarkerAttribute >> userData [
	"Returns a Dictionary that holds application dependent and temporary objects."

	<return: #Dictionary>
	^ userData ifNil: [ userData := IdentityDictionary new ]
]
