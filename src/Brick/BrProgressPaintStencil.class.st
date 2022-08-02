"
I am an abstract class. I define an animated tool bar background. My subclasses return {{gtClass:BlPaint}} objects on every {{gtMethod:BrProgressPaintStencil>>#create|label=#selector}} call. The subclasses should return different {{gtClass:BlPaint}} objects on every call in order to generate an animated background effect.

I am used by {{gtClass:BrProgressAnimatedBarLook}}.

See my subclasses for specific use cases: {{gtClass:BrProgressPaintStencil|show=#gtSubclassesFor:|expanded=true|height=150}}


"
Class {
	#name : #BrProgressPaintStencil,
	#superclass : #BrStencil,
	#category : #'Brick-Progress - Look'
}

{ #category : #testing }
BrProgressPaintStencil class >> isAbstract [
	^ self name = #BrProgressPaintStencil 
]

{ #category : #'api - instantiation' }
BrProgressPaintStencil >> create [
	<return: #BlPaint>
	^ self subclassResponsibility
]
