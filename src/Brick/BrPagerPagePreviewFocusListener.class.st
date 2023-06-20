Class {
	#name : #BrPagerPagePreviewFocusListener,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'previewElement'
	],
	#category : #'Brick-Pager - Look'
}

{ #category : #'api - accessing' }
BrPagerPagePreviewFocusListener >> eventsToHandle [
	^ { BlFocusInEvent . BlFocusOutEvent }
]

{ #category : #'element handlers' }
BrPagerPagePreviewFocusListener >> focusInEvent: anEvent [
	self selectPreview: true
]

{ #category : #'element handlers' }
BrPagerPagePreviewFocusListener >> focusOutEvent: anEvent [
	self selectPreview: false
]

{ #category : #'api - hooks' }
BrPagerPagePreviewFocusListener >> onInstalledIn: aPageElement [
	super onInstalledIn: aPageElement.
	
	self selectPreview: aPageElement hasFocus
]

{ #category : #'api - accessing' }
BrPagerPagePreviewFocusListener >> previewElement [
	^ previewElement
]

{ #category : #'api - accessing' }
BrPagerPagePreviewFocusListener >> previewElement: anObject [
	previewElement := anObject
]

{ #category : #'element handlers' }
BrPagerPagePreviewFocusListener >> selectPreview: aBoolean [
	previewElement dispatchEvent: (BlElementSelectedStateWish selected: aBoolean)
]
