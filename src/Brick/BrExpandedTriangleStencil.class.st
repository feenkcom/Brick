Class {
	#name : #BrExpandedTriangleStencil,
	#superclass : #BrTriangleStencil,
	#category : #'Brick-Triangle - Stencil'
}

{ #category : #'api - instantiation' }
BrExpandedTriangleStencil >> create [
	<return: #BlElement>
	
	^ super create
		geometry: (BlPolygonGeometry vertices: { 0@0 . 8@0 . 4@8 })
]
