Class {
	#name : #BrWithAnchoredAptitudeWithHandleAndContentStencil,
	#superclass : #BrWithAnchoredAptitudeStencil,
	#instVars : [
		'handleStencil',
		'contentStencil',
		'aptitudeDecoratorBlock',
		'anchoredAptitudeClass'
	],
	#category : #'Brick-Anchored - Look'
}

{ #category : #accessing }
BrWithAnchoredAptitudeWithHandleAndContentStencil class >> stencilProperties [
	^ #(handleStencil contentStencil aptitudeDecoratorBlock anchoredAptitudeClass)
]

{ #category : #accessing }
BrWithAnchoredAptitudeWithHandleAndContentStencil >> anchoredAptitude [
]

{ #category : #accessing }
BrWithAnchoredAptitudeWithHandleAndContentStencil >> anchoredAptitudeClass [
	^ anchoredAptitudeClass
]

{ #category : #accessing }
BrWithAnchoredAptitudeWithHandleAndContentStencil >> anchoredAptitudeClass: anObject [
	anchoredAptitudeClass := anObject
]

{ #category : #accessing }
BrWithAnchoredAptitudeWithHandleAndContentStencil >> aptitudeDecoratorBlock [
	^ aptitudeDecoratorBlock
]

{ #category : #accessing }
BrWithAnchoredAptitudeWithHandleAndContentStencil >> aptitudeDecoratorBlock: anObject [
	aptitudeDecoratorBlock := anObject
]

{ #category : #accessing }
BrWithAnchoredAptitudeWithHandleAndContentStencil >> buildDefault [
	| anAnchoredAptitude aContentElement |

	anAnchoredAptitude := self anchoredAptitudeClass new.

	handleStencil ifNotNil: [ :aHandleStencil |
		| aHandleElement |
		aHandleElement := aHandleStencil
			widget: self widget;
			aptitude: self aptitude;
			asElement.
		anAnchoredAptitude handle: aHandleElement ].
	
	aContentElement := contentStencil
		widget: self widget;
		aptitude: self aptitude;
		asElement.

	anAnchoredAptitude
		content: aContentElement;
		yourself.

	aptitudeDecoratorBlock value: anAnchoredAptitude.

	^ BrAnchoredElement new
		aptitude: anAnchoredAptitude;
		yourself
]

{ #category : #accessing }
BrWithAnchoredAptitudeWithHandleAndContentStencil >> contentStencil [
	^ contentStencil
]

{ #category : #accessing }
BrWithAnchoredAptitudeWithHandleAndContentStencil >> contentStencil: anObject [
	contentStencil := anObject asStencilBuilder: BrWithAnchoredAptitudeStencil
]

{ #category : #accessing }
BrWithAnchoredAptitudeWithHandleAndContentStencil >> handleStencil [
	^ handleStencil
]

{ #category : #accessing }
BrWithAnchoredAptitudeWithHandleAndContentStencil >> handleStencil: anObject [
	handleStencil := anObject asStencilBuilder: BrWithAnchoredAptitudeStencil
]

{ #category : #initialization }
BrWithAnchoredAptitudeWithHandleAndContentStencil >> initialize [
	super initialize.
	
	handleStencil := nil.
	contentStencil := nil.
	aptitudeDecoratorBlock := [ :anAptitude | ]
]
