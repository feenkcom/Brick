Class {
	#name : #BrFromFutureDataBinder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'element',
		'data'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #'api - instantiation' }
BrFromFutureDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ element
]

{ #category : #accessing }
BrFromFutureDataBinder >> data: anObject [

	data := anObject
]

{ #category : #accessing }
BrFromFutureDataBinder >> element: anObject [

	element := anObject
]

{ #category : #'api - instantiation' }
BrFromFutureDataBinder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: element;
		push: data
]

{ #category : #accessing }
BrFromFutureDataBinder >> reset [
	data := nil.
	element := nil
]
