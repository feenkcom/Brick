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
		| anUnstyledText aStyler aStyledText |
		
		anUnstyledText := aBrEditorElement editor textSnapshot.
		aStyler := aBrEditorElement editor styler.
		
		BrTextStylerAsyncStylingStarted new
			element: aBrEditorElement;
			future: aTextStylingFuture;
			unstyledText: anUnstyledText;
			styler: aStyler;
			emit.

		aStyledText := self
			doStyleText: anUnstyledText with: aStyler
			afterDo: aBlock.
			
		BrTextStylerAsyncStylingFinished new
			element: aBrEditorElement;
			future: aTextStylingFuture;
			styledText: aStyledText copy;
			styler: aStyler;
			emit.

		(BrTextStyledEvent new
			text: aStyledText;
			afterAction: aBlock;
			editorElement: aBrEditorElement) ] asAsyncFuture.

	BrTextStylerAsyncStylingSubmitted new
		editorStylingFuture: editorStylingFuture;
		element: aBrEditorElement;
		future: aTextStylingFuture;
		emit.
				
	editorStylingFuture
		element: aBrEditorElement;
		future: aTextStylingFuture
]
