"
I am a text styler strategy used by {{gtClass:BrTextEditor}}.
I style a text in a background process, using {{gtClass:TAsyncFuture}}.

See {{gtClass:BrTextStylerStrategy}} for futher explanation.
"
Class {
	#name : #BrTextStylerAsyncStrategy,
	#superclass : #BrTextStylerStrategy,
	#instVars : [
		'editorStylingFuture'
	],
	#category : #'Brick-Editor-Styler'
}

{ #category : #initialization }
BrTextStylerAsyncStrategy >> initialize [
	super initialize.

	editorStylingFuture := BrAsyncElementFuture new
		cancelSoft;
		executionConfiguration: (AsyncFutureExecutionConfiguration new customGroup: #TextStyler);
		whenSuccess: [ :anEditorElement :aStyledEvent | anEditorElement editor dispatchEvent: aStyledEvent ]
]

{ #category : #styling }
BrTextStylerAsyncStrategy >> styleTextInEditorElement: aBrEditorElement thenDo: aBlock [
	| aTextStylingFuture |
	
	aBrEditorElement editor styler affectsText
		ifFalse: [ ^ self ].

	aTextStylingFuture := [
		| aStyledText |

		aStyledText := self
			doStyleText: aBrEditorElement editor textSnapshot with: aBrEditorElement editor styler
			afterDo: aBlock.

		(BrTextStyledEvent new
				text: aStyledText;
				afterAction: aBlock;
				editorElement: aBrEditorElement) ] asAsyncFuture.

	editorStylingFuture
		element: aBrEditorElement;
		future: aTextStylingFuture
]
