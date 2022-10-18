"
I am a text attribute that adds a small expand button that when clicked may apply further attributes on the text
"
Class {
	#name : #BrGlamorousTriangleExpanderTextAttribute,
	#superclass : #BrTextExpandButtonAttribute,
	#instVars : [
		'id'
	],
	#category : #'Brick-Glamorous'
}

{ #category : #accessing }
BrGlamorousTriangleExpanderTextAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aToggle |

	aToggle := BrTriangle new
		id: self id;
		aptitude: BrGlamorousTriangleInCircleAptitude;
		expanded: self isExpanded;
		padding: (BlInsets all: 2);
		margin: (BlInsets top: 2);
		mouseCursor: BlCursor default;
		toggleAction: [
			self
				toggleExpandedOrCollapsedAttributesOn: aTBrTextEditorTextualPiece
				in: anEditorElement editor ].
		
	self
		applyExpandedOrCollapsedAttributesOn: aTBrTextEditorTextualPiece
		in: anEditorElement editor.

	^ aToggle
]

{ #category : #accessing }
BrGlamorousTriangleExpanderTextAttribute >> id [
	<return: #BlElementId>
	
	^ id
]

{ #category : #accessing }
BrGlamorousTriangleExpanderTextAttribute >> id: anElementId [
	id := anElementId
]

{ #category : #accessing }
BrGlamorousTriangleExpanderTextAttribute >> initialize [
	super initialize.
	
	id := BlElementId noId
]
