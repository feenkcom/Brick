Extension { #name : #BlTextNextBuilder }

{ #category : #'*Brick-Editor' }
BlTextNextBuilder >> appendingAdornment: aBrTextAdornmentStencilBuilder [
	self
		attribute: (BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: aBrTextAdornmentStencilBuilder)
]
