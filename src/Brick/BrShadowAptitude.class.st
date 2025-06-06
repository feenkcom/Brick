"
I add a gaussian shadow around an element.

To work properly and element should have some margin in order for the shadow to not be clipped by the parent bounds
"
Class {
	#name : #BrShadowAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'shadow'
	],
	#category : #'Brick-! Core - Aptitudes'
}

{ #category : #accessing }
BrShadowAptitude >> beLarge [
	self 
		width: 6;
		offset: 0@3
]

{ #category : #accessing }
BrShadowAptitude >> color: aColor [
	self shadow: (self shadow copyWithColor: aColor)
]

{ #category : #initialization }
BrShadowAptitude >> initialize [
	super initialize.
	shadow := BlGaussianShadowEffect
		color: self theme default defaultShadowColor
		width: 2
		offset: 0 @ 1.
	self
		addChange:
			(BrLookChange new
				up: [ :e | e widget effect: shadow ];
				down: [ :e | e widget effect: BlNullEffect new ])
]

{ #category : #accessing }
BrShadowAptitude >> offset: aColor [
	self shadow: (self shadow copyWithOffset: aColor)
]

{ #category : #private }
BrShadowAptitude >> shadow [
	<return: #BlGaussianShadowEffect>

	^ shadow
]

{ #category : #private }
BrShadowAptitude >> shadow: aBlDropShadowEffect [
	shadow := aBlDropShadowEffect.
	self
		widgetDo: [ changes
				downOn: self;
				upOn: self ]
]

{ #category : #accessing }
BrShadowAptitude >> width: aNumber [
	self shadow: (self shadow copyWithWidth: aNumber)
]
