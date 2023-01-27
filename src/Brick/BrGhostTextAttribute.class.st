Class {
	#name : #BrGhostTextAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'text'
	],
	#category : #'Brick-Attributes'
}

{ #category : #accessing }
BrGhostTextAttribute class >> for: aText [
	^ self new
		for: aText;
		beAppend;
		beNotOverwritableByStyler;
		withoutCache;
		yourself
]

{ #category : #accessing }
BrGhostTextAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| element |
	element := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new
					labelDo: [ :aLabel | 
						aLabel
							editorMeasurement;
							padding: BlInsets empty ]);
			preventMeAndChildrenMouseEvents;
			text: text;
			yourself.

	self updateVisibilityOf: element in: anEditorElement.
	element
		when: BrTextEditorTextChangedRequest
		do: [ :anEvent | self updateVisibilityOf: element in: anEditorElement ].
	^ element
]

{ #category : #accessing }
BrGhostTextAttribute >> for: aText [
	text := aText
]

{ #category : #accessing }
BrGhostTextAttribute >> updateVisibilityOf: element in: anEditorElement [
	^ anEditorElement text isEmpty
		ifTrue: [ element visibility: BlVisibility visible ]
		ifFalse: [ element visibility: BlVisibility gone ]
]
