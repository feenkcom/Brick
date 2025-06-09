Class {
	#name : #GtBlocThemeCompositeChange,
	#superclass : #GtBlocThemeChange,
	#instVars : [
		'changes'
	],
	#category : #'Brick-Theme-Editor-Changes'
}

{ #category : #compiling }
GtBlocThemeCompositeChange >> addInstanceVariable: variableName to: variableClass [
	changes add: (GtBlocThemeAddInstanceVariableChange new
		variableClass: variableClass;
		variableName: variableName)
]

{ #category : #'as yet unclassified' }
GtBlocThemeCompositeChange >> applyOnNamespace: aRBNamespace [
	changes do: [ :each | each applyOnNamespace: aRBNamespace ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeCompositeChange >> changedNamespace [
	| model |
	
	model := RBNamespace new.
	self relevantChanges do: [ :each | each applyOnNamespace: model ].
	^ model
]

{ #category : #compiling }
GtBlocThemeCompositeChange >> compile: methodSourceCode in: methodClass selector: methodSelector classified: methodProtocol [
	changes add: (GtBlocThemeCompileMethodChange new
		methodClass: methodClass;
		methodSelector: methodSelector;
		methodSourceCode: methodSourceCode;
		methodProtocol: methodProtocol)
]

{ #category : #'as yet unclassified' }
GtBlocThemeCompositeChange >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		priority: 5;
		stencil: [ GtBlocThemeChangesElement new themeChanges: self ];
		actionUpdateButton
]

{ #category : #initialization }
GtBlocThemeCompositeChange >> initialize [
	super initialize.
	
	changes := OrderedCollection new
]

{ #category : #'as yet unclassified' }
GtBlocThemeCompositeChange >> isRedundantForNamespace: aRBNamespace [
	^ changes allSatisfy: [ :each | each isRedundantForNamespace: aRBNamespace ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeCompositeChange >> relevantChanges [
	| model relevantChanges |

	model := RBNamespace new.
	relevantChanges := changes
		reject: [ :eachChange | eachChange isRedundantForNamespace: model ].

	^ relevantChanges copyWithoutDuplicates
]
