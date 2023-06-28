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
	self selectPreview: true.
	
	previewElement userData
		at: #previousFocusedElement
		put: anEvent target asWeakReference
]

{ #category : #'element handlers' }
BrPagerPagePreviewFocusListener >> focusOutEvent: anEvent [
	self selectPreview: false.
	
	previewElement userData
		at: #previousFocusedElement
		put: anEvent target asWeakReference
]

{ #category : #'api - hooks' }
BrPagerPagePreviewFocusListener >> onInstalledIn: aPageElement [
	super onInstalledIn: aPageElement.
	
	self selectPreview: aPageElement hasFocus.
	
	aPageElement deepestFocusedChild
		ifNotNil: [ :aFocusedElement |
			previewElement userData
				at: #previousFocusedElement
				put: aFocusedElement asWeakReference ]
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
