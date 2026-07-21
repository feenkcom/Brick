Class {
	#name : #BrTextRemoveAttributeOverMarkerAction,
	#superclass : #BrTextEventHandlingAttributeAction,
	#instVars : [
		'attribute',
		'markerAttribute'
	],
	#category : 'Brick-Editor-Attributes'
}

{ #category : #'instance creation' }
BrTextRemoveAttributeOverMarkerAction class >> attribute: anAttribute overMarker: aMarkerAttribute [
	^ self new setAttribute: anAttribute marker: aMarkerAttribute
]

{ #category : #initialization }
BrTextRemoveAttributeOverMarkerAction >> setAttribute: anAttribute marker: aMarkerAttribute [
	attribute := anAttribute.
	markerAttribute := aMarkerAttribute
]
