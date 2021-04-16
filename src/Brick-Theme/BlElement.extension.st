Extension { #name : #BlElement }

{ #category : #'*Brick-Theme' }
BlElement >> theme [
	^ self userData at: #brickTheme ifAbsent: [ BrTheme default ]
]

{ #category : #'*Brick-Theme' }
BlElement >> theme: aTheme [
	"self themeStrategy: (BrThemeExplicitStrategy theme: aTheme)"

	self properties
		addProperty:
			(BrThemeElementProperty new
				theme: aTheme;
				yourself)
]

{ #category : #'*Brick-Theme' }
BlElement >> theme: aSymbol with: anotherSymbol [
	self themedProperties at: aSymbol put: anotherSymbol
]

{ #category : #'*Brick-Theme' }
BlElement >> themedProperties [
	^ self userData
		at: #brickThemedProperties
		ifAbsentPut: [ Dictionary new ]
]
