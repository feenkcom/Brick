Class {
	#name : #BrTextEditorCompositeInputFilter,
	#superclass : #BrTextEditorInputFilter,
	#instVars : [
		'filters'
	],
	#category : #'Brick-Editor-Model'
}

{ #category : #accessing }
BrTextEditorCompositeInputFilter >> addFilter: aFilter [
	filters add: aFilter
]

{ #category : #accessing }
BrTextEditorCompositeInputFilter >> filter: aString [
	^ filters
		inject: aString
		into: [ :aTempString :aFilter | aFilter filter: aTempString ]
]

{ #category : #accessing }
BrTextEditorCompositeInputFilter >> gtFiltersFor: aView [
	<gtView>
	^ aView list
		title: 'Filters';
		priority: 1;
		items: [ filters ]
]

{ #category : #accessing }
BrTextEditorCompositeInputFilter >> initialize [
	filters := OrderedCollection new
]

{ #category : #accessing }
BrTextEditorCompositeInputFilter >> removeFilter: aFilter [
	filters remove: aFilter
]
