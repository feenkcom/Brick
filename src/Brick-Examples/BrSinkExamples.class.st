Class {
	#name : #BrSinkExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Future'
}

{ #category : #examples }
BrSinkExamples >> countSink [
	<gtExample>
	<return: #BrLabel>
	| stream |
	stream := AsyncImageBehaviorsStream new.

	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncCounterSink new;
				whenUpdate: [ :aLabel :aCounterSink | aLabel text: aCounterSink count ];
				forwardStream: stream	"Specify a receiving Sink for the items from the stream" ]
]

{ #category : #examples }
BrSinkExamples >> fanoutSink [
	<gtExample>
	<return: #BrVerticalPane>
	| stream labelA labelB |
	stream := AsyncImageBehaviorsStream new collect: [ :each | each linesOfCode ].

	labelA := BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			withAsyncSinkDo: [ :anElementSink | 
				anElementSink
					sink: (AsyncFoldSink inject: 0 into: [ :sum :each | sum + each ]);
					whenUpdate: [ :aLabel :aSink | aLabel text: aSink value ] ].

	labelB := BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			withAsyncSinkDo: [ :anElementSink | 
				anElementSink
					sink: (AsyncFoldSink inject: 0 into: [ :max :each | max max: each ]);
					whenUpdate: [ :aLabel :aSink | aLabel text: aSink value ] ].

	^ BrVerticalPane new
		fitContent;
		addChildren: {labelA.
				labelB};
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: (AsyncFanoutSink forSinkA: labelA asyncSink sinkB: labelB asyncSink);
				forwardStream: stream ]
]

{ #category : #examples }
BrSinkExamples >> foldSink [
	<gtExample>
	<return: #BrLabel>
	| stream |
	stream := AsyncImageBehaviorsStream new collect: [ :each | each linesOfCode ].

	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: (AsyncFoldSink inject: 0 into: [ :sum :each | sum + each ]);
				whenUpdate: [ :aLabel :aSink | aLabel text: aSink value ];
				forwardStream: stream ]
]

{ #category : #examples }
BrSinkExamples >> peekSink [
	<gtExample>
	<return: #BrLabel>
	| stream |
	stream := AsyncImageBehaviorsStream new.

	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :aLabel :aPeakSink | aPeakSink peek ifSome: [ :aBehavior | aLabel text: aBehavior name ] ];
				forwardStream: stream ]
]
