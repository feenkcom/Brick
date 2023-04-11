Class {
	#name : #BrPagerExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Pager'
}

{ #category : #example }
BrPagerExamples >> closePageWithPendingFuture [
	<gtExample>
	| scripter firstPage future futureStarted futureScheduled futureResult |

	scripter := BlScripter new element: self example.
	
	futureResult := nil.
	futureStarted := false.
	futureScheduled := false.

	future := [ futureStarted := true. 5 seconds wait. true ] asAsyncFuture.
	firstPage := scripter element query // (#page asBlocElementId indexed: 1); anyOne.
	
	firstPage withAsyncFutureDo: [ :anElementFuture |
		anElementFuture
			shouldFireScheduledEvent: true;
			whenSuccess: [ :anElement :aFutureResult | futureResult := aFutureResult ];
			whenPending: [ :anElement :anInitialValue | futureResult := anInitialValue ];
			whenError: [ :anElement :anError | futureResult := anError ] ].

	firstPage when: BrAsyncElementFutureScheduledEvent do: [ futureScheduled := true ].
	
	scripter do
		action: [ firstPage asyncFuture future: future ];
		playNoPulse.

	[ 20 milliSeconds wait. futureStarted and: [ futureScheduled ] ]
		whileFalse: [ scripter pulse ].

	self assert: firstPage viewModel pendingFuturePromises size equals: 1.

	scripter do
		action: [ :anElement | anElement removePageAt: 1 ];
		play.

	self assert: firstPage viewModel pendingFuturePromises size equals: 0.
	
	"because an element was removed from the scene graph, an update is not sceduled, therefore
	whenError: block is not executed, it is expected and actually quite nice"
	self assert: futureResult isNil.

	^ scripter
]

{ #category : #example }
BrPagerExamples >> example [
	<gtExample>
	| pager |

	pager := BrPager new.
	pager constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	pager addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		id: (#page asBlocElementId indexed: 1);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color gray).

	pager addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		id: (#page asBlocElementId indexed: 1);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color lightGray).

	pager addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		id: (#page asBlocElementId indexed: 1);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color veryLightGray).
		
	self assert: pager pages size equals: 3.

	^ pager
]
