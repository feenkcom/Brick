Class {
	#name : #BrAsyncFileWidget,
	#superclass : #BrAsyncWidget,
	#category : #'Brick-Async-Widget'
}

{ #category : #accessing }
BrAsyncFileWidget >> file: aFile [

	self stencil: [ 
		(SkiaImage fromForm: (Form fromBinaryStream: aFile binaryReadStream))
			asElement constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #accessing }
BrAsyncFileWidget >> url: aUrl [

	self stencil: [ 
		(SkiaImage fromForm:
			 (Form fromBase64String:
				  aUrl asZnUrl retrieveContents base64Encoded)) asElement 
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ] ]
]
