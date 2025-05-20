Class {
	#name : #BrElementAsFormPreview,
	#superclass : #BrFrame,
	#instVars : [
		'preferredExtent',
		'formElement',
		'preferredScale'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #'instance creation' }
BrElementAsFormPreview class >> forElement: anElement [
	^ self new initializeForElement: anElement
]

{ #category : #'instance creation' }
BrElementAsFormPreview class >> forElement: anElement preferredExtent: anExtent [
	^ self new
		preferredExtent: anExtent;
		initializeForElement: anElement;
		yourself
]

{ #category : #'instance creation' }
BrElementAsFormPreview class >> forElement: anElement preferredScale: anNumber [
	^ self new
		preferredScale: anNumber;
		initializeForElement: anElement;
		yourself
]

{ #category : #initialization }
BrElementAsFormPreview >> createAsFormFuture: anElement [
	| anHdpiScaleFactor aFuture |
	
	anHdpiScaleFactor := 2.0.
	self spaceDo: [ :aSpace | anHdpiScaleFactor := aSpace windowScale ].
	
	aFuture := (BlElementAsFormFuture forElement: anElement)
		hdpiScaleFactor: anHdpiScaleFactor.
	
	preferredExtent ifNotNil: [ :aPoint | aFuture preferredExtent: aPoint ].
	preferredScale ifNotNil: [ :aNumber | aFuture preferredScaleFactor: aNumber ].
	
	^ aFuture
]

{ #category : #initialization }
BrElementAsFormPreview >> createAsFormStream: anElement [
	| anInitialFormStream anUpdatingFormStream |
	
	"renders an initial preview"
	anInitialFormStream := (self createAsFormFuture: anElement) asAsyncStream.
	
	"re-renders the preview whenever an element is invalidated"
	anUpdatingFormStream := ((anElement
		eventsStreamOn: BlElementRepaintRequestedEvent) keepOnlyLast
		throttle: 1 second)
		mapFuture: [ :eachEvent | self createAsFormFuture: eachEvent currentTarget ].
	
	^ anInitialFormStream merge: anUpdatingFormStream
]

{ #category : #initialization }
BrElementAsFormPreview >> initialize [
	super initialize.
	
	preferredExtent := nil.
	preferredScale := nil.

	formElement := BrStreamedFormElement new size: 0@0.
	
	self fitContent.
	self addChild: formElement
]

{ #category : #initialization }
BrElementAsFormPreview >> initializeForElement: anElement [
	| aFormStream |
	aFormStream := self createAsFormStream: anElement.
	formElement stream: aFormStream
]

{ #category : #accessing }
BrElementAsFormPreview >> preferredExtent: aPoint [
	preferredExtent := aPoint.
	preferredScale := nil.
]

{ #category : #accessing }
BrElementAsFormPreview >> preferredScale: aNumber [
	preferredExtent := nil.
	preferredScale := aNumber.
]
