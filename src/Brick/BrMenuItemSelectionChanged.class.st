Class {
	#name : #BrMenuItemSelectionChanged,
	#superclass : #BrMenuModelAnnouncement,
	#instVars : [
		'isSelected'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuItemSelectionChanged >> isSelected [
	<return: #Boolean>
	^ isSelected
]

{ #category : #accessing }
BrMenuItemSelectionChanged >> isSelected: aBoolean [
	isSelected := aBoolean
]
