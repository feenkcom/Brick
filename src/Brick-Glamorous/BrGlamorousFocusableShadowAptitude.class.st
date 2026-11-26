Class {
	#name : #BrGlamorousFocusableShadowAptitude,
	#superclass : #BrShadowAptitude,
	#instVars : [
		'shadowStyle'
	],
	#category : #'Brick-Glamorous-Shadow'
}

{ #category : #initialization }
BrGlamorousFocusableShadowAptitude >> initializeShadowStyle [
	shadowStyle := BrLazyStyleCommonAptitude new
			default: [ :aStyle :aTheme | 
				aStyle
					effect: (self shadow copyWithColor: (self shadow color blocResolveColorForTheme: aTheme)) ];
			focused: [ :aStyle :aTheme | 
				aStyle
					effect: (self shadow
							copyWithColor: (aTheme default primaryShadowColor blocResolveColorForTheme: aTheme)) ];
			yourself.
	self add: shadowStyle
]

{ #category : #accessing }
BrGlamorousFocusableShadowAptitude >> shadow: anEffect [
	shadowStyle updateWith: [ shadow := anEffect ]
]
