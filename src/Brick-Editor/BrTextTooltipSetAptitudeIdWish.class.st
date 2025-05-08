"
I dispatch {{gtClass:BrTextTooltipId}} from {{gtClass:BrTextTooltipAttribute}} to {{gtClass:BrTextTooltipMouseHoverEventHandler}}. 

"
Class {
	#name : #BrTextTooltipSetAptitudeIdWish,
	#superclass : #BrPopoverWish,
	#instVars : [
		'aptitudeId'
	],
	#category : #'Brick-Editor-Attributes - Support'
}

{ #category : #accessing }
BrTextTooltipSetAptitudeIdWish >> aptitudeId [
	^ aptitudeId
]

{ #category : #accessing }
BrTextTooltipSetAptitudeIdWish >> aptitudeId: anObject [
	aptitudeId := anObject
]

{ #category : #sending }
BrTextTooltipSetAptitudeIdWish >> sendTo: anObject [
	anObject textTooltipSetAptitudeIdWish: self
]
