Class {
	#name : #BrTextEditorUpdater,
	#superclass : #BrTextEditorOperator,
	#instVars : [
		'intervals',
		'shouldRecreate',
		'commandClass'
	],
	#category : #'Brick-Editor-Model - Operators'
}

{ #category : #'api - configuration' }
BrTextEditorUpdater >> all [
	self from: 1 to: self text size
]

{ #category : #'api - configuration' }
BrTextEditorUpdater >> from: aFromTextIndex to: aToTextIndex [
	"Both from and to indices must be given in text coordinates"

	intervals add: (aFromTextIndex to: aToTextIndex)
]

{ #category : #initialization }
BrTextEditorUpdater >> initialize [
	super initialize.

	intervals := OrderedCollection new.
	shouldRecreate := true.
	commandClass := BrTextEditorUpdateCommand
]

{ #category : #'api - configuration' }
BrTextEditorUpdater >> redrawOnly [
	shouldRecreate := false.
	commandClass := BrTextEditorInvalidateCommand
]

{ #category : #'api - processing' }
BrTextEditorUpdater >> update [
	intervals
		do: [ :eachInterval | 
			self editor
				enqueueCommand: (commandClass new
						fromIndex: eachInterval first;
						toIndex: eachInterval last) ]
]
