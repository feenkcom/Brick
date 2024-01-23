Class {
	#name : #BrPagerPagePreviewFocusListener,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'previewElement',
		'scrollbarAptitude'
	],
	#category : #'Brick-Pager - Look'
}

{ #category : #'api - accessing' }
BrPagerPagePreviewFocusListener >> eventsToHandle [
	^ { BlFocusInEvent . BlFocusOutEvent . BlFocusTransferEvent. BrPagerPageBoundEvent }
]

{ #category : #'element handlers' }
BrPagerPagePreviewFocusListener >> focusInEvent: anEvent [
	scrollbarAptitude selectPreviewElement: previewElement.	
	
	previewElement userData
		at: #previousFocusedElement
		put: anEvent target asWeakReference
]

{ #category : #'element handlers' }
BrPagerPagePreviewFocusListener >> focusOutEvent: anEvent [
	previewElement userData
		at: #previousFocusedElement
		put: anEvent target asWeakReference
]

{ #category : #'element handlers' }
BrPagerPagePreviewFocusListener >> focusTransferEvent: anEvent [
	previewElement userData
		at: #previousFocusedElement
		put: anEvent focusedElement asWeakReference
]

{ #category : #'api - hooks' }
BrPagerPagePreviewFocusListener >> onInstalledIn: aPageElement [
	super onInstalledIn: aPageElement.
	
	aPageElement hasFocus
		ifTrue: [ scrollbarAptitude selectPreviewElement: previewElement ].
	
	aPageElement deepestFocusedChild
		ifNotNil: [ :aFocusedElement |
			previewElement userData
				at: #previousFocusedElement
				put: aFocusedElement asWeakReference ]
]

{ #category : #'element handlers' }
BrPagerPagePreviewFocusListener >> pageBoundEvent: anEvent [
	| aFocusTarget |
	previewElement states isSelected
		ifFalse: [ ^ self ].

	aFocusTarget := previewElement userData
		at: #previousFocusedElement
		ifPresent: [ :aWeakReference |
			(aWeakReference at: 1)
				ifNotNil: [ :aPreviouslyFocusedElement |
					(aPreviouslyFocusedElement hasParent: anEvent currentTarget)
						ifTrue: [ aPreviouslyFocusedElement ]
						ifFalse: [ anEvent currentTarget ] ]
				ifNil: [ anEvent currentTarget ] ]
		ifAbsent: [ anEvent currentTarget ].

	aFocusTarget requestFocus
]

{ #category : #'api - accessing' }
BrPagerPagePreviewFocusListener >> previewElement [
	^ previewElement
]

{ #category : #'api - accessing' }
BrPagerPagePreviewFocusListener >> previewElement: anObject [
	previewElement := anObject
]

{ #category : #accessing }
BrPagerPagePreviewFocusListener >> scrollbarAptitude: anObject [
	scrollbarAptitude := anObject
]
