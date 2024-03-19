Extension { #name : #BrDateAndTimeSinceNowPrinter }

{ #category : #'*Brick-Examples' }
BrDateAndTimeSinceNowPrinter classSide >> gtDemoFor: aView [
	<gtClassView>
	^ aView forward
		title: 'Demo';
		priority: 60;
		object: [ BrDateAndTimeSinceNowPrinterExamples new ];
		view: #gtDemoFor:
]
