Class {
	#name : #GtBlocThemeValueAssignment,
	#superclass : #GtBlocThemePropertyAssignment,
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #views }
GtBlocThemeValueAssignment >> gtValueAstFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		priority: 5;
		object: [ valueAst ];
		view: #gtSourceCodeFor:
]
