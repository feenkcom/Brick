Extension { #name : #BlTextStream }

{ #category : #'*Brick-Editor' }
BlTextStream >> appendingAdornment: aBrTextAdornmentStencilBuilder [
	self
		attribute: (BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: aBrTextAdornmentStencilBuilder)
]
