"
## Source Sans Pro 

Script used to load Source Sans Pro fonts in the image from their corresponding ttf files

```
BrGlamorousFonts load: './Source Sans Pro 200.ttf' as: 'sourceSansPro200ExtraLight'.
BrGlamorousFonts load: './Source Sans Pro 200italic.ttf' as: 'sourceSansPro200italicExtraLight'.
BrGlamorousFonts load: './Source Sans Pro 300.ttf' as: 'sourceSansPro300Light'.
BrGlamorousFonts load: './Source Sans Pro 300italic.ttf' as: 'sourceSansPro300italicLight'.
BrGlamorousFonts load: './Source Sans Pro 600.ttf' as: 'sourceSansPro600Semibold'.
BrGlamorousFonts load: './Source Sans Pro 600italic.ttf' as: 'sourceSansPro600italicSemibold'.
BrGlamorousFonts load: './Source Sans Pro 700.ttf' as: 'sourceSansPro700Bold'.
BrGlamorousFonts load: './Source Sans Pro 700italic.ttf' as: 'sourceSansPro700italicBold'.
BrGlamorousFonts load: './Source Sans Pro 900.ttf' as: 'sourceSansPro900Black'.
BrGlamorousFonts load: './Source Sans Pro 900italic.ttf' as: 'sourceSansPro900italicBlack'.
BrGlamorousFonts load: './Source Sans Pro regular.ttf' as: 'sourceSansPro400Regular'.
BrGlamorousFonts load: './Source Sans Pro italic.ttf' as: 'sourceSansPro400Italic'.
```

## Source Code Pro

Script used to load Source Code Pro fonts in the image from their corresponding ttf files

```
BrGlamorousFonts load: './Source Code Pro 200.ttf' as: 'sourceCodePro200ExtraLight'.
BrGlamorousFonts load: './Source Code Pro 200italic.ttf' as: 'sourceCodePro200italicExtraLight'.
BrGlamorousFonts load: './Source Code Pro 300.ttf' as: 'sourceCodePro300Light'.
BrGlamorousFonts load: './Source Code Pro 300italic.ttf' as: 'sourceCodePro300italicLight'.
BrGlamorousFonts load: './Source Code Pro 500.ttf' as: 'sourceCodePro500Medium'.
BrGlamorousFonts load: './Source Code Pro 500italic.ttf' as: 'sourceCodePro500italicMedium'.
BrGlamorousFonts load: './Source Code Pro 600.ttf' as: 'sourceCodePro600Semibold'.
BrGlamorousFonts load: './Source Code Pro 600italic.ttf' as: 'sourceCodePro600italicSemibold'.
BrGlamorousFonts load: './Source Code Pro 700.ttf' as: 'sourceCodePro700Bold'.
BrGlamorousFonts load: './Source Code Pro 700italic.ttf' as: 'sourceCodePro700italicBold'.
BrGlamorousFonts load: './Source Code Pro 900.ttf' as: 'sourceCodePro900Black'.
BrGlamorousFonts load: './Source Code Pro 900italic.ttf' as: 'sourceCodePro900italicBlack'.
BrGlamorousFonts load: './Source Code Pro regular.ttf' as: 'sourceCodeProRegular'.
BrGlamorousFonts load: './Source Code Pro italic.ttf' as: 'sourceCodeProItalic'.
```

"
Class {
	#name : #BrGlamorousFonts,
	#superclass : #Object,
	#classInstVars : [
		'fontsCache'
	],
	#category : #'Brick-Glamorous-Colors, Icons, Fonts'
}

{ #category : #'private - accessing' }
BrGlamorousFonts class >> fontNamed: aFontFileName fromFolderNamed: aFontFolderName [
	fontsCache ifNil: [ fontsCache := Dictionary new ].
	^ fontsCache 
		at: aFontFileName 
		ifAbsentPut: [ (self fontsFolder asFileReference / aFontFolderName / aFontFileName) binaryReadStreamDo: [ :aFileStream | 
				aFileStream contents ] ]
]

{ #category : #accessing }
BrGlamorousFonts class >> fontSpecifications [
	"Answer a specification for every font face that Glamorous Toolkit bundles.
	Each one comes from a method of mine tagged with the <glamorousFont> pragma, which keeps
	a face's description and the file it loads together in a single place, and makes this the
	only list that has to be maintained when a font is added or removed."
	<return: #Array of: #BrGlamorousFontSpecification>
	^ (self class selectors
		select: [ :eachSelector |
			(self class >> eachSelector) pragmas
				anySatisfy: [ :eachPragma | eachPragma selector = #glamorousFont ] ])
		asSortedCollection asArray
			collect: [ :eachSelector | self perform: eachSelector ]
]

{ #category : #'private - accessing' }
BrGlamorousFonts class >> fontsFolder [
	"Determine the fonts folder. Should work both for releaser and in development mode when the repository is present."
	<return: #FileReference>
	^ GtResourcesUtility default resourceAtPath: Path * 'feenkcom' / 'Brick' / 'data' / 'fonts'
]

{ #category : #'private - accessing' }
BrGlamorousFonts class >> fontsSourceCodeProFolderName [
	^ 'Source_Code_Pro'
]

{ #category : #'private - accessing' }
BrGlamorousFonts class >> fontsSourceSansProFolderName [
	^ 'Source_Sans_Pro' 
]

{ #category : #'gt - extensions' }
BrGlamorousFonts class >> gtFontSpecificationsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Custom fonts';
		items: [ self fontSpecifications ];
		column: 'Font' text: #gtDisplayString
]

{ #category : #initialization }
BrGlamorousFonts class >> initialize [
	self startUp: true.

	SessionManager default registerUserClassNamed: self name
]

{ #category : #initialization }
BrGlamorousFonts class >> initializeFonts [
	<script: 'self initializeFonts'>

	[ self initializeFontsOn: Bloc preferableSpartaCanvas offscreen ]
		on: Error
		do: [ :anError |
			NonInteractiveTranscript stderr
				nextPutAll: 'Failed to initialize fonts. ';
				nextPutAll: anError description;
				cr ]
]

{ #category : #initialization }
BrGlamorousFonts class >> initializeFontsOn: aCanvas [

	self fontSpecifications do: [ :each | each installOn: aCanvas ]
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro200ExtraLight [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 200;
		styleNormal;
		stretchNormal;
		fileName: 'Source Code Pro 200.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro200italicExtraLight [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 200;
		styleItalic;
		stretchNormal;
		fileName: 'Source Code Pro 200italic.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro300Light [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 300;
		styleNormal;
		stretchNormal;
		fileName: 'Source Code Pro 300.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro300italicLight [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 300;
		styleItalic;
		stretchNormal;
		fileName: 'Source Code Pro 300italic.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro400Regular [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 400;
		styleNormal;
		stretchNormal;
		fileName: 'Source Code Pro regular.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro400italicRegular [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 400;
		styleItalic;
		stretchNormal;
		fileName: 'Source Code Pro italic.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro500Medium [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 500;
		styleNormal;
		stretchNormal;
		fileName: 'Source Code Pro 500.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro500italicMedium [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 500;
		styleItalic;
		stretchNormal;
		fileName: 'Source Code Pro 500italic.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro600Semibold [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 600;
		styleNormal;
		stretchNormal;
		fileName: 'Source Code Pro 600.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro600italicSemibold [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 600;
		styleItalic;
		stretchNormal;
		fileName: 'Source Code Pro 600italic.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro700Bold [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 700;
		styleNormal;
		stretchNormal;
		fileName: 'Source Code Pro 700.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro700italicBold [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 700;
		styleItalic;
		stretchNormal;
		fileName: 'Source Code Pro 700italic.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro900Black [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 900;
		styleNormal;
		stretchNormal;
		fileName: 'Source Code Pro 900.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source code pro' }
BrGlamorousFonts class >> sourceCodePro900italicBlack [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Code Pro';
		weight: 900;
		styleItalic;
		stretchNormal;
		fileName: 'Source Code Pro 900italic.ttf';
		folderName: self fontsSourceCodeProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro200ExtraLight [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 200;
		styleNormal;
		stretchNormal;
		fileName: 'Source Sans Pro 200.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro200italicExtraLight [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 200;
		styleItalic;
		stretchNormal;
		fileName: 'Source Sans Pro 200italic.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro300Light [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 300;
		styleNormal;
		stretchNormal;
		fileName: 'Source Sans Pro 300.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro300italicLight [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 300;
		styleItalic;
		stretchNormal;
		fileName: 'Source Sans Pro 300italic.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro400Regular [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 400;
		styleNormal;
		stretchNormal;
		fileName: 'Source Sans Pro regular.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro400italicRegular [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 400;
		styleItalic;
		stretchNormal;
		fileName: 'Source Sans Pro italic.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro600Semibold [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 600;
		styleNormal;
		stretchNormal;
		fileName: 'Source Sans Pro 600.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro600italicSemibold [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 600;
		styleItalic;
		stretchNormal;
		fileName: 'Source Sans Pro 600italic.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro700Bold [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 700;
		styleNormal;
		stretchNormal;
		fileName: 'Source Sans Pro 700.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro700italicBold [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 700;
		styleItalic;
		stretchNormal;
		fileName: 'Source Sans Pro 700italic.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro900Black [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 900;
		styleNormal;
		stretchNormal;
		fileName: 'Source Sans Pro 900.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #'fonts - source sans pro' }
BrGlamorousFonts class >> sourceSansPro900italicBlack [
	<glamorousFont>
	^ BrGlamorousFontSpecification new
		familyName: 'Source Sans Pro';
		weight: 900;
		styleItalic;
		stretchNormal;
		fileName: 'Source Sans Pro 900italic.ttf';
		folderName: self fontsSourceSansProFolderName;
		yourself
]

{ #category : #initialization }
BrGlamorousFonts class >> startUp: isImageStarting [
	"Pharo is starting up. If this platform requires specific intialization, this is a great place to put it."
	isImageStarting
		ifTrue: [ self initializeFonts ]
]
