"
I exemplify `BrGlamorousFontSpecification` and `BrGlamorousFonts class>>#fontSpecifications`.

My most important example is `expectedFontFaces`, which pins the complete list of bundled font faces. That list was derived mechanically from `initializeSourceCodeProOn:` and `initializeSourceSansProOn:` before those methods were replaced by the `<glamorousFont>` pragma, so it records exactly the faces Glamorous Toolkit registered before the refactoring.
"
Class {
	#name : #BrGlamorousFontSpecificationExamples,
	#superclass : #Object,
	#category : #'Brick-Glamorous-Colors, Icons, Fonts'
}

{ #category : #examples }
BrGlamorousFontSpecificationExamples >> emphasisCodesFollowTheSpartaSlantValues [
	"The emphasis code handed to the Rust editor's font registry uses the same discriminants as
	SpartaFontSlant: 0 normal, 1 italic, 2 oblique."
	<gtExample>
	<return: #Array>
	| specifications |
	specifications := self fontSpecifications.
	specifications do: [ :each |
		self
			assert: each emphasisCode
			equals: (each isItalic
				ifTrue: [ SpartaFontSlant italic value ]
				ifFalse: [ SpartaFontSlant normal value ]) ].
	self
		assert: (specifications collect: [ :each | each emphasisCode ]) asSet asSortedCollection asArray
		equals: #(0 1).
	^ specifications
]

{ #category : #examples }
BrGlamorousFontSpecificationExamples >> everySpecificationHasReadableBytes [
	"Each specification names a font file that exists and has content. The bytes are not held by
	the specification: they are fetched through BrGlamorousFonts, which memoizes them."
	<gtExample>
	<return: #Array>
	| specifications |
	specifications := self fontSpecifications.
	specifications do: [ :each |
		self
			assert: (BrGlamorousFonts fontsFolder / each folderName / each fileName) exists
			description: [ 'Missing font file: ' , each fileName ].
		self
			assert: each bytes notEmpty
			description: [ 'Empty font file: ' , each fileName ] ].
	self
		assert: (specifications collect: [ :each | each fileName ]) asSet size
		equals: specifications size.
	^ specifications
]

{ #category : #'examples - data' }
BrGlamorousFontSpecificationExamples >> expectedFontFaces [
	"Answer every font face Glamorous Toolkit bundles, as {familyName. weight. style. fileName}.
	This list was derived mechanically from the abstract syntax trees of the former
	initializeSourceCodeProOn: and initializeSourceSansProOn: methods, before they were replaced
	by the <glamorousFont> pragma. It is therefore a record of the behaviour that existed before
	the refactoring, and exists so that any later change to the bundled fonts is a deliberate
	edit here rather than an accident."
	<gtExample>
	<return: #Array>
	| faces |
	faces := {
		{'Source Code Pro'. 400. #styleNormal. 'Source Code Pro regular.ttf'}.
		{'Source Code Pro'. 400. #styleItalic. 'Source Code Pro italic.ttf'}.
		{'Source Code Pro'. 200. #styleNormal. 'Source Code Pro 200.ttf'}.
		{'Source Code Pro'. 200. #styleItalic. 'Source Code Pro 200italic.ttf'}.
		{'Source Code Pro'. 300. #styleNormal. 'Source Code Pro 300.ttf'}.
		{'Source Code Pro'. 300. #styleItalic. 'Source Code Pro 300italic.ttf'}.
		{'Source Code Pro'. 500. #styleNormal. 'Source Code Pro 500.ttf'}.
		{'Source Code Pro'. 500. #styleItalic. 'Source Code Pro 500italic.ttf'}.
		{'Source Code Pro'. 600. #styleNormal. 'Source Code Pro 600.ttf'}.
		{'Source Code Pro'. 600. #styleItalic. 'Source Code Pro 600italic.ttf'}.
		{'Source Code Pro'. 700. #styleNormal. 'Source Code Pro 700.ttf'}.
		{'Source Code Pro'. 700. #styleItalic. 'Source Code Pro 700italic.ttf'}.
		{'Source Code Pro'. 900. #styleNormal. 'Source Code Pro 900.ttf'}.
		{'Source Code Pro'. 900. #styleItalic. 'Source Code Pro 900italic.ttf'}.
		{'Source Sans Pro'. 400. #styleNormal. 'Source Sans Pro regular.ttf'}.
		{'Source Sans Pro'. 400. #styleItalic. 'Source Sans Pro italic.ttf'}.
		{'Source Sans Pro'. 200. #styleNormal. 'Source Sans Pro 200.ttf'}.
		{'Source Sans Pro'. 200. #styleItalic. 'Source Sans Pro 200italic.ttf'}.
		{'Source Sans Pro'. 300. #styleNormal. 'Source Sans Pro 300.ttf'}.
		{'Source Sans Pro'. 300. #styleItalic. 'Source Sans Pro 300italic.ttf'}.
		{'Source Sans Pro'. 600. #styleNormal. 'Source Sans Pro 600.ttf'}.
		{'Source Sans Pro'. 600. #styleItalic. 'Source Sans Pro 600italic.ttf'}.
		{'Source Sans Pro'. 700. #styleNormal. 'Source Sans Pro 700.ttf'}.
		{'Source Sans Pro'. 700. #styleItalic. 'Source Sans Pro 700italic.ttf'}.
		{'Source Sans Pro'. 900. #styleNormal. 'Source Sans Pro 900.ttf'}.
		{'Source Sans Pro'. 900. #styleItalic. 'Source Sans Pro 900italic.ttf'} }.
	self assert: faces size equals: 26.
	^ faces
]

{ #category : #examples }
BrGlamorousFontSpecificationExamples >> fontSpecifications [
	"Every method tagged <glamorousFont> contributes exactly one specification."
	<gtExample>
	<return: #Array>
	| specifications |
	specifications := BrGlamorousFonts fontSpecifications.
	self assert: specifications size equals: self expectedFontFaces size.
	self
		assert: (specifications allSatisfy: [ :each | each isKindOf: BrGlamorousFontSpecification ]).
	^ specifications
]

{ #category : #examples }
BrGlamorousFontSpecificationExamples >> fontSpecificationsMatchTheExpectedFontFaces [
	"The specifications collected through the pragma describe exactly the faces that were
	registered before the refactoring - no face gained, lost or altered."
	<gtExample>
	<return: #Array>
	| specifications actual expected |
	specifications := self fontSpecifications.
	actual := (specifications
		collect: [ :each | { each familyName. each weight. each style. each fileName } ]) asSet.
	expected := self expectedFontFaces asSet.
	self
		assert: (expected difference: actual) isEmpty
		description: [ 'Font faces that are expected but no longer produced: '
			, (expected difference: actual) printString ].
	self
		assert: (actual difference: expected) isEmpty
		description: [ 'Font faces that are produced but not expected: '
			, (actual difference: expected) printString ].
	^ specifications
]

{ #category : #examples }
BrGlamorousFontSpecificationExamples >> installingOnACanvasRegistersEveryFace [
	"Installing the specifications registers every face so that Sparta can match it by family,
	weight, stretch and slant. Safe to re-run: the registry is a Set, so installing twice does
	not duplicate anything."
	<gtExample>
	<return: #Array>
	| specifications canvas registry |
	specifications := self fontSpecifications.
	canvas := Bloc preferableSpartaCanvas offscreen.
	specifications do: [ :each | each installOn: canvas ].
	registry := SpartaUserFonts default.
	specifications do: [ :each |
		registry
			matchFamilyName: each familyName
			weight: (SpartaFontWeight fromNumber: each weight)
			stretch: SpartaFontStretch normal
			slant: (each isItalic
				ifTrue: [ SpartaFontSlant italic ]
				ifFalse: [ SpartaFontSlant normal ])
			ifFound: [ :aFace | aFace ]
			ifNone: [ self assert: false description: [ 'Face was not registered: ' , each printString ] ] ].
	^ specifications
]
