Class {
	#name : #GtBlocThemeChange,
	#superclass : #Object,
	#category : #'Brick-Theme-Editor-Changes'
}

{ #category : #'as yet unclassified' }
GtBlocThemeChange class >> description [
	^ self name
]

{ #category : #'as yet unclassified' }
GtBlocThemeChange class >> priority [
	^ 10
]

{ #category : #'as yet unclassified' }
GtBlocThemeChange >> affectedClass [
	^ nil
]

{ #category : #'as yet unclassified' }
GtBlocThemeChange >> applyOnNamespace: aRBNamespace [
]

{ #category : #'as yet unclassified' }
GtBlocThemeChange >> isRedundantForNamespace: aRBNamespace [
	^ false
]
