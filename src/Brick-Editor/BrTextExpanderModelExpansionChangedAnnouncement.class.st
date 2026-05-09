Class {
	#name : #BrTextExpanderModelExpansionChangedAnnouncement,
	#superclass : #BrTextExpanderModelAnnouncement,
	#instVars : [
		'isExpanded'
	],
	#category : #'Brick-Editor-Attributes - Support'
}

{ #category : #accessing }
BrTextExpanderModelExpansionChangedAnnouncement >> isExpanded [
	^ isExpanded ifNil: [ false ]
]

{ #category : #accessing }
BrTextExpanderModelExpansionChangedAnnouncement >> isExpanded: aBoolean [
	isExpanded := aBoolean
]
