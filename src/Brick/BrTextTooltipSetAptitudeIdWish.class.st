"
I dispatch a tooltip it from {{gtClass:BrTextTooltipAttribute}} to {{gtClass:BrTextTooltipMouseHoverEventHandler}}. 

"
Class {
	#name : #BrTextTooltipSetAptitudeIdWish,
	#superclass : #BrPopoverWish,
	#instVars : [
		'aptitudeId'
	],
	#category : #'Brick-Attributes - Support'
}

{ #category : #sending }
BrTextTooltipSetAptitudeIdWish >> sendTo: anObject [
	anObject textTooltipSetAptitudeIdWish: self
]

{ #category : #accessing }
BrTextTooltipSetAptitudeIdWish >> subtext [
	^ aptitudeId
]

{ #category : #accessing }
BrTextTooltipSetAptitudeIdWish >> subtext: anObject [
	aptitudeId := anObject
]
