Class {
	#name : #BrTextByteRange,
	#superclass : #BrTextRange,
	#category : #'Brick-Editor-Model'
}

{ #category : #testing }
BrTextByteRange >> isByteRange [
	^ true
]

{ #category : #printing }
BrTextByteRange >> typeName [
	^ 'Byte'
]
