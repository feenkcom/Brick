Class {
	#name : #GtBlocSubThemeModel,
	#superclass : #Object,
	#instVars : [
		'subTheme',
		'subThemeClass',
		'subThemeName',
		'themeProperties',
		'announcer'
	],
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel class >> allLeafNeighbourSubThemeClasses: aSubThemeClass [
	| allSuperclasses topSubThemeClass |
	
	allSuperclasses := self subThemeSuperclasses: aSubThemeClass.
	topSubThemeClass := allSuperclasses last.
	
	^ topSubThemeClass allSubclasses
		reject: [ :eachSubThemeClass | eachSubThemeClass hasSubclasses or: [ eachSubThemeClass = aSubThemeClass ] ].
]

{ #category : #'private - initialization' }
GtBlocSubThemeModel class >> detectAllConstantAssignmentsIn: aSubThemeClass [
	<return: #OrderedDictionary>
	| assignments currentClass |
	
	assignments := OrderedCollection new.
	
	currentClass := aSubThemeClass.
	[ currentClass = BlSubTheme ] whileFalse: [
		assignments addAll: (self detectConstantAssignmentsIn: currentClass).
		currentClass := currentClass superclass ].
	
	^ assignments groupedBy: [ :each | each valueName ]
]

{ #category : #'private - initialization' }
GtBlocSubThemeModel class >> detectAllNeighbourConstantAssignmentsIn: aSubThemeClass [
	<return: #OrderedDictionary>
	| assignments allSuperclasses topSubThemeClass allLeafSubThemes  |
	
	assignments := OrderedCollection new.
	
	allSuperclasses := self subThemeSuperclasses: aSubThemeClass.
	topSubThemeClass := allSuperclasses last.
	
	allSuperclasses := allSuperclasses asSet.
	allLeafSubThemes := topSubThemeClass allSubclasses
		reject: [ :eachSubThemeClass | eachSubThemeClass hasSubclasses ].
		
	allLeafSubThemes do: [ :eachLeafSubTheme |
		| currentClass |
		currentClass := eachLeafSubTheme.
		[ currentClass = BlSubTheme ] whileFalse: [
			(allSuperclasses includes: currentClass)
				ifFalse: [
					(self detectConstantAssignmentsIn: currentClass)
						do: [ :eachAssignment |
							(assignments includes: eachAssignment)
								ifFalse: [ assignments add: eachAssignment ] ] ].
			currentClass := currentClass superclass ] ].
	
	^ assignments groupedBy: [ :each | each valueName ]
]

{ #category : #'private - initialization' }
GtBlocSubThemeModel class >> detectConstantAssignmentsIn: aSubThemeClass [
	| assignments selectors |
	
	assignments := OrderedCollection new.
	
	selectors := #(initializeConstants).
	
	selectors do: [ :eachSelector |
		aSubThemeClass
			compiledMethodAt: eachSelector
			ifPresent: [ :initializeMethod |
				| ast |
				ast := RBParser parseMethod: initializeMethod sourceCode.
				ast nodesDo: [ :each |
					(each isMessage and: [ each selector = #constantAt:put: ])
						ifTrue: [
							assignments add: (GtBlocThemeConstantAssignment new
								subThemeClass: aSubThemeClass;
								subThemeSelector: eachSelector;
								valueName: each arguments first value;
								valueAst: each arguments second) ] ] ] ].
	
	^ assignments
]

{ #category : #generation }
GtBlocSubThemeModel class >> generateInitializeColorsSourceCode: theThemeableValues for: aSubThemeClass [
	^ String streamContents: [ :s |
		s nextPutAll: 'initializeColors'; cr.
		s tab nextPutAll: 'super initializeColors.'; cr; cr.
	
		theThemeableValues do: [ :eachValue |		
			eachValue valueAssignments
				select: [ :eachAssignment | eachAssignment subThemeClass = aSubThemeClass and: [ eachAssignment subThemeSelector = #initializeColors ] ]
				thenDo: [ :eachAssignment |
					s tab nextPutAll: eachValue propertyName; nextPutAll: ' := '.
					s nextPutAll: eachAssignment valueSourceCode; nextPutAll: '.'; cr; cr ] ] ]
]

{ #category : #generation }
GtBlocSubThemeModel class >> generateInitializeConstantsSourceCode: collectionOfAssignments for: aSubThemeClass [
	^ String streamContents: [ :s |
		s nextPutAll: 'initializeConstants'; cr.
		s tab nextPutAll: 'super initializeConstants.'; cr; cr.
		
		collectionOfAssignments
			select: [ :eachAssignment | eachAssignment subThemeClass = aSubThemeClass and: [ eachAssignment subThemeSelector = #initializeConstants ] ]
			thenDo: [ :eachAssignment |
				s tab.
				s nextPutAll: ('self constantAt: #{1} put: ({2}).' format: {
					eachAssignment valueName.
					eachAssignment valueSourceCode
				}).
				s cr ] ]
]

{ #category : #generation }
GtBlocSubThemeModel class >> generateInitializeNeighbourConstantsSourceCode: theThemeProperties [
	| assignmentsPerClass |

	assignmentsPerClass := (theThemeProperties flatCollect: [ :each | each neighbourConstantAssignments ])
		groupedBy: [ :eachAssignment | eachAssignment subThemeClass ].
	
	
	^ (assignmentsPerClass associations collect: [ :eachAssociation |
		eachAssociation key -> (self
			generateInitializeConstantsSourceCode: eachAssociation value
			for: eachAssociation key) ]) asOrderedDictionary
]

{ #category : #generation }
GtBlocSubThemeModel class >> generateInitializeThemeableSourceCode: theThemeableValues for: aSubThemeClass [
	^ String streamContents: [ :s |
		s nextPutAll: 'initializeThemeable'; cr.
		s tab nextPutAll: 'super initializeThemeable.'; cr; cr.
	
		theThemeableValues do: [ :eachValue |
			eachValue valueAssignments
				select: [ :eachAssignment | eachAssignment subThemeClass = aSubThemeClass and: [ eachAssignment subThemeSelector = #initializeThemeable ] ]
				thenDo: [ :eachAssignment |
					s tab nextPutAll: eachValue propertyName; nextPutAll: ' := '.
					s nextPutAll: eachAssignment valueSourceCode; nextPutAll: '.'; cr; cr ] ] ]
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel class >> subThemeSuperclasses: aSubThemeClass [
	^ Array streamContents: [ :s | self subThemeSuperclasses: aSubThemeClass do: [ :eachClass | s nextPut: eachClass ] ]
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel class >> subThemeSuperclasses: aSubThemeClass do: aBlock [
	| currentClass|
	
	currentClass := aSubThemeClass.
	[ currentClass = BlSubTheme or: [ currentClass isNil ] ]
		whileFalse: [
			aBlock value: currentClass.
			currentClass := currentClass superclass ]
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> addThemePropertyNamed: aPropertyName valueSource: newConstantValueSource inClass: aSubThemeClass [
	| newConstantValue newPropertyClass newPropertyValueBlockSource newPropertySourceBlockSource newPropertySourceCode newPropertyAssignment newContantAssignment aNewProperty newPropertyGetter newPropertyGetterSourceCode |
	self
		assert: [ (themeProperties anySatisfy: [ :each | each propertyName = aPropertyName ])
				not ]
		description: [ 'Property `{1}` must not already exist' format: {aPropertyName} ].

	newConstantValue := self class evaluate: newConstantValueSource.
	newPropertyClass := GtBlocThemeableColorProperty.

	newContantAssignment := GtBlocThemeConstantAssignment new
			subThemeClass: self subThemeClass;
			subThemeSelector: #initializeConstants;
			valueName: aPropertyName;
			valueAst: (RBParser parseExpression: newConstantValueSource);
			yourself.
	newPropertyValueBlockSource := self
			generatePropertyValueBlockSourceCode: aPropertyName
			propertyTypeClass: newPropertyClass.
	newPropertySourceBlockSource := self
			generatePropertySourceBlockSourceCode: aPropertyName.

	newPropertySourceCode := newPropertyClass
			generatePropertySourceCode: newPropertyValueBlockSource
			source: newPropertySourceBlockSource.

	newPropertyGetterSourceCode := self
			generatePropertyGetterSourceCode: aPropertyName.

	newPropertyAssignment := GtBlocThemeValueAssignment new
			subThemeClass: aSubThemeClass;
			subThemeSelector: #initializeThemeable;
			valueName: aPropertyName;
			valueAst: (RBParser parseExpression: newPropertySourceCode).

	newPropertyGetter := GtBlocThemePropertyGetter new
			subThemeClass: aSubThemeClass;
			propertyName: aPropertyName;
			getterAst: (RBParser parseMethod: newPropertyGetterSourceCode).

	aNewProperty := GtBlocThemeProperty new
			subThemeModel: self;
			definingSubThemeClass: aSubThemeClass;
			propertyName: aPropertyName;
			valueAssignments: {newPropertyAssignment};
			constantAssignments: {newContantAssignment};
			neighbourConstantAssignments: (self subThemeNeighbourClasses collect: [ :eachSubThemeClass |
				newContantAssignment copyWithSubThemeClass: eachSubThemeClass
			]);
			propertyGetters: {newPropertyGetter}.

	aNewProperty
		propertyValue: (BlThemeableColor new
				privateSetColor: newConstantValue
				computation: (self class compiler evaluate: newPropertyValueBlockSource)
				source: (self class compiler evaluate: newPropertySourceBlockSource)
				forTheme: subTheme theme).

	themeProperties add: aNewProperty.

	announcer
		announce: (GtBlocSubThemePropertyAdded new themeProperty: aNewProperty)
]

{ #category : #accessing }
GtBlocSubThemeModel >> announcer [
	^ announcer
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> changeConstantNamed: aConstantName to: anObject [ 
	subTheme
		constantAt: aConstantName
		put: anObject
]

{ #category : #generation }
GtBlocSubThemeModel >> changesOn: compositeChange [	
	self themeProperties
		do: [ :eachProperty |
			compositeChange
				addInstanceVariable: eachProperty propertyName
				to: eachProperty definingSubThemeClass ].
	
	self withAllSubThemeClassSuperclasses
		do: [ :eachClass | 
			compositeChange
				compile: (self
						formatMethod: (self class
								generateInitializeThemeableSourceCode: self themeProperties
								for: eachClass))
				in: eachClass
				selector: #initializeThemeable
				classified: 'initialization'.

			compositeChange
				compile: (self
						formatMethod: (self class
								generateInitializeColorsSourceCode: self themeProperties
								for: eachClass))
				in: eachClass
				selector: #initializeColors
				classified: 'initialization'.

			compositeChange
				compile: (self
						formatMethod: (self class
								generateInitializeConstantsSourceCode: (self themeProperties flatCollect: [ :eachProperty | eachProperty constantAssignments ])
								for: eachClass))
				in: eachClass
				selector: #initializeConstants
				classified: 'initialization'.

			self themeProperties do: [ :eachProperty |
				eachProperty propertyGetters
					select: [ :eachGetter | eachGetter subThemeClass = eachClass ]
					thenDo: [ :eachGetter |
						compositeChange
							compile: (eachGetter getterAst formattedCode)
							in: eachClass
							selector: eachGetter propertyName
							classified: 'accessing' ] ] ].
	
	(self class generateInitializeNeighbourConstantsSourceCode: self themeProperties)
		keysAndValuesDo:  [ :eachSubThemeClass :eachSourceCode |
			compositeChange
				compile: (self formatMethod: eachSourceCode)
				in: eachSubThemeClass
				selector: #initializeConstants
				classified: 'initialization' ]
]

{ #category : #'private - initialization' }
GtBlocSubThemeModel >> computeAllConstantAssignmentsInNeighbourThemes [
	<return: #OrderedDictionary>

	^ self class detectAllNeighbourConstantAssignmentsIn: self subThemeClass
]

{ #category : #'private - initialization' }
GtBlocSubThemeModel >> computeConstantAssignments [
	<return: #OrderedDictionary>

	^ self class detectAllConstantAssignmentsIn: subThemeClass 
]

{ #category : #'private - initialization' }
GtBlocSubThemeModel >> computePropertyGetters: propertyNames [
	<return: #OrderedDictionary>
	| getters currentClass|
	
	getters := OrderedCollection new.
	
	currentClass := subThemeClass.
	[ currentClass = BlSubTheme ] whileFalse: [
		propertyNames do: [ :eachPropertyName |
			getters addAll: (self detectPropertyGettersIn: currentClass named:eachPropertyName ) ].

		currentClass := currentClass superclass ].
	
	^ getters groupedBy: [ :each | each propertyName ]
]

{ #category : #'private - initialization' }
GtBlocSubThemeModel >> computePropertyNames [
	^ subThemeClass allInstVarNames copyWithoutAll: BlSubTheme instVarNames
]

{ #category : #'private - initialization' }
GtBlocSubThemeModel >> computeThemeProperties: propertyNames assignments: themeableAssignments constantAssignments: constantAssignments neighbourConstantAssignments: neighbourConstantAssignments getters: propertyGetters [

	^ propertyNames collect: [ :eachVarName | 
		(GtBlocThemeProperty new
			subThemeModel: self;
			definingSubThemeClass: (self subThemeClass slotNamed: eachVarName) definingClass;
			propertyName: eachVarName;
			propertyValue: (subTheme instVarNamed: eachVarName);
			valueAssignments: (themeableAssignments at: eachVarName ifAbsent: [ #() ]);
			constantAssignments: (constantAssignments at: eachVarName ifAbsent:  [ #() ]);
			neighbourConstantAssignments: (neighbourConstantAssignments at: eachVarName ifAbsent:  [ #() ]);
			propertyGetters: (propertyGetters at: eachVarName ifAbsent: [ #() ])) ]
		as: OrderedCollection
]

{ #category : #'private - initialization' }
GtBlocSubThemeModel >> computeThemeableAssignments [
	<return: #OrderedDictionary>
	| assignments currentClass|
	
	assignments := OrderedCollection new.
	
	currentClass := subThemeClass.
	[ currentClass = BlSubTheme ] whileFalse: [
		assignments addAll: (self detectThemeableAssignmentsIn: currentClass).
		currentClass := currentClass superclass ].
	
	^ assignments groupedBy: [ :each | each valueName ]
]

{ #category : #'private - initialization' }
GtBlocSubThemeModel >> detectPropertyGettersIn: aClass named: aPropertyName [
	^ aClass
		compiledMethodAt: aPropertyName
		ifPresent: [ :aMethod | {
			GtBlocThemePropertyGetter new
				subThemeClass: aClass;
				propertyName: aPropertyName;
				getterAst: (RBParser parseMethod: aMethod sourceCode)
		}  ]
		ifAbsent: [ {} ]
]

{ #category : #'private - initialization' }
GtBlocSubThemeModel >> detectThemeableAssignmentsIn: aSubThemeClass [
	| assignments selectors |
	
	assignments := OrderedCollection new.
	
	selectors := #(initialize initializeThemeable initializeColors).
	
	selectors do: [ :eachSelector |
		aSubThemeClass
		compiledMethodAt: eachSelector
		ifPresent: [ :initializeMethod |
			| ast |
			ast := RBParser parseMethod: initializeMethod sourceCode.
			ast nodesDo: [ :each |
				each isAssignment
					ifTrue: [
						assignments add: (GtBlocThemeValueAssignment new
							subThemeClass: aSubThemeClass;
							subThemeSelector: eachSelector;
							valueName: each variable name;
							valueAst: each value) ] ] ] ].
	
	^ assignments
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> formatMethod: aSourceCode [
	^ (RBParser parseMethod: aSourceCode) formattedCode
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> generatePropertyGetterSourceCode: aPropertyName [
	^ '{1}
	^ {1}' format: { aPropertyName }
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> generatePropertySourceBlockSourceCode: aThemePropertyName [
	<return: #String>
	
	^ '[ :aTheme | aTheme {1} {2} ]' format: { self subThemeName . aThemePropertyName }
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> generatePropertyValueBlockSourceCode: aThemePropertyName propertyTypeClass: aThemeablePropertyClass [
	<return: #String>
	
	^ aThemeablePropertyClass
		generatePropertyValueSourceCode: aThemePropertyName
		inSubThemeModel: self
]

{ #category : #generation }
GtBlocSubThemeModel >> generateThemeMethods [
	| compositeChange |

	compositeChange := GtBlocThemeCompositeChange new.
	self changesOn: compositeChange.
	^ compositeChange changedNamespace
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> gtDisplayOn: stream [
	stream nextPutAll: self subThemeName
]

{ #category : #views }
GtBlocSubThemeModel >> gtThemePropertiesFor: aView [
	<gtView>
	themeProperties ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Properties';
		priority: 5;
		items: [ themeProperties ];
		column: 'Name' text: [ :each | each propertyName ];
		column: 'Value' text: [ :each | each propertyValue ]
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> initialize [
	super initialize.
	
	announcer := Announcer new
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> instantiateNewSubThemeModel: aSubThemeModelClass [
	| newSubThemeInstance |
	
	newSubThemeInstance := aSubThemeModelClass theme: subTheme theme.
	newSubThemeInstance initializeThemeable.
	
	^ self class new
		subTheme: newSubThemeInstance
		name: self subThemeName.
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> notifyThemeModified [
	subTheme theme themeModified
]

{ #category : #accessing }
GtBlocSubThemeModel >> postCopy [
	themeProperties := themeProperties copy.
	themeProperties do: [ :each | each subThemeModel: self ]
]

{ #category : #accessing }
GtBlocSubThemeModel >> replaceThemeProperty: aThemeableValue with: anotherValue [
	| index |
	index:= self themeProperties indexOf: aThemeableValue.
	self themeProperties at: index put: anotherValue.
	anotherValue subThemeModel: self.
]

{ #category : #accessing }
GtBlocSubThemeModel >> subTheme [
	self shouldNotImplement.

	^ subTheme
]

{ #category : #accessing }
GtBlocSubThemeModel >> subTheme: aBlSubTheme name: aSubThemeName [
	| propertyNames propertyGetters |
	self
		assert: [ aBlSubTheme isKindOf: BlSubTheme ]
		description: [ 'Provided SubTheme must inhertit from ' , BlSubTheme name ].

	subThemeName := aSubThemeName.
	subTheme := aBlSubTheme.
	subThemeClass := aBlSubTheme class.

	propertyNames := self computePropertyNames.
	propertyGetters := self computePropertyGetters: propertyNames.

	themeProperties := self
			computeThemeProperties: propertyNames
			assignments: self computeThemeableAssignments
			constantAssignments: self computeConstantAssignments
			neighbourConstantAssignments: self computeAllConstantAssignmentsInNeighbourThemes
			getters: propertyGetters
]

{ #category : #accessing }
GtBlocSubThemeModel >> subThemeClass [
	^ subThemeClass
]

{ #category : #accessing }
GtBlocSubThemeModel >> subThemeName [
	^ subThemeName
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> subThemeNeighbourClasses [
	^ self class allLeafNeighbourSubThemeClasses: self subThemeClass
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> subThemeSuperclasses [
	^ Array streamContents: [ :s | self subThemeSuperclassesDo: [ :eachClass | s nextPut: eachClass ] ]
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> subThemeSuperclassesDo: aBlock [
	self class
		subThemeSuperclasses: self subThemeClass
		do: aBlock
]

{ #category : #accessing }
GtBlocSubThemeModel >> themeProperties [
	^ themeProperties
]

{ #category : #'as yet unclassified' }
GtBlocSubThemeModel >> themePropertyNamed: aString ifFound: aFoundBlock [
	^ themeProperties
		detect: [ :each | each propertyName = aString ]
		ifFound: aFoundBlock
]

{ #category : #accessing }
GtBlocSubThemeModel >> withAllSubThemeClassSuperclasses [
	^ Array streamContents: [ :s | self withAllSubThemeClassSuperclassesDo: [ :eachClass | s nextPut: eachClass ] ]
]

{ #category : #accessing }
GtBlocSubThemeModel >> withAllSubThemeClassSuperclassesDo: aBlock [
	| currentClass |
	currentClass := subThemeClass.
	[ currentClass = BlSubTheme ]
		whileFalse: [
			aBlock value: currentClass.
			currentClass := currentClass superclass ]
]
