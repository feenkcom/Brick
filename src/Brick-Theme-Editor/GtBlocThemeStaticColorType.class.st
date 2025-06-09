Class {
	#name : #GtBlocThemeStaticColorType,
	#superclass : #GtBlocThemeStaticProperty,
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #'as yet unclassified' }
GtBlocThemeStaticColorType >> generateColorThemeableSource: eachAssignment [
	| source |
	source := 'self
				color: {1}
				source: {2}'
			format: {
				GtBlocThemeableProperty generateValueComputation: eachAssignment valueSourceCode.
				GtBlocThemeableProperty generateSourceComputationFor: self themeableValue
			}.
	^ source
]

{ #category : #'as yet unclassified' }
GtBlocThemeStaticColorType >> transformToThemeable: aTheme withinSubThemeModel: aSubThemeModel [
	| newThemeProperty subThemeModelCopy colorComputation sourceComputation valueAssignment themeableColor|
	
	subThemeModelCopy := aSubThemeModel copy.
	
	newThemeProperty := self themeProperty copy.
	newThemeProperty valueAssignments
		ifEmpty: [ ^ nil ].

	valueAssignment := newThemeProperty valueAssignments last.

	colorComputation := Object compiler
			evaluate: (GtBlocThemeableProperty
					generateValueComputation: valueAssignment valueSourceCode).

	sourceComputation := Object compiler
			evaluate: (GtBlocThemeableProperty generateSourceComputationFor: self).

	themeableColor := BlThemeableColor
				color: colorComputation
				source: sourceComputation
				forTheme: aTheme.
			
	newThemeProperty propertyValue: themeableColor.

	newThemeProperty
		copyAndTransformAssignmentsWith: [ :eachAssignment | 
			| source newAst |
			source := self generateColorThemeableSource: eachAssignment.

			newAst := RBParser parseExpression: source.

			eachAssignment subThemeSelector: #initializeThemeable.
			eachAssignment valueAst: newAst ].


	subThemeModelCopy
		replaceThemeProperty: self themeProperty
		with: newThemeProperty.

	^ subThemeModelCopy generateThemeChanges
]
