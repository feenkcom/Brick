Extension { #name : #TBlTextStyleable }

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> expanded: aBoolean adornment: aBrTextAdornmentStencilBuilder [
	"Append a visual element defined by a given stencil builder right after a text on which I am applied.
	A stencil builder can also be a block in the following form:
	[ :aTBrTextEditorTextualPiece :anEditorElement | ] - where aText represents a piece of text after which an element should be append"
	self
		expanded: aBoolean
		adornment: aBrTextAdornmentStencilBuilder
		id: BlElementId noId
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> expanded: aBoolean adornment: aBrTextAdornmentStencilBuilder id: anElementId [
	"Append a visual element defined by a given stencil builder right after a text on which I am applied.
	A stencil builder can also be a block in the following form:
	[ :aTBrTextEditorTextualPiece :anEditorElement | ] - where aText represents a piece of text after which an element should be append"
	| anExpanderAttribute |
	
	anExpanderAttribute := BrGlamorousTriangleExpanderTextAttributeV2 new
		id: anElementId;
		stencil: aBrTextAdornmentStencilBuilder.
	
	self attributesBuilder attribute: anExpanderAttribute.
	
	aBoolean ifTrue: [
		anExpanderAttribute beExpandedByDefault.
		self attributesBuilder attribute: anExpanderAttribute expandedAppendingAttribute ].
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> expandingAdornment: aBrTextAdornmentStencilBuilder [
	"Append a visual element defined by a given stencil builder right after a text on which I am applied.
	A stencil builder can also be a block in the following form:
	[ :aTBrTextEditorTextualPiece :anEditorElement | ] - where aText represents a piece of text after which an element should be append"

	self expanded: false adornment: aBrTextAdornmentStencilBuilder
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> foldableSubTexts: foldableSubTexts [
	"Append a foldable element that can fold (hide) and unfold (show) foldableSubTexts."

	<return: #BrGlamorousFolderTextAttributeV2>
	^ self
		folded: false
		foldableSubTexts: foldableSubTexts
		tooltipText: nil
		id: BlElementId noId
		definingMethod: nil
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> folded: isFolded foldableSubTexts: foldableSubTexts [
	"Append a foldable element that can fold (hide) and unfold (show) foldableSubTexts."

	<return: #BrGlamorousFolderTextAttributeV2>
	^ self
		folded: isFolded
		foldableSubTexts: foldableSubTexts
		tooltipText: nil
		id: BlElementId noId
		definingMethod: nil
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> folded: isFolded foldableSubTexts: foldableSubTexts tooltipText: aTooltipTextOrNil [
	"Append a foldable element that can fold (hide) and unfold (show) foldableSubTexts."

	<return: #BrGlamorousFolderTextAttributeV2>
	^ self
		folded: isFolded
		foldableSubTexts: foldableSubTexts
		tooltipText: aTooltipTextOrNil
		id: BlElementId noId
		definingMethod: nil
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> folded: isFolded foldableSubTexts: foldableSubTexts tooltipText: aTooltipTextOrNil id: anElementId [
	"Append a foldable element that can fold (hide) and unfold (show) foldableSubTexts."

	<return: #BrGlamorousFolderTextAttributeV2>
	^ self
		folded: isFolded
		foldableSubTexts: foldableSubTexts
		tooltipText: aTooltipTextOrNil
		id: anElementId
		definingMethod: nil
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> folded: isFolded foldableSubTexts: foldableSubTexts tooltipText: aTooltipTextOrNil id: anElementId definingMethod: aDefiningMethodOrNil [
	"Append a foldable element that can fold (hide) and unfold (show) foldableSubTexts."

	<return: #BrGlamorousFolderTextAttributeV2>
	| aFoldableMarker aFolderAttribute |
	self
		assert: [ isFolded isBoolean ]
		description: [ 'The isFolded argument must be a boolean value: {1}' format: {isFolded} ].
	foldableSubTexts ifEmpty: [ ^ self ].

	aFolderAttribute := BrGlamorousFolderTextAttributeV2 "GtTextFolderAttribute" new
			tooltipText: aTooltipTextOrNil;
			id: anElementId;
			definingMethod: aDefiningMethodOrNil.

	aFoldableMarker := aFolderAttribute foldableMarkerAttribute.

	self
		assert: [ aFoldableMarker isNotNil ]
		description: [ 'The aFoldableMarker attribute must be a non-nil value: {1}'
				format: {aFoldableMarker} ].

	foldableSubTexts
		do: [ :eachSubText | eachSubText attributes: {aFoldableMarker} ].

	self attributesBuilder attribute: aFolderAttribute.

	isFolded ifTrue: [ 
		aFolderAttribute beFoldedByDefault.
		self attributesBuilder attribute: aFolderAttribute hideReplacableAttribute ].

	^ aFolderAttribute
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousCodeDefaultFont [
	self defaultFontName: 'Source Code Pro'
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousCodeFont [
	self fontName: 'Source Code Pro'
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousCodeFontAndSize [
	self 
		glamorousCodeFont;
		glamorousCodeSize 
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousCodeFontAndSmallSize [
	self 
		glamorousCodeFont;
		glamorousCodeSmallSize
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousCodeFontDo: aBlock [
	| attribute |
	attribute := BlFontFamilyAttribute named: 'Source Code Pro'.
	self attributesBuilder attribute: attribute.
	aBlock value: attribute.
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousCodeMiniSize [
	self fontSize: 8
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousCodeSize [
	self fontSize: 14
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousCodeSizeDo: aBlock [
	| attribute |
	attribute := BlFontSizeAttribute size: 14.
	self attributesBuilder attribute: attribute.
	aBlock value: attribute.
	^ attribute
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousCodeSmallSize [
	self fontSize: 12
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousCodeTinySize [
	self fontSize: 10
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousFormEditorCodeFontAndSize [
	self 
		glamorousCodeFont;
		glamorousCodeTinySize
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousFormLabelStyle [
	self 
		glamorousRegularFont;
		glamorousRegularSmallSize;
		foreground: BrGlamorousColors formLabelTextColor
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousMonospace [
	self glamorousCodeFont
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousMonospaceBackground [
	self glamorousCodeFontAndSmallSize highlight: BrGlamorousColors neutralBackgroundColor
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousRegularDefaultFont [
	self defaultFontName: 'Source Sans Pro'
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousRegularFont [
	self fontName: 'Source Sans Pro'
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousRegularFontAndSize [
	self 
		glamorousRegularFont;
		glamorousRegularSize 
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousRegularSize [
	self fontSize: 14
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousRegularSmallSize [
	self fontSize: 12
]

{ #category : #'*Brick-Glamorous' }
TBlTextStyleable >> glamorousRoundedBackground [
	self attribute: (BrTextEmbellishmentAttribute new roundedBackground: BrGlamorousColors neutralBackgroundColor)
]
