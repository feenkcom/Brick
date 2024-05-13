Extension { #name : #BrTextStylerAsyncStylingStarted }

{ #category : #'*Brick-Editor-Extensions' }
BrTextStylerAsyncStylingStarted >> gtUnstyledTextFor: aView [
	<gtView>
	^ aView text
		title: 'Unstyled text';
		priority: 0;
		text: [ self unstyledText ]
]
