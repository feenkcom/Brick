Class {
	#name : 'BrFromFutureExamples',
	#superclass : 'Object',
	#category : 'Brick-Examples-Future'
}

{ #category : 'examples' }
BrFromFutureExamples >> fromFutureLabel [
	<gtExample>
	
	^ BrFromFuture new
		fitContent;
		future: [ 0.5 seconds wait . 'Alice' ]
			initialValue: 'placeholder';
		stencil: [ BrLabel new
			aptitude: BrGlamorousLabelAptitude ];
		dataBinder: [ :aLabel :aDataSnapshot |
			aDataSnapshot
				ifSuccess: [ :aName | aLabel text: aName ]
				ifError: [ :anError | aLabel text: (anError description asRopedText foreground: Color red) ]
				ifPending: [ :anInitialValue | aLabel text: anInitialValue ] ]
]

{ #category : 'examples' }
BrFromFutureExamples >> fromFutureLabelWithError [
	<gtExample>
	
	^ BrFromFuture new
		fitContent;
		future: [ 0.5 seconds wait . 1/0 ]
			initialValue: 'placeholder';
		stencil: [ BrLabel new
			aptitude: BrGlamorousLabelAptitude ];
		dataBinder: [ :aLabel :aDataSnapshot |
			aDataSnapshot
				ifSuccess: [ :aName | aLabel text: aName ]
				ifError: [ :anError | aLabel text: (anError description asRopedText foreground: Color red) ]
				ifPending: [ :anInitialValue | aLabel text: anInitialValue ] ]
]
