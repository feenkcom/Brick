Class {
	#name : #BrGlamorousTheme,
	#superclass : #BrTheme,
	#instVars : [
		'link',
		'status',
		'default',
		'editor',
		'button',
		'item',
		'header'
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

{ #category : #initialization }
BrGlamorousTheme >> initialize [
	super initialize.
	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.
	default := BrGlamorousDefaultTheme new.
	editor := BrGlamorousEditorTheme new.
	button := BrGlamorousButtonTheme new.
	item := BrGlamorousItemTheme new.
	header := BrGlamorousHeaderTheme new
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
