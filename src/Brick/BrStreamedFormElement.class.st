Class {
	#name : #BrStreamedFormElement,
	#superclass : #BlElement,
	#instVars : [
		'formElement'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #accessing }
BrStreamedFormElement >> initialize [
	super initialize.
	
	formElement := BlElement new.
	self addChild: formElement.
	
	self withAsyncSinkDo: [ :anElementSink |
		anElementSink
			sink: AsyncPeekSink new;
			whenUpdate: [ :aFormElement :aSink |
				aSink peek ifSome: [ :aForm |
					| aScaledExtent |
					
					aScaledExtent := aForm extent / aForm scaleFactor asFloat.
					aFormElement
						size: aScaledExtent.
					formElement
						size: aForm extent;
						background: aForm;
						transformDo: [ :t | t topLeftOrigin scaleBy: 1.0 / aForm scaleFactor ] ] ] ]
]

{ #category : #accessing }
BrStreamedFormElement >> stream: anAsyncStream [
	self asyncSink forwardStream: anAsyncStream
]
