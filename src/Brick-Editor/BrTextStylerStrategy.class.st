"
I am an abstract text styler strategy used by {{gtClass:BrTextEditor}}.
My subclasses are responsible for the text style request executions.
For example, one strategy could perform styling in a background process, another in a UI process (and therefore being blocking).

The common method is {{gtMethod:BrTextStylerStrategy>>#styleTextInEditorElement:thenDo:}}.

See my subclasses for concrete strategies: {{gtClass:BrTextStylerStrategy|expanded=true|show=gtSubclassesFor:}}


"
Class {
	#name : #BrTextStylerStrategy,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Brick-Editor-Styler'
}

{ #category : #testing }
BrTextStylerStrategy class >> isAbstract [
	^ self name = #BrTextStylerStrategy 
]

{ #category : #private }
BrTextStylerStrategy >> doStyleText: aBlText with: aStyler afterDo: aBlock [
	"Synchronously style a given text with provided styler and evaluate a Block with the styled text
	once completed. Return styled text"
	| aStyledText |

	aStyledText := aStyler style: aBlText nextGeneration.
	aBlock value: aStyledText.
	^ aStyledText
]

{ #category : #styling }
BrTextStylerStrategy >> styleTextInEditorElement: aBrEditorElement thenDo: aBlock [
	self subclassResponsibility
]
