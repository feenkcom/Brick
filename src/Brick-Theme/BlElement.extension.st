Extension { #name : #BlElement }

{ #category : #'*Brick-Theme' }
BlElement >> theme [
	^ self userData
		at: #brickTheme
		ifAbsent: [ self hasParent
				ifTrue: [ self parent theme ]
				ifFalse: [ BrTheme default ] ]
]

{ #category : #'*Brick-Theme' }
BlElement >> theme: aTheme [
	self userData at: #brickTheme put: aTheme.
	self properties
		addProperty:
			(BrThemeElementProperty new
				theme: aTheme;
				yourself)
]
