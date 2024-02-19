Class {
	#name : #BrGlamorousAnchoredAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'background',
		'cornerRadius',
		'border'
	],
	#category : #'Brick-Glamorous-Anchored'
}

{ #category : #accessing }
BrGlamorousAnchoredAptitude >> background [
	^ background
]

{ #category : #accessing }
BrGlamorousAnchoredAptitude >> background: aBlBackground [
	background := aBlBackground.
	self widgetDo: [ :aWidget | aWidget background: background ]
]

{ #category : #accessing }
BrGlamorousAnchoredAptitude >> border [
	^ border
]

{ #category : #accessing }
BrGlamorousAnchoredAptitude >> border: anObject [
	border := anObject asBlBorder.
	self widgetDo: [ :aWidget | aWidget border: border ]
]

{ #category : #accessing }
BrGlamorousAnchoredAptitude >> cornerRadius [
	<return: #Number>

	^ cornerRadius
]

{ #category : #accessing }
BrGlamorousAnchoredAptitude >> cornerRadius: aNumber [
	cornerRadius := aNumber.
	
	self widgetDo: [ :aWidget | aWidget geometry: (BrAnchoredGeometry cornerRadius: aNumber element: aWidget) ]
]

{ #category : #'instance creation' }
BrGlamorousAnchoredAptitude >> initialize [
	super initialize.
	background := Color white.
	border := self theme button defaultBorderColor asBlBorder.
	cornerRadius := 4.
	self
		add: BrShadowAptitude new;
		addChangeProperty: #(widget geometry)
			with: [ BrAnchoredGeometry cornerRadius: self cornerRadius element: widget ];
		addChangeProperty: #(widget background) with: [ self background ];
		addChangeProperty: #(widget border)
			with: [ border asBlBorder ]
]
