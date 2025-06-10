Class {
	#name : #GtBlocThemeableProperty,
	#superclass : #GtBlocThemeTypedProperty,
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty class >> computePropertyAccessApiFromSourceBlock: aBlockClosure useGlobalTheme: useGlobal [
	| rewriter replacement |
	rewriter := RBParseTreeRewriter new
		replace: '[ :`arg | ``@expr ]'
		with: '``@expr'.

	(rewriter executeTree: aBlockClosure sourceNode)
		ifFalse: [ self error: 'Failed to rewrite' ].

	replacement := useGlobal
		ifTrue: [ 'BlTheme default' ]
		ifFalse: [ 'self theme' ].
		
	^ rewriter tree newSource
		copyReplaceAll: 'aTheme'
		with: replacement
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty class >> computePropertyNameSourceBlock: aBlockClosure [
	| pattern match |
	
	pattern := RBPatternParser parseExpression: '[ :`arg | ``@expr `name ]'.
	match := Dictionary new.
	
	(pattern match: aBlockClosure sourceNode inContext: match)
		ifFalse: [ self error: 'Failed to parse' ].

	^ match at: '`name'
]

{ #category : #generation }
GtBlocThemeableProperty class >> generateSourceComputationFor: aThemeProperty [
	^ '[ :aTheme | aTheme {1} {2} ]' format: {
		aThemeProperty subThemeName.
		aThemeProperty propertyName }
]

{ #category : #generation }
GtBlocThemeableProperty class >> generateValueComputation: sourceCode [
	^ '[ :aTheme | {1} ]' format: { sourceCode trimBoth }
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> createCoderViewModel: aCoderModel coderAssignment: aForCoderAssignment subThemeModel: aSubThemeModel [
	| coderViewModel |
	
	coderViewModel := super
		createCoderViewModel: aCoderModel
		coderAssignment: aForCoderAssignment
		subThemeModel: aSubThemeModel.
	
	(self issuesWithinSubThemeModel: aSubThemeModel)
		ifNotEmpty: [ ^ coderViewModel ].
	
	self
		assert: [ aForCoderAssignment isConstantAssignment ]
		description: [ 'Must be a constant assignment' ].	
	
	aCoderModel 
		when: GtCoderEvaluationAnnouncement
		do: [ :anAnnouncement |
			anAnnouncement evaluationResult isSuccess
				ifTrue: [				
					aSubThemeModel
						changeConstantNamed: aForCoderAssignment propertyName
						to: anAnnouncement evaluationResult value.
					aSubThemeModel notifyThemeModified  ] ].
						
	coderViewModel addShortcut: (GtSourceCoderSaveShortcut new).
	coderViewModel announcer
		when: GtSourceCoderViewModelSaveRequested
		do: [ :anAnnouncement |
			anAnnouncement consumed: true.
			
			 coderViewModel
				handleCoderEvaluationUnhandledErrorDuring: [ 
					coderViewModel coder
						doItInContext: (coderViewModel evaluationContext
							all;
							requesterObject: coderViewModel)
						thenDo: [ :anEvaluationResult |
							aSubThemeModel
								changeConstantNamed: aForCoderAssignment propertyName
								to: anEvaluationResult value.
							
							aForCoderAssignment originalAssignment
								valueAst: (RBParser parseExpression: coderViewModel sourceText asString).
								
							aSubThemeModel generateThemeChanges execute.
							coderViewModel coder forSource: (aForCoderAssignment originalAssignment valueSourceCode).
							
							aSubThemeModel notifyThemeModified ] ].
			 ].
	
	^ coderViewModel
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> extractPropertyConstantAst: aPropertyAssignment [
	^ self subclassResponsibility
]

{ #category : #generation }
GtBlocThemeableProperty >> generateConstantGetter [
	^ 'aTheme {1} constantAt: #{2}' format: {
		self subThemeName.
		self propertyName
	}
]

{ #category : #generation }
GtBlocThemeableProperty >> generateSourceComputation [
	^ self class generateSourceComputationFor: self themeableValue
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> generateThemeableInitializationSource [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> isThemeableType [
	^ true
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> issuesOn: aStream  withinSubThemeModel: aSubThemeModel [
	super issuesOn: aStream  withinSubThemeModel: aSubThemeModel.
	
	self themeProperty hardcodedValueAssignments do: [ :eachAssignment |
		aStream nextPut: (GtBlocThemeablePropertyHardcodedIssue new
			subThemeModel: aSubThemeModel;
			typedThemeableProperty: self;
			valueAssignment: eachAssignment) ].

	self constantAssignments do: [ :eachConstantAssignment |
		(aSubThemeModel subThemeClass inheritsFrom: eachConstantAssignment subThemeClass)
			ifTrue: [ aStream nextPut: (GtBlocThemeConstantAssignedTooHighIssue new
				subThemeModel: aSubThemeModel;
				typedThemeProperty: self;
				constantAssignment: eachConstantAssignment) ] ].
	
	aSubThemeModel subThemeNeighbourClasses
		do: [ :eachSubThemeClass |
			(self themeProperty neighbourConstantAssignments anySatisfy: [ :eachAssignment |
				eachAssignment subThemeClass = eachSubThemeClass ])
					ifFalse: [
						aStream nextPut: (GtBlocThemeConstantNotAssignedIssue new
							subThemeModel: aSubThemeModel;
							subThemeClass: eachSubThemeClass;
							typedThemeProperty: self) ] ].
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> transformAssignmentForCoder: aThemeableAssignment subThemeModel: aSubThemeModel [
	(self issuesWithinSubThemeModel: aSubThemeModel)
		ifNotEmpty: [ ^ aThemeableAssignment ].

	^ self constantAssignments
		detect: [ :eachAssignment |
			eachAssignment subThemeClass = aThemeableAssignment subThemeClass ]
		ifNone: [
			self constantAssignments
				ifEmpty: [ aThemeableAssignment ]
				ifNotEmpty: [ :theAssignments | theAssignments last ] ]
]
