Extension { #name : #TBlTextStyleable }

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> appendingAdornment: aBrTextAdornmentStencilBuilder [
	"Append a visual element defined by a given stencil builder right after a text on which I am applied.
	A stencil builder can also be a block in the following form:
	[ :aTBrTextEditorTextualPiece :anEditorElement | ] - where aText represents a piece of text after which an element should be append"

	self attributesBuilder attribute: (BrTextAdornmentDynamicAttribute new
		beAppend;
		stencil: aBrTextAdornmentStencilBuilder) from: 1 to: self size
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> appendingText: aTextOrString [
	self attributesBuilder attribute: (BrTextAdornmentTextAttribute new
		beAppend;
		text: aTextOrString asRopedText)
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> hideMarkupLeft: amountOfCharactersToHideLeft right: amountOfCharactersToHideRight [
	| hideAttributeLeft hideAttributeRight |

	hideAttributeLeft := BrTextAdornmentTextAttribute new
			beReplace;
			text: '' asRopedText.

	hideAttributeRight := BrTextAdornmentTextAttribute new
			beReplace;
			text: '' asRopedText.
			
	(self from: 1 to: amountOfCharactersToHideLeft)
		attribute: hideAttributeLeft.
		
	(self from: (self size - amountOfCharactersToHideRight + 1) to: self size)
		attribute: hideAttributeRight.

	self attributesBuilder
		attribute:
			(BrTextCursorStylableAttribute new
				preserveCursorEnterOnSelection;
				removeAttributeOverSelfOnEnter: hideAttributeLeft;
				removeAttributeOverSelfOnEnter: hideAttributeRight;
				addAttributeOverSelfOnLeave: hideAttributeLeft firstCharacters: 2;
				addAttributeOverSelfOnLeave: hideAttributeRight lastCharacters: 2)
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> hideText [
	"Visually replace a piece of text with a repeating aCharacter"

	self attributesBuilder attribute: BrTextHideAttribute new
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> lineSpacing: aNumber [
	self attributesBuilder attribute: (BrTextParagraphLineSpacingAttribute lineSpacing: aNumber)
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> onClick: aClickAction [
	"Perform actions when a user clicks on a piece of text.
	The click action is a block in the following form: [ :aTBrTextEditorTextualPiece :aWorldElement :anEditorElement :anEvent | ]"

	self attributesBuilder attribute: (BrTextClickAttribute new action: aClickAction)
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> onCursorEnter: anEnterAction leave: aLeaveAction [
	"Perform actions when a cursor enters and leaves a piece of text.
	The enter action is a block in the following form: [ :aTextEditor :aBrTextEditorCursorAddedEvent :anAttributeStart :anAttributeEnd | ]
	The leave action is a block in the following form: [ :aTextEditor :aBrTextEditorCursorRemovedEvent :anAttributeStart :anAttributeEnd | ]"

	self attributesBuilder attribute: (BrTextCursorDynamicAttribute new
			enterAction: anEnterAction;
			leaveAction: aLeaveAction)
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> overlayingAdornment: aBrTextAdornmentStencilBuilder [
	"Visually replace a piece of text with an element defined by a given stencil builder.
	A stencil builder can also be a block in the following form:
	[ :aTBrTextEditorTextualPiece :anEditorElement | ] - where aText represents a piece of text that should be replaced"

	self attributesBuilder attribute: (BrTextAdornmentDynamicAttribute new
		beOverlay;
		stencil: aBrTextAdornmentStencilBuilder)
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> paragraphMargin: anInsets [
	self attributesBuilder attribute: (BrTextParagraphMarginAttribute paragraphMargin: anInsets)
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> previewAsText: aText [
	| hideAttribute |
	hideAttribute := BrTextAdornmentTextAttribute new
			beReplace;
			text: '' asRopedText.

	self attributesBuilder
		attributes: {
				hideAttribute.
				BrTextAdornmentTextAttribute new
					beAppend;
					text: aText asRopedText.
				BrTextCursorStylableAttribute new
					preserveCursorEnterOnSelection;
					addAttributeOverSelfOnLeave: hideAttribute;
					removeAttributeOverSelfOnEnter: hideAttribute }
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> replacingAdornment: aBrTextAdornmentStencilBuilder [
	"Visually replace a piece of text with an element defined by a given stencil builder.
	A stencil builder can also be a block in the following form:
	[ :aTBrTextEditorTextualPiece :anEditorElement | ] - where aText represents a piece of text that should be replaced"

	self attributesBuilder attribute: (BrTextAdornmentDynamicAttribute new
		beReplace;
		stencil: aBrTextAdornmentStencilBuilder)
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> replacingText: aTextOrString [
	self attributesBuilder attribute: (BrTextAdornmentTextAttribute new
		beReplace;
		text: aTextOrString asRopedText)
]

{ #category : #'*Brick-Editor' }
TBlTextStyleable >> wordPadding: anInsets [
	self attributesBuilder attribute: (BrTextParagraphWordPaddingAttribute wordPadding: anInsets)
]
