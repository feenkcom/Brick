Class {
	#name : #BrGroupedListExamples,
	#superclass : #Object,
	#category : #'Brick-Examples'
}

{ #category : #accessing }
BrGroupedListExamples >> basic [
	<gtExample>
	<return: #BrGroupedList>
	| items even odd groups |
	items := 1 to: 20.
	even := items asAsyncStream select: #even.
	odd := items asAsyncStream select: #odd.
	groups := {even -> 'Even'.
			odd -> 'Odd'} asAsyncStream
			collect: [ :each | 
				BrGroup new
					stream: each key;
					domainObject: each value;
					itemStencil: [ BrLabel new
							hMatchParent;
							aptitude: BrGlamorousLabelAptitude + BrGlamorousListItemAptitude ];
					itemDataBinder: [ :aLabel :eachItem | aLabel text: eachItem asString ];
					shouldShowWithoutItems: true ].
	^ BrGroupedList new
		headerElementStencil: [ BrLabel new
				margin: (BlInsets top: 10);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ];
		headerDataBinder: [ :aLabel :eachItem | aLabel text: eachItem domainObject ];
		stream: groups
]

{ #category : #accessing }
BrGroupedListExamples >> multiSelection [
	<gtExample>
	<return: #BrGroupedList>
	| items even odd groups |
	items := 1 to: 20.
	even := items asAsyncStream select: #even.
	odd := items asAsyncStream select: #odd.
	groups := {even -> 'Even'.
			odd -> 'Odd'} asAsyncStream
			collect: [ :each | 
				BrGroup new
					stream: each key;
					domainObject: each value;
					itemStencil: [ BrLabel new
							hMatchParent;
							aptitude: BrGlamorousLabelAptitude + BrGlamorousListItemAptitude ];
					itemDataBinder: [ :aLabel :eachItem | aLabel text: eachItem asString ];
					shouldShowWithoutItems: true ].
	^ BrGroupedList multiSelection
		headerElementStencil: [ BrLabel new
				margin: (BlInsets top: 10);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ];
		headerDataBinder: [ :aLabel :eachItem | aLabel text: eachItem domainObject ];
		stream: groups
]
