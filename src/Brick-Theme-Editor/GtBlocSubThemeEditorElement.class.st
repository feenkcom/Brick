Class {
	#name : #GtBlocSubThemeEditorElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'subThemeModel',
		'subThemeLabel',
		'addPropertyButton',
		'nameId',
		'editorId',
		'headerId',
		'subTheme'
	],
	#category : #'Brick-Theme-Editor-UI'
}

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> createCollapsedHeaderForProperty: aTypedThemeProperty [
	| header |
	
	header := self createProtoHeaderForProperty: aTypedThemeProperty.
	
	header
		addAptitude: (self createHeaderContextMenuAptitudeForProperty: aTypedThemeProperty).
	
	^ header
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> createEditorForProperty: aTypedThemeProperty assignment: eachValueAssignment [
	| assignmentForCoder container assignmentHeader valueSourceCoderViewModel modificationIndicator valueSourceCoderElement editorContainer |
	
	assignmentForCoder := (aTypedThemeProperty transformAssignmentForCoder: eachValueAssignment subThemeModel: subThemeModel)
		asCoderAssignmentFor: aTypedThemeProperty.
	
	container := BrVerticalPane new
		hMatchParent;
		vFitContent.
		
	assignmentHeader := self
		createEditorHeaderForProperty: aTypedThemeProperty
		assignmentForCoder: assignmentForCoder.
 
	container addChild: assignmentHeader.
	
	editorContainer := BrHorizontalPane new
		hMatchParent;
		vFitContent.
		
	modificationIndicator := self newModificationIndicator.
	modificationIndicator visibility: BlVisibility gone.
	editorContainer addChild: modificationIndicator.
	
	valueSourceCoderViewModel := aTypedThemeProperty
		createCoderViewModel: assignmentForCoder
		subThemeModel: subThemeModel.
		
	valueSourceCoderViewModel selfObject: subTheme.
		
	valueSourceCoderViewModel
		when: GtTextualCoderViewModelTextChanged
		do: [ modificationIndicator asyncPromise promise: valueSourceCoderViewModel isTextModifiedPromise  ].
	
	valueSourceCoderElement := GtSourceCoderEditorElement new
		id: editorId;
		hMatchParent;
		vFitContent;
		padding: (BlInsets top: 2 bottom: 2 left: 4 right: 4);
		textualCoderViewModel: valueSourceCoderViewModel.

	editorContainer addChild: valueSourceCoderElement.
	container addChild: editorContainer.
	
	^ container
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> createEditorHeaderForProperty: aTypedThemeProperty assignmentForCoder: assignmentForCoder [
	| container |
	container := BrHorizontalPane new
			hMatchParent;
			vFitContent.

	container
		addChild: (BrButton new
				fitContent;
				beSmallSize;
				margin: (BlInsets top: 6 left: 3);
				label: assignmentForCoder printSubThemeMethod;
				aptitude: BrGlamorousMetadataLabelAptitude
						+ (BrLazyStyleCommonAptitude new
								hovered: [ :s :t | s border: t button hoveredBorderColor ]);
				action: [ :aButton | 
					assignmentForCoder subThemeMethod
						ifNotNil: [ :aCompiledMethod | aButton phlow spawnTool: (GtMethodCoderTool compiledMethod: aCompiledMethod) ] ]).

	^ container
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> createExpandedHeaderForProperty: aTypedThemeProperty [
	| header |
	header := self createProtoHeaderForProperty: aTypedThemeProperty.
	header
		addChild: (BrFrame new
				hMatchParent;
				vExact: 0).
	header
		addChild: (BrButton new
				beSmallSize;
				aptitude: BrGlamorousMetadataLabelAptitude
						+ (BrLazyStyleCommonAptitude new
								hovered: [ :s :t | s border: t button hoveredBorderColor ]);
				vFitContent;
				label: aTypedThemeProperty printShortThemeableValue;
				action: [ :aButton | aButton phlow spawnObject: aTypedThemeProperty propertyValue ]).

	header
		addAptitude: (self createHeaderContextMenuAptitudeForProperty: aTypedThemeProperty).

	^ header
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> createExpanderExpandedForProperty: aTypedThemeProperty [
	| container issuesContainer assignmentsContainer |
	
	container := BrVerticalPane new
		hMatchParent;
		vFitContent.

	container addChild: (self createExpandedHeaderForProperty: aTypedThemeProperty).
	
	issuesContainer := BrVerticalPane new
		hMatchParent;
		vFitContent;
		margin: (BlInsets left: 3).

	(aTypedThemeProperty issuesWithinSubThemeModel: subThemeModel) do: [ :eachIssue |
		issuesContainer addChild: (self createIssueSummary: eachIssue) ].
		
	container addChild: issuesContainer.

	assignmentsContainer := BrVerticalPane new
		hMatchParent;
		vFitContent.
	
	aTypedThemeProperty valueAssignments
		ifEmpty: [
			assignmentsContainer addChild: (BrLabel new
				aptitude: BrGlamorousSummaryLabelAptitude;
				text: 'Not initialized yet') ].
	
	aTypedThemeProperty valueAssignments do: [ :eachAssignment |
		assignmentsContainer addChild: (self createEditorForProperty: aTypedThemeProperty assignment: eachAssignment) ].

	container addChild: assignmentsContainer.
		
	^ container 
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> createExpanderForProperty: aTypedThemeProperty [
	| anExpander anExpanderBackground |
	
	anExpanderBackground := (aTypedThemeProperty issuesWithinSubThemeModel: subThemeModel)
		ifEmpty: [ self theme default lightBorderColor ]
		ifNotEmpty: [ :theIssues |
			(theIssues anySatisfy: [ :eachIssue | eachIssue isSeriousIssue ])
				ifTrue: [ self theme status errorBorderColor ]
				ifFalse: [ self theme status failureBorderColor ] ].
	
	anExpander := BrExpander new
		hMatchParent;
		vFitContent;
		margin: (BlInsets top: 3 bottom: 3).

	anExpander
		header: [ self createCollapsedHeaderForProperty: aTypedThemeProperty ];
		content: [ self createExpanderExpandedForProperty: aTypedThemeProperty ];
		aptitude: (GtCoderExpanderAptitude new borderPaint: anExpanderBackground).

	^ anExpander
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> createHeaderContextMenuAptitudeForProperty: aTypedThemeProperty [
	^ BrGlamorousWithExplicitContextMenuAptitude
		itemsWithAnchorActions: [ {'Copy `self theme` accessor'
					-> [ Clipboard clipboardText: (aTypedThemeProperty printPropertyAccessor: false) ].
				'Copy `BlTheme default` accessor'
					-> [ Clipboard clipboardText: (aTypedThemeProperty printPropertyAccessor: true) ]} ]
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> createIssueSummary: eachIssue [
	| container |
	
	container := BrHorizontalPane new
		vFitContent;
		hMatchParent.
	
	container addChild: (BrButton new
		aptitude: (BrGlamorousLabelAptitude new foreground: self theme status errorBorderColor);
		label: eachIssue description;
		fitContent;
		action: [ :aButton | aButton phlow spawnObject: eachIssue ]).
	
	eachIssue canFixIt
		ifTrue: [
			container addChild: (BrButton new
				beSmallSize;
				label: 'Fix it';
				icon: BrGlamorousVectorIcons repair ;
				fitContent;
				margin: (BlInsets left: 5);
				aptitude: BrGlamorousButtonWithLabelAndIconAptitude;
				action: [ :aButton | aButton phlow spawnObject: (eachIssue fixItForTheme: subTheme theme) ]) ].
	
	^ container
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> createNewPropertyForm [
	| nameEditor classPicker currentTargetClass valueCoderViewModel acceptShortcut |
	nameEditor := BrEditor new
			aptitude: BrGlamorousRegularEditorAptitude + BrGlamorousEditorSpacingAptitude;
			fitContent;
			constraintsDo: [ :c | c minWidth: 200 ];
			padding: (BlInsets all: 5);
			text: ('' asRopedText
					attribute: (BrGhostTextAttribute
							for: ('name' asRopedText glamorousRegularFontAndSize foreground: Color lightGray)));
			requestFocus.

	currentTargetClass := self subThemeModel subThemeSuperclasses last.

	classPicker := BrButton new
			label: currentTargetClass name;
			icon: BrGlamorousVectorIcons downwards;
			aptitude: BrGlamorousButtonWithLabelAndIconAptitude
					+ (BrGlamorousWithExplicitDropdownAptitude
							handle: [ BrButton new
									label: currentTargetClass name;
									icon: BrGlamorousVectorIcons downwards;
									aptitude: BrGlamorousButtonWithLabelAndIconAptitude - BrGlamorousButtonExteriorAptitude ]
							content: [ BrVerticalPane new
									hFitContent;
									vFitContentLimited;
									addChildren: (self subThemeModel subThemeSuperclasses reversed
											collect: [ :eachSuperclass | 
												BrButton new
													hMatchParent;
													vFitContent;
													alignCenterLeft;
													disabled: currentTargetClass = eachSuperclass;
													model: eachSuperclass;
													padding: (BlInsets
															top: 4
															bottom: 4
															left: 8
															right: 4);
													label: eachSuperclass;
													aptitude: BrGlamorousButtonLabelAptitude + BrGlamorousButtonLayoutAptitude
															+ BrGlamorousListItemAptitude;
													action: [ :aButton | 
														currentTargetClass := eachSuperclass.
														classPicker label: eachSuperclass name.
														aButton fireEvent: BrDropdownHideWish new ] ]) ]).

	valueCoderViewModel := (GtPharoSnippetCoder forSource: 'Color black')
			asCoderViewModel.

	acceptShortcut := BlShortcutWithAction new
			combination: BlKeyCombination enter;
			action: [ :aShortcutEvent | 
				aShortcutEvent consumed: true.
				aShortcutEvent currentTarget fireEvent: BrDropdownHideWish new.

				self subThemeModel
					addThemePropertyNamed: nameEditor text asString
					valueSource: valueCoderViewModel coderModel currentSourceString
					inClass: currentTargetClass ].

	nameEditor addEditorShortcut: acceptShortcut.
	valueCoderViewModel addShortcut: acceptShortcut.
	

	^ BrHorizontalGrid new
		fitContent;
		columnCount: 2;
		padding: (BlInsets all: 6);
		cellSpacing: 2;
		addChildren: {BrLabel new
					beSmallSize;
					constraintsDo: [ :c | c grid vertical alignCenter ];
					aptitude: BrGlamorousLabelAptitude;
					text: 'Property:';
					margin: (BlInsets right: 5).
				BrHorizontalPane new
					fitContent;
					alignCenterLeft;
					addChild: nameEditor;
					addChild: (BrLabel new
							beSmallSize;
							text: 'in:';
							aptitude: BrGlamorousLabelAptitude;
							margin: (BlInsets left: 5 right: 5));
					addChild: classPicker.
				BrLabel new
					beSmallSize;
					constraintsDo: [ :c | c grid vertical alignCenter ];
					aptitude: BrGlamorousLabelAptitude;
					text: 'Value:'.
				GtSourceCoderEditorElement new
					textualCoderViewModel: valueCoderViewModel;
					hMatchParent;
					vFitContent;
					padding: (BlInsets all: 5);
					addAptitude: BrGlamorousEditorSpacingAptitude}
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> createProtoHeaderForProperty: eachProperty [
	| header |
	header := BrHorizontalPane new
			hMatchParent;
			vFitContent;
			id: headerId.

	header
		when: BlClickEvent
		do: [ :anEvent |
			anEvent currentTarget
				allParentsDetect: [ :each | each isKindOf: BrExpander ]
				ifFound: [ :anExpander |
					anEvent consumed: true.
					anExpander toggleExpanded ] 
				ifNone: [ ] ].

	header
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				margin: (BlInsets left: 3);
				text: eachProperty propertyName).

	eachProperty propertyValue isColor
		ifTrue: [ header
				addChild: (BrButton new
						theme: subTheme theme;
						exact: 12 @ 12;
						margin: (BlInsets
								top: 4
								left: 4
								bottom: 0
								right: 4);
						background: eachProperty propertyValue;
						action: [ :aButton | aButton phlow spawnObject: eachProperty themeableValue ]) ].
	^ header
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> initialize [
	super initialize.

	nameId := #'theme-colors--name'.
	editorId := #'theme-colors--coder'.
	headerId := #'theme-editor--value-header'.

	self
		hMatchParent;
		vFitContent;
		padding: (BlInsets all: 3).

	subThemeLabel := BrLabel new
			aptitude: BrGlamorousMetadataLabelAptitude
					+ (BrGlamorousWithExplicitContextMenuAptitude
							itemsWithAnchorActions: [
							{
							'Inspect model'
										-> [ :aLabel | aLabel phlow spawnObject: self subThemeModel ].
							'Inspect changes'
										-> [ :aLabel | aLabel phlow spawnObject: self subThemeModel generateThemeChanges ]} ]).

	addPropertyButton := BrButton new
			beSmallSize;
			margin: (BlInsets left: 5);
			icon: BrGlamorousVectorIcons add;
			aptitude: BrGlamorousButtonWithIconAptitude
					+ (BrGlamorousWithExplicitDropdownAptitude
							handle: [ BrButton new
									beSmallSize;
									icon: BrGlamorousVectorIcons add;
									aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude;
									yourself ]
							content: [ self createNewPropertyForm ]).

	self
		addChild: (BrHorizontalPane new
				vFitContent;
				hMatchParent;
				addChildren: {subThemeLabel.
						addPropertyButton})
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeEditorElement >> newModificationIndicator [
	^ BlElement new
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignLeft.
			c horizontal exact: 3.
			c vertical matchParent ];
		preventMeAndChildrenMouseEvents;
		background: self theme status changesBackgroundColor;
		id: GtTextualCoderModificationIndicatorId;
		withAsyncPromiseDo: [ :anElementPromise |
			anElementPromise
				whenSuccess: [ :anIndicator :isModified |
					anIndicator visibility: (isModified
						ifTrue: [ BlVisibility visible ]
						ifFalse: [ BlVisibility gone ]) ] ]
]

{ #category : #accessing }
GtBlocSubThemeEditorElement >> onPropertyAdded: anAnnouncement [
	| newPropertyExpander |
	
	newPropertyExpander := self createExpanderForProperty: anAnnouncement themeProperty valueType.
	newPropertyExpander expand.
	
	self addChild: newPropertyExpander
]

{ #category : #accessing }
GtBlocSubThemeEditorElement >> subThemeModel [
	^ subThemeModel
]

{ #category : #accessing }
GtBlocSubThemeEditorElement >> subThemeModel: aSubThemeModel [
	subThemeModel := aSubThemeModel.
	subThemeModel announcer weak
		when: GtBlocSubThemePropertyAdded
		send: #onPropertyAdded:
		to: self.
	
	subThemeLabel text: subThemeModel subThemeName.
	
	self
		addChildren: (self subThemeModel themeProperties
				collect: [ :eachThemeProperty | self createExpanderForProperty: eachThemeProperty valueType ]).
]

{ #category : #accessing }
GtBlocSubThemeEditorElement >> subThemeModel: aSubThemeModel subTheme: aSubTheme [
	subTheme := aSubTheme.
	subThemeModel := aSubThemeModel.
	subThemeModel announcer weak
		when: GtBlocSubThemePropertyAdded
		send: #onPropertyAdded:
		to: self.
	
	subThemeLabel text: subThemeModel subThemeName.
	
	self
		addChildren: (self subThemeModel themeProperties
				collect: [ :eachThemeProperty | self createExpanderForProperty: eachThemeProperty valueType ]).
]
