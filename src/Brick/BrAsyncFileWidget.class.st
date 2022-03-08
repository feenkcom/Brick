Class {
	#name : #BrAsyncFileWidget,
	#superclass : #BrAsyncWidget,
	#category : #'Brick-Async-Widget'
}

{ #category : #accessing }
BrAsyncFileWidget >> file: aFile [

	self stencil: [ 
		(SkiaImage fromFile: aFile asFileReference)
			asElement constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #accessing }
BrAsyncFileWidget >> url: aUrl [

	| realUrl |
	realUrl := aUrl asZnUrl.

	realUrl scheme = #file ifTrue: [ 
		^ self file: realUrl asFileReference ].

	self stencil: [ 
		(SkiaImage fromForm:
			 (Form fromBase64String: realUrl retrieveContents base64Encoded))
			asElement constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]
]
