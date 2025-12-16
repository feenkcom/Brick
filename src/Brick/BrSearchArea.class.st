Class {
	#name : #BrSearchArea,
	#superclass : #Object,
	#instVars : [
		'execution'
	],
	#category : #'Brick-List - Search Model'
}

{ #category : #initialization }
BrSearchArea >> defaultExecution [
	^ BrSearchSameProcessExecution new
]

{ #category : #'api - search' }
BrSearchArea >> findItems: aMarkContext using: aMarker [
	^ self subclassResponsibility
]

{ #category : #initialization }
BrSearchArea >> initialize [
	super initialize.
	execution := self defaultExecution
]

{ #category : #'api - markers' }
BrSearchArea >> mark: aMarkContext using: aMarker [
	self subclassResponsibility
]
