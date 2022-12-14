Extension { #name : #BrTextAdornmentAttribute }

{ #category : #'*Brick' }
BrTextAdornmentAttribute >> beLazy [
	self renderingStrategy: BrTextAdornmentAttributeTaskItRenderingStrategy new.
]
