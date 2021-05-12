Class {
	#name : #BrThemeMigration,
	#superclass : #Object,
	#category : #'Brick-Theme-Migration'
}

{ #category : #accessing }
BrThemeMigration >> childThemeClassName: aString [
	^ #BrGlamorous , aString capitalized , #Theme
]

{ #category : #accessing }
BrThemeMigration >> colorMethodsToMigrate [
	<gtExample>
	^ BrGlamorousColors class methods
		reject: [ :e | 
			(e category beginsWith: '*')
				or: [ e category = #initialization or: [ e selector isUnary not ] ] ]
]

{ #category : #accessing }
BrThemeMigration >> ensureGlamorousTheme [
	<gtExample>
	| model refactoring |
	model := RBClassModelFactory rbNamespace
		onEnvironment: RBBrowserEnvironment new.
	refactoring := RBAddClassRefactoring
		model: model
		addClass: #BrGlamorousTheme
		superclass: BrTheme
		subclasses: #()
		category: #'Brick-Theme-Glamorous'.
	refactoring primitiveExecute.
	refactoring := RBAddClassRefactoring
		model: model
		addClass: #BrGlamorousTheme
		superclass: BrTheme
		subclasses: #()
		category: #'Brick-Theme-Glamorous'.
	refactoring primitiveExecute.
	^ model changes
]

{ #category : #accessing }
BrThemeMigration >> methodToSelector: aMethod inTheme: aString [
	| selector |
	selector := aMethod selector.
	aString = 'default'
		ifFalse: [ selector := aMethod selector
				copyReplaceAll: aString capitalized
				with: ''.
			selector := selector copyReplaceAll: aString with: '' ].
	aString = 'item'
		ifTrue: [ selector := selector copyReplaceAll: 'List' with: '' ].
	selector := selector removePrefix: 'link'.
	selector := selector removePrefix: 'With'.
	selector := selector uncapitalized.
	selector = 'color'
		ifTrue: [ ^ selector ].
	((selector endsWith: 'Color') or: [ selector endsWith: 'Colors' ])
		ifTrue: [ ^ selector ].
	^ selector , 'Color'
]

{ #category : #accessing }
BrThemeMigration >> methodToTheme: aMethod [
	| category |
	aMethod selector = #expandCollapseTriangleBackgroundColor
		ifTrue: [ ^ 'default' ].
	category := aMethod category.
	category = 'accessing'
		ifTrue: [ ^ 'default' ].
	(category beginsWith: 'list')
		ifTrue: [ ^ 'item' ].
	(category beginsWith: 'links')
		ifTrue: [ ^ 'link' ].
	^ ('-' split: category) first trimBoth
]

{ #category : #accessing }
BrThemeMigration >> refactoringAddChildInitializer: aString withColors: aDictionary in: aModel [
	| source |
	source := String
		streamContents: [ :s | 
			s nextPutAll: 'initialize super initialize.'.
			aDictionary
				keysAndValuesDo: [ :k :v | 
					s
						nextPutAll: k;
						nextPutAll: ':=BrGlamorousColors ';
						nextPutAll: v;
						nextPut: $. ] ].
	^ RBSilentlyAddMethodRefactoring
		model: aModel
		addMethod: (RBParser parseMethod: source) formattedCode
		toClass: (self childThemeClassName: aString)
		inProtocols: {#initialization}
]

{ #category : #accessing }
BrThemeMigration >> refactoringAddChildThemeClassNamed: aString in: aModel [
	^ RBAddClassRefactoring
		model: aModel
		addClass: (self childThemeClassName: aString)
		superclass: BrTheme
		subclasses: #()
		category: #'Brick-Theme-Glamorous'
]

{ #category : #accessing }
BrThemeMigration >> refactoringAddParentInitializerWithChildThemes: aCollection in: aModel [
	| source |
	source := String
		streamContents: [ :s | 
			s nextPutAll: 'initialize super initialize.'.
			aCollection
				do: [ :e | 
					s
						nextPutAll: e;
						nextPutAll: ':=';
						nextPutAll: (self childThemeClassName: e);
						nextPutAll: ' new.' ] ].
	^ RBSilentlyAddMethodRefactoring
		model: aModel
		addMethod: (RBParser parseMethod: source) formattedCode
		toClass: #BrGlamorousTheme
		inProtocols: {#initialization}
]

{ #category : #accessing }
BrThemeMigration >> refactoringAddParentThemeClassIn: aModel [
	^ RBAddClassRefactoring
		model: aModel
		addClass: #BrGlamorousTheme
		superclass: BrTheme
		subclasses: #()
		category: #'Brick-Theme-Glamorous'
]

{ #category : #accessing }
BrThemeMigration >> refactoringsAddColor: aSymbol inChildThemeNamed: aString in: aModel [
	| themeClassName |
	themeClassName := self childThemeClassName: aString.
	^ {(RBAddInstanceVariableRefactoring
		model: aModel
		variable: aSymbol
		class: themeClassName).
	(RBCreateAccessorsForVariableRefactoring
		model: aModel
		variable: aSymbol
		class: themeClassName
		classVariable: false)}
]

{ #category : #accessing }
BrThemeMigration >> refactoringsAddParentChildNamed: aString in: aModel [
	^ {(RBAddInstanceVariableRefactoring
		model: aModel
		variable: aString
		class: #BrGlamorousTheme).
	(RBCreateAccessorsForVariableRefactoring
		model: aModel
		variable: aString
		class: #BrGlamorousTheme
		classVariable: false)}
]

{ #category : #accessing }
BrThemeMigration >> referencesChanges [
	"Note that applying these changes requires the default theme to be the glamorous theme. Otherwise no debugger will be able to open"

	<gtExample>
	<noTest>
	| selectorThemesMapping model |
	selectorThemesMapping := (self themeSelectorsMapping associations
		flatCollect:
			[ :e | e value associations collect: [ :f | f value -> (e key -> f key) ] ])
		asDictionary.
	model := RBClassModelFactory rbNamespace
		onEnvironment: RBBrowserEnvironment new.
	(BrThemeColorSenderRefactoring
		model: model
		selectorThemesMapping: selectorThemesMapping) primitiveExecute.
	^ model changes
]

{ #category : #accessing }
BrThemeMigration >> scaffoldingChanges [
	<gtExample>
	<noTest>
	| themeSelectorsMapping model |
	themeSelectorsMapping := self themeSelectorsMapping.
	model := RBClassModelFactory rbNamespace
		onEnvironment: RBBrowserEnvironment new.
	(self refactoringAddParentThemeClassIn: model) primitiveExecute.
	themeSelectorsMapping
		keysAndValuesDo: [ :n :d | 
			(self refactoringAddChildThemeClassNamed: n in: model)
				primitiveExecute.
			(self refactoringsAddParentChildNamed: n in: model)
				do: #primitiveExecute.
			d
				keysDo: [ :k | 
					(self refactoringsAddColor: k inChildThemeNamed: n in: model)
						do: #primitiveExecute ].
			(self refactoringAddChildInitializer: n withColors: d in: model)
				primitiveExecute ].
	(self
		refactoringAddParentInitializerWithChildThemes: themeSelectorsMapping keys
		in: model) primitiveExecute.
	^ model changes
]

{ #category : #accessing }
BrThemeMigration >> themeSelectorsMapping [
	<gtExample>
	| themes |
	themes := Dictionary new.
	self colorMethodsToMigrate
		do: [ :e | 
			| theme selector |
			theme := self methodToTheme: e.
			selector := self methodToSelector: e inTheme: theme.
			themes at: theme ifAbsentPut: [ Dictionary new ].
			(themes at: theme) at: selector put: e selector ].
	^ themes
]
