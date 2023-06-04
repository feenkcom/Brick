Class {
	#name : #BrAsyncFileWidget,
	#superclass : #BrAsyncWidget,
	#category : #'Brick-Async-Widget'
}

{ #category : #accessing }
BrAsyncFileWidget class >> initialize [

	SessionManager default registerGuiClassNamed: self name
]

{ #category : #'system startup' }
BrAsyncFileWidget class >> startUp: resuming [

	resuming ifFalse: [ ^ self ].

	self allInstancesDo: [ :eachInstance | eachInstance resumeOnStartUp ]
]

{ #category : #accessing }
BrAsyncFileWidget >> contents: aByteArray [
	self
		stencil: [ (SkiaImage
				fromBuffer: aByteArray
				start: 0
				end: aByteArray size - 1) asElement
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #accessing }
BrAsyncFileWidget >> file: aFile [

	self stencil: [ 
		(SkiaImage fromFile: aFile asFileReference)
			asElement constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #accessing }
BrAsyncFileWidget >> formBlock: aBlock [

	self stencil: [ 
		(SkiaImage fromForm: aBlock value)
			asElement constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ] ]
]

{ #category : #'system startup' }
BrAsyncFileWidget >> resumeOnStartUp [

	session ifNil: [ ^ self ].

	self enqueueTask: (BlTaskAction new action: [ 
			 (session isNotNil and: [ session == Smalltalk session ]) ifFalse: [ 
				 session := nil.
				 self removeChildren.

				 stencil ifNotNil: [ :aStencil | self stencil: aStencil ] ] ])
]

{ #category : #accessing }
BrAsyncFileWidget >> url: aUrl [

	| realUrl |
	realUrl := aUrl asZnUrl.

	realUrl scheme = #file ifTrue: [ 
		^ self file: realUrl asFileReference ].

	self stencil: [ 
		(SkiaImage fromForm:
			 (Form fromBase64String: realUrl retrieveContents asByteArray base64Encoded))
			asElement constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]
]
