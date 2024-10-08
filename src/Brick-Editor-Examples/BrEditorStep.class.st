"
I provide {{gtClass:BlScripter}} {{gtClass:BrEditor}} steps. 
"
Class {
	#name : #BrEditorStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'Brick-Editor-Examples-Scripter'
}

{ #category : #'steps - checks' }
BrEditorStep >> assertTextEqualsTo: aString [
	^ self assert
		label: ('Assert editor text is "{1}"' format: {self privateShortString: aString});
		value: [ :anEditor | anEditor text asString ] equals: aString;
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrEditor
]

{ #category : #private }
BrEditorStep >> privateShortString: aText [
	| aString |
	aString := aText asString.
	aString size <= 20 ifTrue: [ ^ aString ].
	^ (aString first: 20) , '...'
]

{ #category : #'steps - interactions' }
BrEditorStep >> selectAll [
	^ self do
		referenceSender;
		label: 'Select all editor text';
		block: [ :anEditor | anEditor selecter all; select ];
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrEditor
]

{ #category : #'steps - interactions' }
BrEditorStep >> typeText: aString [
	^ self type
		referenceSender;
		label: ('Type text "{1}"' format: {self privateShortString: aString});
		text: aString;
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrEditor
]
