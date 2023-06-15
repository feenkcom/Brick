"
Allows developers to define a style of the resizer for its various orientations
"
Class {
	#name : #BrResizerAptitude,
	#superclass : #BrLazyStyleCommonAptitude,
	#category : #'Brick-Resizer - Aptitude'
}

{ #category : #accessing }
BrResizerAptitude >> bottom: aBlock [	
	self
		when: (BrResizerLocationState location: BrResizerBottomLocation new)
		style: aBlock
]

{ #category : #accessing }
BrResizerAptitude >> horizontal: aBlock [	
	self
		when: ((BrResizerLocationState location: BrResizerLeftLocation new) or: (BrResizerLocationState location: BrResizerRightLocation new))
		style: aBlock
]

{ #category : #accessing }
BrResizerAptitude >> left: aBlock [	
	self
		when: (BrResizerLocationState location: BrResizerLeftLocation new)
		style: aBlock
]

{ #category : #accessing }
BrResizerAptitude >> right: aBlock [	
	self
		when: (BrResizerLocationState location: BrResizerRightLocation new)
		style: aBlock
]

{ #category : #accessing }
BrResizerAptitude >> top: aBlock [	
	self
		when: (BrResizerLocationState location: BrResizerTopLocation new)
		style: aBlock
]

{ #category : #accessing }
BrResizerAptitude >> vertical: aBlock [	
	self
		when: ((BrResizerLocationState location: BrResizerTopLocation new) or: (BrResizerLocationState location: BrResizerBottomLocation new))
		style: aBlock
]
