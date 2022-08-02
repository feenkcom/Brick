"
I am sent by {{gtClass:BrPagerModel}} when a new {{gtClass:BrPagerPageModel}} is added to the pager

"
Class {
	#name : #BrPagerPageAddedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'page'
	],
	#category : #'Brick-Pager - Events'
}

{ #category : #'instance creation' }
BrPagerPageAddedEvent class >> page: aPageModel [
	^ self new page: aPageModel
]

{ #category : #accessing }
BrPagerPageAddedEvent >> page [
	^ page
]

{ #category : #accessing }
BrPagerPageAddedEvent >> page: anObject [
	page := anObject
]
