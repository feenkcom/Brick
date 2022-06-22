"
I am an abstract text styler strategy used by ${class:BrTextEditor}$.
My concrete subclass strategies should style text in a background process.
The common styling logic, that should be executed in the background process is implemented in ${method:BrTextStylerCommonAsyncStrategy>>#doStyle:afterDo:}$ and should be called from concete 
The subclasses should implement ${method:BrTextStylerStrategy>>#style:afterDo:}$ implementations.

See ${class:BrTextStylerStrategy}$ for futher explanation.

See my subclasses for concrete async strategies: ${class:BrTextStylerCommonAsyncStrategy|expanded=true|show=gtSubclassesFor:}$

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
