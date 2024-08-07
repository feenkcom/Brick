"
I provide {{gtClass:BlScripter}} {{gtClass:BrEditor}} steps. 
"
Class {
	#name : #BrEditorStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'Brick-Editor-Examples-Scripter'
}

{ #category : #'steps - interactions' }
BrEditorStep >> selectAll [
	^ self do
		referenceSender;
		label: 'Select all editor text';
		block: [ :anEditor | anEditor selecter all; select ];
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrEditor
]
