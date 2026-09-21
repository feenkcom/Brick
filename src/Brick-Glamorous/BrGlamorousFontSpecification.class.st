"
I describe one font face that Glamorous Toolkit bundles: its family name, weight, style and stretch, together with the file it is loaded from.

I am the single source of truth for the bundled fonts. Each {{gtClass:BrGlamorousFonts}} class method tagged with the {{gtSymbol:glamorousFont}} pragma answers one of me, and {{gtMethod:BrGlamorousFonts class>>#fontSpecifications}} collects them all.

I deliberately do not hold font bytes. `bytes` delegte to  {{gtMethod:BrGlamorousFonts class>>#fontNamed:fromFolderNamed:}}, which memoizes the file contents, so building all of me stays cheap and reading a file happens at most once per image.

I keep the style as one of the symbols {{gtSymbol:styleNormal}}, {{gtSymbol:styleItalic}} or {{gtSymbol:styleOblique}}. Those symbols are deliberately the selectors understood by a Sparta font face builder, so {{gtMethod:BrGlamorousFontSpecification>>#installOn:}} can simply perform the symbol.
"
Class {
	#name : #BrGlamorousFontSpecification,
	#superclass : #Object,
	#instVars : [
		'familyName',
		'weight',
		'style',
		'stretch',
		'fileName',
		'folderName'
	],
	#category : #'Brick-Glamorous-Colors, Icons, Fonts'
}

{ #category : #accessing }
BrGlamorousFontSpecification >> bytes [
	"Answer the raw contents of the font file.
	I deliberately do not hold the bytes myself: BrGlamorousFonts memoizes file contents,
	so each file is read from disk at most once per image no matter how often I am built."
	<return: #ByteArray>
	^ BrGlamorousFonts fontNamed: fileName fromFolderNamed: folderName
]

{ #category : #converting }
BrGlamorousFontSpecification >> emphasisCode [
	"Answer the font emphasis as the discriminant the Rust editor's font registry expects:
	0 normal, 1 italic, 2 oblique. These are the same values as SpartaFontSlant uses."
	<return: #Number>
	^ style = #styleItalic
		ifTrue: [ 1 ]
		ifFalse: [ style = #styleOblique
			ifTrue: [ 2 ]
			ifFalse: [ 0 ] ]
]

{ #category : #accessing }
BrGlamorousFontSpecification >> familyName [
	"Answer the font family name, e.g. 'Source Code Pro'."
	<return: #String>
	^ familyName
]

{ #category : #accessing }
BrGlamorousFontSpecification >> familyName: aString [
	familyName := aString
]

{ #category : #accessing }
BrGlamorousFontSpecification >> fileName [
	"Answer the name of the font file, e.g. 'Source Code Pro regular.ttf'."
	<return: #String>
	^ fileName
]

{ #category : #accessing }
BrGlamorousFontSpecification >> fileName: aString [
	fileName := aString
]

{ #category : #accessing }
BrGlamorousFontSpecification >> folderName [
	"Answer the name of the folder holding the font file, e.g. 'Source_Code_Pro'."
	<return: #String>
	^ folderName
]

{ #category : #accessing }
BrGlamorousFontSpecification >> folderName: aString [
	folderName := aString
]

{ #category : #initialization }
BrGlamorousFontSpecification >> initialize [
	super initialize.
	weight := 400.
	style := #styleNormal.
	stretch := #stretchNormal
]

{ #category : #installing }
BrGlamorousFontSpecification >> installOn: aCanvas [
	"Register the font face I describe on aCanvas, which is how Bloc resolves family names.
	Note that style and stretch are kept as the builder's own selectors, so they are simply performed."
	aCanvas fontFace
		familyName: familyName;
		perform: stretch;
		perform: style;
		weight: weight;
		source: self bytes;
		build
]

{ #category : #testing }
BrGlamorousFontSpecification >> isItalic [
	<return: #Boolean>
	^ style = #styleItalic
]

{ #category : #printing }
BrGlamorousFontSpecification >> printOn: aStream [
	aStream
		nextPutAll: familyName asString;
		nextPutAll: ' ';
		print: weight.
	style = #styleNormal ifFalse: [
		aStream nextPutAll: ' '; nextPutAll: (style asString allButFirst: 5) asLowercase ].
	stretch = #stretchNormal ifFalse: [
		aStream nextPutAll: ' '; nextPutAll: (stretch asString allButFirst: 5) asLowercase ]
]

{ #category : #accessing }
BrGlamorousFontSpecification >> stretch [
	"Answer the stretch as a Sparta font face builder selector, e.g. #stretchNormal."
	<return: #Symbol>
	^ stretch
]

{ #category : #'accessing - style' }
BrGlamorousFontSpecification >> stretchNormal [
	stretch := #stretchNormal
]

{ #category : #accessing }
BrGlamorousFontSpecification >> style [
	"Answer the style as one of #styleNormal, #styleItalic or #styleOblique.
	Those symbols are the selectors understood by a Sparta font face builder."
	<return: #Symbol>
	^ style
]

{ #category : #'accessing - style' }
BrGlamorousFontSpecification >> styleItalic [
	style := #styleItalic
]

{ #category : #'accessing - style' }
BrGlamorousFontSpecification >> styleNormal [
	style := #styleNormal
]

{ #category : #'accessing - style' }
BrGlamorousFontSpecification >> styleOblique [
	style := #styleOblique
]

{ #category : #accessing }
BrGlamorousFontSpecification >> weight [
	"Answer the numeric font weight, e.g. 400 for regular or 700 for bold."
	<return: #Number>
	^ weight
]

{ #category : #accessing }
BrGlamorousFontSpecification >> weight: aNumber [
	weight := aNumber
]
