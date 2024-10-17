Class {
	#name : #BrTextEditorAttributesModifiedSignal,
	#superclass : #BrTextEditorSignal,
	#instVars : [
		'fromIndex',
		'toIndex',
		'affectedText'
	],
	#category : #'Brick-Editor-Signals'
}

{ #category : #accessing }
BrTextEditorAttributesModifiedSignal >> affectedText [
	^ affectedText
]

{ #category : #accessing }
BrTextEditorAttributesModifiedSignal >> affectedText: anObject [
	affectedText := anObject
]

{ #category : #accessing }
BrTextEditorAttributesModifiedSignal >> fromIndex [
	^ fromIndex
]

{ #category : #accessing }
BrTextEditorAttributesModifiedSignal >> fromIndex: anObject [
	fromIndex := anObject
]

{ #category : #accessing }
BrTextEditorAttributesModifiedSignal >> toIndex [
	^ toIndex
]

{ #category : #accessing }
BrTextEditorAttributesModifiedSignal >> toIndex: anObject [
	toIndex := anObject
]
