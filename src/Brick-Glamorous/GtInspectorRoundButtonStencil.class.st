Class {
	#name : #GtInspectorRoundButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'size'
	],
	#category : #'Brick-Glamorous-Stencils and Builders'
}

{ #category : #'instance creation' }
GtInspectorRoundButtonStencil class >> large [
	^ self new size: 24@24
]

{ #category : #'instance creation' }
GtInspectorRoundButtonStencil class >> mini [
	^ self new size: 10 @ 10
]

{ #category : #'instance creation' }
GtInspectorRoundButtonStencil class >> normal [
	^ self new size: 20@20
]

{ #category : #'instance creation' }
GtInspectorRoundButtonStencil class >> small [
	^ self new size: 16@16
]

{ #category : #'instance creation' }
GtInspectorRoundButtonStencil class >> tiny [
	^ self new size: 12 @ 12
]

{ #category : #'api - instantiation' }
GtInspectorRoundButtonStencil >> create [
	^ BrButton new
		background: Color white;
		aptitude: BrIconAptitude + BrGlamorousFocusableShadowAptitude new;
		geometry: BlEllipseGeometry new;
		layout: BlLinearLayout horizontal alignCenter;
		exact: self size;
		when: BlMouseEnterEvent do: [ :anEvent | anEvent currentTarget background: Color veryVeryLightGray lighter ];
		when: BlMouseLeaveEvent do: [ :anEvent | anEvent currentTarget background: Color white ];
		yourself
]

{ #category : #initialization }
GtInspectorRoundButtonStencil >> initialize [
	super initialize.
	
	size := 20@20
]

{ #category : #accessing }
GtInspectorRoundButtonStencil >> size [
	^ size
]

{ #category : #accessing }
GtInspectorRoundButtonStencil >> size: anObject [
	size := anObject
]
