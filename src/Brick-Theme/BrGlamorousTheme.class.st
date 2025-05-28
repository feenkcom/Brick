Class {
	#name : #BrGlamorousTheme,
	#superclass : #BlTheme,
	#instVars : [
		'link',
		'status',
		'default',
		'editor',
		'button',
		'item',
		'header',
		'label'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousTheme >> button [
	^ button
]

{ #category : #accessing }
BrGlamorousTheme >> button: anObject [
	button := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> default [
	^ default
]

{ #category : #accessing }
BrGlamorousTheme >> default: anObject [
	default := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> editor [
	^ editor
]

{ #category : #accessing }
BrGlamorousTheme >> editor: anObject [
	editor := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> header [
	^ header
]

{ #category : #accessing }
BrGlamorousTheme >> header: anObject [
	header := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> item [
	^ item
]

{ #category : #accessing }
BrGlamorousTheme >> item: anObject [
	item := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> label [
	^ label ifNil: [ label := BrGlamorousLabelLightTheme new]
]

{ #category : #accessing }
BrGlamorousTheme >> label: anObject [
	label := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> link [
	^ link
]

{ #category : #accessing }
BrGlamorousTheme >> link: anObject [
	link := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> status [
	^ status
]

{ #category : #accessing }
BrGlamorousTheme >> status: anObject [
	status := anObject
]
