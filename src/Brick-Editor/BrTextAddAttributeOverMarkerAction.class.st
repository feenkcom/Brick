Class {
	#name : #BrTextAddAttributeOverMarkerAction,
	#superclass : #BrTextEventHandlingAttributeAction,
	#instVars : [
		'attribute',
		'markerAttribute'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #'instance creation' }
BrTextAddAttributeOverMarkerAction class >> attribute: anAttribute overMarker: aMarkerAttribute [
	^ self new setAttribute: anAttribute marker: aMarkerAttribute
]

{ #category : #initialization }
BrTextAddAttributeOverMarkerAction >> setAttribute: anAttribute marker: aMarkerAttribute [
	attribute := anAttribute.
	markerAttribute := aMarkerAttribute
]
