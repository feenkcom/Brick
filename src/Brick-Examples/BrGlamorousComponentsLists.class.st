"
# List
Use lists to display large datasets.
## Simple
#### List of all classes
{{gtExample:BrGlamorousComponentsLists>>#listOfClasses|previewShow=#gtLiveFor:|previewHeight=250|previewExpanded=true|codeExpanded=false}}
#### List of colors
{{gtExample:BrGlamorousComponentsLists>>#listOfColors|previewShow=#gtLiveFor:|previewHeight=250|previewExpanded=true|codeExpanded=false}}
## Columned
#### Columned list of colors
{{gtExample:BrGlamorousComponentsLists>>#columnedListOfColors|previewShow=#gtLiveFor:|previewHeight=250|previewExpanded=true|codeExpanded=false}}

"
Class {
	#name : #BrGlamorousComponentsLists,
	#superclass : #BrGlamorousComponents,
	#category : #'Brick-Examples-! Glamorous components'
}

{ #category : #examples }
BrGlamorousComponentsLists >> columnedListOfColors [
	<gtExample>
	<return: #BrColumnedList>
	| aList |
	aList := BrColumnedList new.
	aList column
		width: 50;
		title: 'Index';
		cellStencil: [ BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				padding: (BlInsets all: 12) ];
		dataBinder: [ :eachElement :eachColor :eachIndex | eachElement text: eachIndex asString ].
	aList column
		matchParent;
		title: 'Color';
		cellStencil: [ BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				padding: (BlInsets all: 12) ];
		dataBinder: [ :eachElement :eachColor :eachIndex | 
			eachElement
				text: (('#' , eachColor asHexString) asRopedText
						foreground: eachColor contrastingBlackAndWhiteColor);
				background: eachColor ].
	aList items: Color indexedColors.
	^ aList
]

{ #category : #examples }
BrGlamorousComponentsLists >> listOfClasses [
	<gtExample>
	<return: #BrSimpleList>
	^ BrSimpleList new
		itemStencil: [ BrLabel new
				hMatchParent;
				aptitude: BrGlamorousLabelAptitude new;
				padding: (BlInsets all: 5) ];
		itemDataBinder: [ :eachElement :eachClass :eachIndex | eachElement text: eachClass name ];
		items: (SystemNavigation new allClasses sorted: [ :a :b | a name < b name ])
]

{ #category : #examples }
BrGlamorousComponentsLists >> listOfColors [
	<gtExample>
	<return: #BrSimpleList>
	^ BrSimpleList new
		itemStencil: [ BrLabel new
				hMatchParent;
				aptitude: BrGlamorousLabelAptitude new;
				padding: (BlInsets all: 12) ];
		itemDataBinder: [ :eachElement :eachColor :eachIndex | 
			eachElement
				text: (eachColor asRopedText foreground: eachColor contrastingBlackAndWhiteColor);
				background: eachColor ];
		items: Color indexedColors
]
