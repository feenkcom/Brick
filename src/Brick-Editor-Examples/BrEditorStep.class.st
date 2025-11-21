"
I provide {{gtClass:BlScripter}} {{gtClass:BrEditor}} steps. 
"
Class {
	#name : #BrEditorStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'Brick-Editor-Examples-Scripter'
}

{ #category : #'steps - checks' }
BrEditorStep >> assertFullyVisibleParagraphAt: anIndexBlock hasNotText: aStringBlock [
	| aParagraph |
	^ self assert referenceSender
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrEditor;
		label: ('Assert paragraph at `{1}` has not text: {2}'
				format: {anIndexBlock.
						aStringBlock value});
		satisfies: [ :anEditor | 
				| anEditorBounds allVisibleParagraphs |
				anEditorBounds := anEditor bounds inSpace bounds asRectangle.
				allVisibleParagraphs := anEditor children
						select: [ :eachParagraph | 
							| isVisible |
							isVisible := true.
							eachParagraph
								allParentsDo: [ :eachParent | isVisible := isVisible & (eachParagraph isVisibleFullyInParent: eachParent) ].
							isVisible ].
				aParagraph := anIndexBlock cull: allVisibleParagraphs.
				aParagraph text asString ~= aStringBlock value ]
			description: [ :anEditor | 
				'Paragraph line at `{1}` must not have: `{2}`'
					format: {anIndexBlock.
							aParagraph ifNotNil: [ aParagraph text asString ]} ]
]

{ #category : #'steps - checks' }
BrEditorStep >> assertFullyVisibleParagraphAt: anIndexBlock hasText: aStringBlock [
	| aParagraph |
	^ self assert referenceSender
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrEditor;
		label: ('Assert paragraph at `{1}` has text: {2}'
				format: {anIndexBlock.
						aStringBlock value});
		satisfies: [ :anEditor | 
				| anEditorBounds allVisibleParagraphs |
				anEditorBounds := anEditor bounds inSpace bounds asRectangle.
				allVisibleParagraphs := anEditor children
						select: [ :eachParagraph | 
							| isVisible |
							isVisible := true.
							eachParagraph
								allParentsDo: [ :eachParent | isVisible := isVisible & (eachParagraph isVisibleFullyInParent: eachParent) ].
							isVisible ].
				aParagraph := anIndexBlock cull: allVisibleParagraphs.
				aParagraph text asString = aStringBlock value ]
			description: [ :anEditor | 
				'Paragraph line at `{1}` has `{2}`, but `{3}` is expected'
					format: {anIndexBlock.
							aParagraph ifNotNil: [ aParagraph text asString ].
							aStringBlock value} ]
]

{ #category : #'steps - checks' }
BrEditorStep >> assertIsEditableSingleLineMode [
	^ self assertModeClassIs: BrTextEditorEditableSingleLineMode
]

{ #category : #'steps - checks' }
BrEditorStep >> assertModeClassIs: aClass [
	^ self assert
		label: ('Assert editor mode is {1}' format: {aClass});
		value: [ :anEditor | anEditor viewModel mode class ] equals: aClass;
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrEditor
]

{ #category : #'steps - checks' }
BrEditorStep >> assertTextEqualsTo: aString [
	^ self assert
		label: ('Assert editor text is "{1}"' format: {self privateShortString: aString});
		value: [ :anEditor | anEditor text asString ] equals: aString;
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrEditor
]

{ #category : #'steps - interactions' }
BrEditorStep >> deselectAll [
	^ self do
		referenceSender;
		label: 'Select all editor text';
		block: [ :anEditor | anEditor selecter all; select ];
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrEditor
]

{ #category : #'steps - interactions' }
BrEditorStep >> moveToEnd [
	^ self keyPress
		label: 'Move to end';
		key: BlKeyboardKey end;
		referenceSender
]

{ #category : #'steps - interactions' }
BrEditorStep >> pressPrimaryReturn [
	^ self keyPress
		label: 'Press return';
		key: BlKeyboardKey return;
		modifiers: BlKeyModifiers primary;
		referenceSender
]

{ #category : #'steps - interactions' }
BrEditorStep >> pressReturn [
	^ self keyPress
		label: 'Press return';
		key: BlKeyboardKey return;
		referenceSender
]

{ #category : #'steps - interactions' }
BrEditorStep >> pressTab [
	^ self keyPress
		label: 'Press tab';
		key: BlKeyboardKey tab;
		referenceSender
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
	"The event is eventually handled in {{gtMethod:BrTextEditorInsertionHandler>>#textInputEvent:}}. 
	Note that all characters must be printable, otherwise the event is ignored."
	
	^ self type
		referenceSender;
		label: ('Type text "{1}"' format: {self privateShortString: aString});
		text: aString;
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrEditor
]
