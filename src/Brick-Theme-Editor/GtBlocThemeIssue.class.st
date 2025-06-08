Class {
	#name : #GtBlocThemeIssue,
	#superclass : #Object,
	#category : #'Brick-Theme-Editor-Issues'
}

{ #category : #'as yet unclassified' }
GtBlocThemeIssue >> canFixIt [
	^ false
]

{ #category : #accessing }
GtBlocThemeIssue >> description [
	^ self printString
]

{ #category : #'as yet unclassified' }
GtBlocThemeIssue >> fixIt [
	^ nil
]

{ #category : #'as yet unclassified' }
GtBlocThemeIssue >> isSeriousIssue [
	^ false
]
