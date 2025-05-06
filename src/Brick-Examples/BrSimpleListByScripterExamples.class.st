Class {
	#name : #BrSimpleListByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-List'
}

{ #category : #'examples - nested lists' }
BrSimpleListByScripterExamples >> horizontalAndVerticalLists [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithElement: [ BrSimpleListExamples new horizontalAndVerticalNumbers ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check the first item is number zero';
				value: [ :aLabel | aLabel text asString ] equals: '0';
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				onChildAt: 1 ].

	^ aScripter
]

{ #category : #'examples - nested lists' }
BrSimpleListByScripterExamples >> horizontalAndVerticalLists_DownBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self horizontalAndVerticalLists.

	aScripter
		substep: 'Scroll down'
		do: [ :aStep | 
			aStep mouseWheel
				downBy: 5;
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number one';
						value: [ :aLabel | aLabel text asString ] equals: '1';
						onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - nested lists' }
BrSimpleListByScripterExamples >> horizontalAndVerticalLists_LeftBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self horizontalAndVerticalLists_RightBy.

	aScripter
		substep: 'Scroll to the left'
		do: [ :aStep | 
			aStep mouseWheel
				leftBy: 6;
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number zero';
						value: [ :aLabel | aLabel text asString ] equals: '0';
						onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - nested lists' }
BrSimpleListByScripterExamples >> horizontalAndVerticalLists_RightBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self horizontalAndVerticalLists.

	aScripter
		substep: 'Scroll to the right'
		do: [ :aStep | 
			aStep mouseWheel
				rightBy: 6;
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number hundred';
						value: [ :aLabel | aLabel text asString ] equals: '100';
						onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - nested lists' }
BrSimpleListByScripterExamples >> horizontalAndVerticalLists_UpBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self horizontalAndVerticalLists_DownBy.

	aScripter
		substep: 'Scroll up'
		do: [ :aStep | 
			aStep mouseWheel
				upBy: 5;
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number zero';
						value: [ :aLabel | aLabel text asString ] equals: '0';
						onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - horizontal list' }
BrSimpleListByScripterExamples >> horizontalList [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithElement: [ BrSimpleListExamples new horizontalNumbers ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check the first item is number one';
				value: [ :aLabel | aLabel text asString ] equals: '1';
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				onChildAt: 1 ].

	^ aScripter
]

{ #category : #'examples - horizontal list' }
BrSimpleListByScripterExamples >> scrollHorizontallyHorizontalList_LeftBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scrollHorizontallyHorizontalList_RightBy.

	aScripter
		substep: 'Scroll horizontally to the left'
		do: [ :aStep | 
			aStep mouseWheel
				leftBy: 5;
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number one';
						value: [ :aLabel | aLabel text asString ] equals: '1';
						onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - horizontal list' }
BrSimpleListByScripterExamples >> scrollHorizontallyHorizontalList_RightBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self horizontalList.

	aScripter
		substep: 'Scroll horizontally to the right'
		do: [ :aStep | 
			aStep mouseWheel
				rightBy: 5;
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number two';
						value: [ :aLabel | aLabel text asString ] equals: '2';
						onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - vertical list' }
BrSimpleListByScripterExamples >> scrollVerticallyVerticalList_DownBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self verticalList.

	aScripter
		substep: 'Scroll vertically down'
		do: [ :aStep | 
			aStep mouseWheel
				downBy: 5;
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number two';
						value: [ :aLabel | aLabel text asString ] equals: '2';
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - vertical list' }
BrSimpleListByScripterExamples >> scrollVerticallyVerticalList_UpBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scrollVerticallyVerticalList_DownBy.

	aScripter
		substep: 'Scroll vertically up'
		do: [ :aStep | 
			aStep mouseWheel
				upBy: 5;
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number one';
						value: [ :aLabel | aLabel text asString ] equals: '1';
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - nested lists' }
BrSimpleListByScripterExamples >> verticalAndHorizontalLists [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithElement: [ BrSimpleListExamples new verticalAndHorizontalNumbers ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check the first item is number zero';
				value: [ :aLabel | aLabel text asString ] equals: '0';
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				onChildAt: 1 ].

	^ aScripter
]

{ #category : #'examples - nested lists' }
BrSimpleListByScripterExamples >> verticalAndHorizontalLists_DownBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self verticalAndHorizontalLists.

	aScripter
		substep: 'Scroll down'
		do: [ :aStep | 
			aStep mouseWheel
				downBy: 7;
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number hundred';
						value: [ :aLabel | aLabel text asString ] equals: '100';
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - nested lists' }
BrSimpleListByScripterExamples >> verticalAndHorizontalLists_LeftBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self verticalAndHorizontalLists_RightBy.

	aScripter
		substep: 'Scroll to the left'
		do: [ :aStep | 
			aStep mouseWheel
				leftBy: 5;
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number zero';
						value: [ :aLabel | aLabel text asString ] equals: '0';
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - nested lists' }
BrSimpleListByScripterExamples >> verticalAndHorizontalLists_RightBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self verticalAndHorizontalLists.

	aScripter
		substep: 'Scroll to the right'
		do: [ :aStep | 
			aStep mouseWheel
				rightBy: 5;
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number one';
						value: [ :aLabel | aLabel text asString ] equals: '1';
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - nested lists' }
BrSimpleListByScripterExamples >> verticalAndHorizontalLists_UpBy [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self verticalAndHorizontalLists_DownBy.

	aScripter
		substep: 'Scroll up'
		do: [ :aStep | 
			aStep mouseWheel
				upBy: 7;
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
				play.

			aStep wait
				forEmptySpaceTaskQueueTimeout: 1 second;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check the first item is number zero';
						value: [ :aLabel | aLabel text asString ] equals: '0';
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onBreadthFirstChildOfClass: BrHorizontalInfiniteListElement;
						onChildAt: 1 ] ].

	^ aScripter
]

{ #category : #'examples - vertical list' }
BrSimpleListByScripterExamples >> verticalList [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithElement: [ BrSimpleListExamples new verticalNumbers ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check the first item is number one';
				value: [ :aLabel | aLabel text asString ] equals: '1';
				onBreadthFirstChildOfClass: BrInfiniteListElement;
				onChildAt: 1 ].

	^ aScripter
]
