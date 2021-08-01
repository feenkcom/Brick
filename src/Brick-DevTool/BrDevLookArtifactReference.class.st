Class {
	#name : #BrDevLookArtifactReference,
	#superclass : #Object,
	#instVars : [
		'lookClass',
		'artifact',
		'methods'
	],
	#category : #'Brick-DevTool'
}

{ #category : #accessing }
BrDevLookArtifactReference >> aptitudeClass [
	^ lookClass
]

{ #category : #accessing }
BrDevLookArtifactReference >> aptitudeClass: anObject [
	lookClass := anObject
]

{ #category : #accessing }
BrDevLookArtifactReference >> artifact [
	^ artifact
]

{ #category : #accessing }
BrDevLookArtifactReference >> artifact: anObject [
	artifact := anObject
]

{ #category : #accessing }
BrDevLookArtifactReference >> methods [
	^ methods
]

{ #category : #accessing }
BrDevLookArtifactReference >> methods: anObject [
	methods := anObject
]
