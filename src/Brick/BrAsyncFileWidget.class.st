Class {
	#name : #BrAsyncFileWidget,
	#superclass : #BrAsyncWidget,
	#category : #'Brick-Async-Widget'
}

{ #category : #'system startup' }
BrAsyncFileWidget class >> startUp: resuming [

	resuming ifFalse: [ ^ self ].

	self allInstancesDo: [ :eachInstance | eachInstance resumeOnStartUp ]
]

{ #category : #accessing }
BrAsyncFileWidget >> file: aFile [

	self stencil: [ 
		(SkiaImage fromFile: aFile asFileReference)
			asElement constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #'system startup' }
BrAsyncFileWidget >> resumeOnStartUp [

	session ifNil: [ ^ self ].
	session == Smalltalk session ifTrue: [ ^ self ].

	self removeChildren.

	stencil ifNotNil: [ :aStencil | self stencil: aStencil ]
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
