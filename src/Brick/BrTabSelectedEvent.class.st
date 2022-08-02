"
I am sent when a tab is selected in {{gtClass:BrTabGroupModel}}

"
Class {
	#name : #BrTabSelectedEvent,
	#superclass : #BrTabEvent,
	#category : #'Brick-Tabs - Events'
}

{ #category : #sending }
BrTabSelectedEvent >> sendTo: anObject [
	anObject tabSelected: self
]
