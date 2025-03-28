Class {
	#name : #BrSlideImageExport,
	#superclass : #BrFileSelectOrCreate,
	#instVars : [
		'formatInputField',
		'heightInputField',
		'widthInputField',
		'exportOptionsCollection',
		'formatOptionsCollection',
		'rangeInputField'
	],
	#category : #'Brick-File - UI'
}

{ #category : #accessing }
BrSlideImageExport >> buildUI [
	| alignedButton fileInputFieldContainer formatSection resolutionSection rangeSection imageDetailsContainer |
	formatOptionsCollection := {'JPEG'.
			'PNG'} asOrderedCollection.
	exportOptionsCollection := {'All'.
			'Current Slide'.
			'Range'} asOrderedCollection.

	breadcrumb := self createBreadcrumb.
	table := self createTable.
	table
		when: BrSelectionChanged
		do: [ :anEvent | 
			anEvent indices
				ifNotEmpty: [ :theIndices | 
					| aWidgetElement selectedObject |
					aWidgetElement := anEvent currentTarget.
					selectedObject := aWidgetElement viewModel itemAt: theIndices first.
					fileInputField text: selectedObject basename ] ].
	fileInputFieldContainer := self createFileInputField.

	formatSection := self createFormatInputSection.
	resolutionSection := self createResolutionSection.
	rangeSection := self createRangeSection.
	imageDetailsContainer := BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal matchParent ];
			margin: (BlInsets
					top: 20
					right: 5
					bottom: 5
					left: 0);
			addChildren: {formatSection.
					resolutionSection.
					rangeSection}.

	alignedButton := self createOkButton.
	self
		addChildren: {BrScrollPane new
					aptitude: BrScrollPaneAptitude;
					hMatchParent;
					vFitContent;
					content: breadcrumb;
					when: BlElementLayoutComputedEvent
						doOnce: [ :anEvent | anEvent currentTarget scrollBy: Float infinity negated @ 0 ]
				table.
				fileInputFieldContainer.
				imageDetailsContainer.
				alignedButton}
]

{ #category : #accessing }
BrSlideImageExport >> createDropdownButtonWithLabel: aString [
	^ BrButton new
		aptitude:
			BrTextLabelAptitude new glamorousRegularFont glamorousCodeSmallSize
				+ BrGlamorousButtonIconAptitude + BrGlamorousButtonLayoutAptitude;
		vExact: 25;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		padding: (BlInsets left: 4 right: 2);
		label: aString;
		icon: BrGlamorousVectorIcons downwards;
		beSmallSize.
]

{ #category : #accessing }
BrSlideImageExport >> createDropdownFieldFor: aCollection [
	| button dropDownLook |
	button := self
		createDropdownButtonWithLabel: aCollection first asString.
	dropDownLook := BrGlamorousWithExplicitDropdownAptitude
		handle: [ self createDropdownButtonWithLabel: aCollection first asString ]
		content: [ BrSimpleList new
				items: aCollection;
				fitContent;
				stencil: [ :each | 
					BrHorizontalPane new
						hMatchParent;
						vFitContent;
						addAptitude:
							(BrStyleCommonAptitude new
								hovered:
									[ :aStyle | aStyle background: self theme button defaultBorderColor ]);
						padding:
							(BlInsets
								top: 0
								right: 5
								bottom: 5
								left: 5);
						addChild:
							(BrLabel new
								aptitude:
									BrGlamorousLabelAptitude new glamorousRegularFont
										glamorousCodeSmallSize;
								text: each);
						when: BlClickEvent
							do: [ :anEvent | 
							button label: each.
							anEvent currentTarget fireEvent: BrDropdownHideWish new ] ] ].
	button addAptitude: dropDownLook.
	button
		addAptitude:
			(BrStyleCommonAptitude new
				default:
						[ :aStyle | aStyle background: self theme status neutralBackgroundColor ];
				hovered: [ :aStyle | 
					aStyle background:
						self theme status neutralBackgroundColor darker ]).
	^ button
]

{ #category : #accessing }
BrSlideImageExport >> createEditableField [
	^ BrEditableLabel new
		aptitude: BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize;
		margin: (BlInsets top: 0 right: 5 bottom: 3 left: 0);
		text: ''.
]

{ #category : #accessing }
BrSlideImageExport >> createFormatInputSection [
	| formatLabel |
	formatLabel := self createLabelWithText: 'Format: '.
	formatInputField := self createEditableField
		text: 'JPEG'.
	"formatInputField := self createDropdownFieldFor: formatOptionsCollection."
	
	^ BlElement new
		layout: BlLinearLayout horizontal;
		"padding: (BlInsets top: 10);"
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent];
		addChildren: {formatLabel. formatInputField}.
]

{ #category : #accessing }
BrSlideImageExport >> createLabelWithText: aString [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
		text: (aString asRopedText glamorousRegularFont);
		margin: (BlInsets top: 3 right: 5 bottom: 0 left: 0);
		fitContent.
]

{ #category : #accessing }
BrSlideImageExport >> createRangeSection [
	| rangeLabel |
	rangeLabel := self createLabelWithText: 'Export: '.
	"rangeInputField := self createDropdownFieldFor: exportOptionsCollection."
	rangeInputField := self createEditableField text: 'All' asString.
	
	^ BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent];
		margin: (BlInsets left: 20);
		addChildren: {rangeLabel. rangeInputField}.
]

{ #category : #accessing }
BrSlideImageExport >> createResolutionSection [
	| resolutionLabel separatorLabel |
	resolutionLabel := self createLabelWithText: 'Resolution: '.
	separatorLabel := self createLabelWithText: 'x'.
	heightInputField := self createEditableField
		text: '1080'.
	widthInputField := self createEditableField
		text: '1920'.
	
	^ BlElement new
		layout: BlLinearLayout horizontal;
		margin: (BlInsets left: 20);
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent];
		addChildren: {resolutionLabel. widthInputField. separatorLabel. heightInputField}.
]

{ #category : #accessing }
BrSlideImageExport >> executeAction [ 
	"Execute the receiver's load action"
	| fileName |
	fileName := fileInputField text asString.
	self updateDisplay.
	fileInputField text:''.
	self okAction 
		cull: folder
		cull: fileName.
]

{ #category : #accessing }
BrSlideImageExport >> exportRange [
	^ rangeInputField text asString ifEmpty: [ ^ 'All' asString ].
]

{ #category : #accessing }
BrSlideImageExport >> imageFormat [
	^ formatInputField text asString ifEmpty: [ ^ 'JPEG' asString ].
]

{ #category : #accessing }
BrSlideImageExport >> imageHeight [
	^ heightInputField text asString ifEmpty: [ ^ '1080' asString ].
]

{ #category : #accessing }
BrSlideImageExport >> imageWidth [
	^ widthInputField text asString ifEmpty: [ ^ '1920' asString ]. 
]
