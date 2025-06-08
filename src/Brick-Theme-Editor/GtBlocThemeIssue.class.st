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
GtBlocThemeIssue >> fixItForTheme: aTheme [
	^ nil
]

{ #category : #'as yet unclassified' }
GtBlocThemeIssue >> isSeriousIssue [
	^ false
]
