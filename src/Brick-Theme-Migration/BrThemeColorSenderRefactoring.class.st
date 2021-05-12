Class {
	#name : #BrThemeColorSenderRefactoring,
	#superclass : #RBRefactoring,
	#instVars : [
		'selectorThemesMapping'
	],
	#category : #'Brick-Theme-Migration'
}

{ #category : #accessing }
BrThemeColorSenderRefactoring class >> model: aModel selectorThemesMapping: aDictionary [
	^ self new
		model: aModel;
		selectorThemesMapping: aDictionary;
		yourself
]

{ #category : #accessing }
BrThemeColorSenderRefactoring class >> selectorThemesMapping: aDictionary [
	^ self new
		selectorThemesMapping: aDictionary;
		yourself
]

{ #category : #accessing }
BrThemeColorSenderRefactoring >> preconditions [
	^ RBCondition withBlock: [ true ]
]

{ #category : #accessing }
BrThemeColorSenderRefactoring >> selectorThemesMapping: aDictionary [
	selectorThemesMapping := aDictionary
]

{ #category : #accessing }
BrThemeColorSenderRefactoring >> transform [
	"Note that this refactoring ignores the model in querying, but writes to the model"

	BlElement gtIsOrInheritsFrom | BrAptitude gtIsOrInheritsFrom
		& 'BrGlamorousColors `@s: `@a' gtRBPatternMatches
		do: [ :m | 
			m isFromTrait
				ifFalse: [ self
						convertMethod: m selector
						for: (self classObjectFor: m methodClass)
						using:
							(RBParseTreeRewriter new
								replace: 'BrGlamorousColors `@s: `@a'
								withValueFrom: [ :n | 
									| themeSelector |
									themeSelector := selectorThemesMapping at: n selector.
									RBParser
										parseExpression: 'self theme ' , themeSelector key , ' ' , themeSelector value ]
								when: [ :n | selectorThemesMapping includesKey: n selector ]) ] ]
]
