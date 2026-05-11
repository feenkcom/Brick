Class {
	#name : #BrGlamorousTriangleExpanderTextAttributeV2,
	#superclass : #BrTextExpanderTextAttributeV2,
	#instVars : [
		'stencil',
		'expandedAppendingAttribute'
	],
	#category : #'Brick-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousTriangleExpanderTextAttributeV2 >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aToggle |

	aToggle := BrInlineExpanderElement new
			id: self id;
			aptitude: BrGlamorousTriangleInCircleExpanderAptitude;
			expanded: self isExpanded;
			padding: (BlInsets all: 2);
			margin: (BlInsets top: 2);
			mouseCursor: BlCursor default;
			toggleAction: [ self toggleExpandedOrCollapsedIn: anEditorElement ];
			when: BlClickEvent
				do: [ :anEvent | 
					anEvent modifiers isAlt
						ifTrue: [ anEvent consumed: true.
							anEvent target phlow
								spawnObject: (self definingMethod ifNil: [ self ] ifNotNil: [ :meth | meth ]) ] ].

	^ aToggle
]

{ #category : #'as yet unclassified' }
BrGlamorousTriangleExpanderTextAttributeV2 >> expandedAppendingAttribute [
	^ expandedAppendingAttribute
]

{ #category : #'as yet unclassified' }
BrGlamorousTriangleExpanderTextAttributeV2 >> initialize [
	super initialize.

	expandedAppendingAttribute := BrTextAdornmentDynamicAttribute new
		beAppend;
		stencil: [ :aSegmentPiece :anEditor | stencil ]
]

{ #category : #'as yet unclassified' }
BrGlamorousTriangleExpanderTextAttributeV2 >> stencil: aBlStencil [
	stencil := aBlStencil asStencil
]
