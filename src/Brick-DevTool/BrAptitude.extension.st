Extension { #name : #BrAptitude }

{ #category : #'*Brick-DevTool' }
BrAptitude class >> allRelatedViewModels [
	"Find all potentially related view models based on requests"
	<return: #Association>

	^ self allRelatedViewModelsAndTheirRequests collect: [ :each | each key ]
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> allRelatedViewModelsAndTheirRequests [
	"Find all potentially related view models based on requests"
	<return: #Association>
	| theRequests | 
	
	theRequests := self withAllSuperclassRequests.

	^ Array streamContents: [ :aStream |
		BrWidgetModel withAllSubclassesDo: [ :aWidgetModelClass |
			| theReferencedRequests |
			
			theReferencedRequests := theRequests select: [ :eachRequestClass | aWidgetModelClass hasSelectorReferringTo: eachRequestClass binding ].
			theReferencedRequests ifNotEmpty: [ aStream nextPut: aWidgetModelClass -> theReferencedRequests ] ] ]
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> gtCoderAptitudeGraphOverviewFor: aView context: aDictionary [
	<gtClassView>
	<gtView>
	^ aView explicit
		priority: 32;
		title: 'Aptitude graph';
		stencil: [ BrDevAptitudeGraphOverview new aptitudeClass: self ]
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> gtCoderAptitudeHierarchyFor: aView context: aDictionary [
	<gtClassView>
	<gtView>
	^ aView tree
		priority: 33;
		title: 'Aptitude hierarchy';
		itemText: [ :anItem |
			anItem rootClass = self
				ifTrue: [ anItem rootClass name asRopedText bold ]
				ifFalse: [ anItem rootClass name ] ];
		items: (GtCoderClassesHierarchyTree fromClasses: self withAllSuperclassAndSubclassAptitudes) sortByClassName subclassTrees;
		children: [ :anItem | anItem subclassTrees ];
		sendTool: [ :anItem | GtClassCoderTool forClass: anItem rootClass ];
		expandAll
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> gtCoderAptitudeOverviewFor: aView context: aDictionary [
	<gtClassView>
	<gtView>
	^ aView explicit
		priority: 31;
		title: 'Aptitude overview';
		stencil: [ BrDevAptitudeOverview new aptitudeClass: self ]
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassAndSubclassAptitudes [
	^ self withAllSuperclassLooks
		addAll: self withAllSubclasses;
		yourself
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassChangeEvents [
	<return: #Set of: #'BrChangeEvent class'>

	^ ((self withAllSuperclassLooks
		flatCollect: [ :eachLookClass | eachLookClass referencedClasses
			select: [ :eachReferencedClass | eachReferencedClass isKindOf: BrChangeEvent class ] ]) as: Set) asArray
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassEventReferences [
	<return: #Association>

	^ self withAllSuperclassLooks
		flatCollect: [ :eachLookClass | eachLookClass referencedClasses
			select: [ :eachReferencedClass |
				(eachReferencedClass isKindOf: BlEvent class)
					and: [ (eachReferencedClass isKindOf: BrRequest class) not
						and: [ (eachReferencedClass isKindOf: BrWish class) not ] ] ]
			thenCollect: [ :eachEventClass |
				BrDevLookRequestReference new
					aptitudeClass: self;
					artifact: eachEventClass;
					methods: (eachLookClass methods select: [ :eachMethod | eachMethod hasLiteral: eachEventClass binding ]) ] ]
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassEvents [
	<return: #Set of: #'BlEvent class'>

	^ (self withAllSuperclassEventsAndTheirMethods collect: [ :each | each key ] as: Set) asArray
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassEventsAndTheirMethods [
	<return: #Association>

	^ self withAllSuperclassLooks
		flatCollect: [ :eachLookClass | eachLookClass referencedClasses
			select: [ :eachReferencedClass |
				(eachReferencedClass isKindOf: BlEvent class)
					and: [ (eachReferencedClass isKindOf: BrRequest class) not
						and: [ (eachReferencedClass isKindOf: BrWish class) not ] ] ]
			thenCollect: [ :eachWishClass | eachWishClass -> (eachLookClass methods select: [ :eachMethod | eachMethod hasLiteral: eachWishClass binding ]) ] ]
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassLooks [
	| theLooks |
	
	theLooks := OrderedCollection with: self.
	
	self = BrAptitude
		ifTrue: [ ^ theLooks ].

	theLooks
		addAll: (self allSuperclassesIncluding: BrAptitude);
		yourself.
		
	^ theLooks
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassRequestReferences [
	<return: #Collection of: #BrDevLookRequestReference>

	^ self withAllSuperclassLooks
		flatCollect: [ :eachLookClass | eachLookClass referencedClasses
			select: [ :eachReferencedClass | eachReferencedClass isKindOf: BrRequest class ]
			thenCollect: [ :eachRequestClass |
				BrDevLookRequestReference new
					aptitudeClass: self;
					artifact: eachRequestClass;
					methods: (eachLookClass methods select: [ :eachMethod | eachMethod hasLiteral: eachRequestClass binding ]) ] ]
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassRequests [
	<return: #Set of: #'BrRequest class'>

	^ (self withAllSuperclassRequestsAndTheirLooks collect: [ :each | each key ] as: Set) asArray
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassRequestsAndTheirLooks [
	<return: #Association>

	^ self withAllSuperclassLooks
		flatCollect: [ :eachLookClass | eachLookClass referencedClasses
			select: [ :eachReferencedClass | eachReferencedClass isKindOf: BrRequest class ]
			thenCollect: [ :eachRequestClass | eachRequestClass -> eachLookClass ] ]
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassRequestsAndTheirMethods [
	<return: #Association>

	^ self withAllSuperclassLooks
		flatCollect: [ :eachLookClass | eachLookClass referencedClasses
			select: [ :eachReferencedClass | eachReferencedClass isKindOf: BrRequest class ]
			thenCollect: [ :eachWishClass | eachWishClass -> (eachLookClass methods select: [ :eachMethod | eachMethod hasLiteral: eachWishClass binding ]) ] ]
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassWishReferences [
	<return: #Collection of: #BrDevLookWishReference>

	^ self withAllSuperclassLooks
		flatCollect: [ :eachLookClass | eachLookClass referencedClasses
			select: [ :eachReferencedClass | eachReferencedClass isKindOf: BrWish class ]
			thenCollect: [ :eachWishClass |
				BrDevLookWishReference new
					aptitudeClass: self;
					artifact: eachWishClass;
					methods: (eachLookClass methods select: [ :eachMethod | eachMethod hasLiteral: eachWishClass binding ]) ] ]
]

{ #category : #'*Brick-DevTool' }
BrAptitude class >> withAllSuperclassWishes [
	<return: #Set of: #'BrWish class'>

	^ (self withAllSuperclassWishReferences collect: [ :each | each artifact ] as: Set) asArray
]
