Extension { #name : #BrTextStylerAsyncStrategySignal }

{ #category : #'*Brick-Editor-Extensions' }
BrTextStylerAsyncStrategySignal >> gtTextAttributeTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Editor text attributes';
		tooltip: 'Editor text attributes at the time of signal';
		priority: 0.5;
		object: [ self text ];
		view: #gtAttributeTreeFor:
]

{ #category : #'*Brick-Editor-Extensions' }
BrTextStylerAsyncStrategySignal >> gtTextFor: aView [
	<gtView>
	^ aView text
		title: 'Editor text';
		tooltip: 'Editor text at the time of signal';
		priority: 0.4;
		text: [ self text ]
]
