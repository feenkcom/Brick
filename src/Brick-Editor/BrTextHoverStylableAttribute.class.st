"
I add attributes to a piece of text when user hovers it with a mouse, then I remove those attributes when the mouse is no longer over the text
"
Class {
	#name : #BrTextHoverStylableAttribute,
	#superclass : #BrTextHoverAttribute,
	#instVars : [
		'attributes'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextHoverStylableAttribute >> attribute: aTextAttribute [
	self attributes: { aTextAttribute }
]

{ #category : #accessing }
BrTextHoverStylableAttribute >> attributes [
	^ attributes
]

{ #category : #accessing }
BrTextHoverStylableAttribute >> attributes: aCollectionOfAttributes [
	"Set a collection of attribtues that should be added when user hover a text with a mouse"
	attributes := aCollectionOfAttributes
]

{ #category : #views }
BrTextHoverStylableAttribute >> gtEnterActionFor: aView [
	<gtView>
	^ aView forward
		title: 'Enter action';
		priority: 10;
		object: [ enterAction ];
		view: #gtSourceCodeFor:
]

{ #category : #views }
BrTextHoverStylableAttribute >> gtLeaveActionFor: aView [
	<gtView>
	^ aView forward
		title: 'Leave action';
		priority: 11;
		object: [ leaveAction ];
		view: #gtSourceCodeFor:
]

{ #category : #initialization }
BrTextHoverStylableAttribute >> initialize [
	super initialize.

	attributes := #().
	enterAction := [ :aText :aTextElement :aTextEditor :anEvent | aText attributes: self attributes ].
	leaveAction := [ :aText :aTextElement :aTextEditor :anEvent |
		aText clearAttributes: [ :aTextAttribute | self attributes identityIncludes: aTextAttribute ] ]
]
