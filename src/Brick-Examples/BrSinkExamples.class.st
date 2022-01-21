Class {
	#name : #BrSinkExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Future'
}

{ #category : #examples }
BrSinkExamples >> countSink [
	<gtExample>
	| stream |

	stream := AsyncImageBehaviorsStream new.
	
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		withAsyncSinkDo: [ :anElementSink |
			anElementSink
				"Specify a receiving Sink for the items from the stream"
				sink: AsyncCounterSink new;
				whenUpdate: [ :aLabel :aCounterSink | aLabel text: aCounterSink count ];
				forwardStream: stream ]
]

{ #category : #examples }
BrSinkExamples >> fanoutSink [
	<gtExample>
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
		addChildren: { labelA . labelB };
		withAsyncSinkDo: [ :anElementSink |
			anElementSink
				sink: (AsyncFanoutSink forSinkA: labelA asyncSink sinkB: labelB asyncSink);
				forwardStream: stream ]
]

{ #category : #examples }
BrSinkExamples >> foldSink [
	<gtExample>
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
BrSinkExamples >> peakSink [
	<gtExample>
	| stream |

	stream := AsyncImageBehaviorsStream new.
	
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		withAsyncSinkDo: [ :anElementSink |
			anElementSink
				sink: AsyncPeakSink new;
				whenUpdate: [ :aLabel :aPeakSink | aPeakSink peak ifSome: [ :aBehavior | aLabel text: aBehavior name ] ];
				forwardStream: stream ]
]
