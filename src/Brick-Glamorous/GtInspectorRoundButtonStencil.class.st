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
	| aButton |
	aButton := BrButton new.
	^ aButton
		background: aButton theme default contentBackground;
		aptitude: BrIconAptitude + BrGlamorousFocusableShadowAptitude new;
		addAptitude: (BrLazyStyleCommonAptitude new
				hovered: [ :aStyle :aTheme | aStyle border: (BlBorder paint: aTheme button hoveredBorderColor width: 1) ]);
		geometry: BlEllipseGeometry new;
		layout: BlLinearLayout horizontal alignCenter;
		exact: self size;
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
