Class {
	#name : #BrTextCursorStylableAttribute,
	#superclass : #BrTextCursorProtoAttribute,
	#instVars : [
		'attributes'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextCursorStylableAttribute >> attribute: aTextAttribute [
	self attributes: { aTextAttribute }
]

{ #category : #accessing }
BrTextCursorStylableAttribute >> attributes [
	^ attributes
]

{ #category : #accessing }
BrTextCursorStylableAttribute >> attributes: aCollectionOfAttributes [
	"Set a collection of attribtues that should be added when user hover a text with a mouse"
	attributes := aCollectionOfAttributes
]

{ #category : #initialization }
BrTextCursorStylableAttribute >> initialize [
	super initialize.

	attributes := #().
	enterAction := [ :aText :aTextElement :aTextEditor :anEvent | aText attributes: self attributes ].
	leaveAction := [ :aText :aTextElement :aTextEditor :anEvent |
		aText clearAttributes: [ :aTextAttribute | self attributes identityIncludes: aTextAttribute ] ]
]
