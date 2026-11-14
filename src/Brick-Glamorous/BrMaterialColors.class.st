"
I provide the Material Design 2 color palettes.
https://m2.material.io/design/color/the-color-system.html#tools-for-picking-colors
Shade selectors preserve Material names: red50, red500, redA100.
Unnumbered selectors return shade 500. Grey follows the official source spelling.
{{gtClass:BrMaterialColors|show=gtColorsFor:|expanded=true}}

Palette data: https://github.com/material-components/material-components-web/blob/master/packages/mdc-theme/_color-palette.scss

Copyright 2017 Google Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the ""Software""), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ""AS IS"", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
"
Class {
	#name : #BrMaterialColors,
	#superclass : #Object,
	#category : #'Brick-Glamorous-Colors'
}

{ #category : #'colors - primary' }
BrMaterialColors class >> amber [
	^ self amber500
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amber100 [
	^ Color fromHexString: 'FFECB3'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amber200 [
	^ Color fromHexString: 'FFE082'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amber300 [
	^ Color fromHexString: 'FFD54F'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amber400 [
	^ Color fromHexString: 'FFCA28'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amber50 [
	^ Color fromHexString: 'FFF8E1'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amber500 [
	^ Color fromHexString: 'FFC107'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amber600 [
	^ Color fromHexString: 'FFB300'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amber700 [
	^ Color fromHexString: 'FFA000'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amber800 [
	^ Color fromHexString: 'FF8F00'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amber900 [
	^ Color fromHexString: 'FF6F00'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amberA100 [
	^ Color fromHexString: 'FFE57F'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amberA200 [
	^ Color fromHexString: 'FFD740'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amberA400 [
	^ Color fromHexString: 'FFC400'
]

{ #category : #'colors - amber' }
BrMaterialColors class >> amberA700 [
	^ Color fromHexString: 'FFAB00'
]

{ #category : #'colors - neutral' }
BrMaterialColors class >> black [
	^ Color fromHexString: '000000'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> blue [
	^ self blue500
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blue100 [
	^ Color fromHexString: 'BBDEFB'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blue200 [
	^ Color fromHexString: '90CAF9'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blue300 [
	^ Color fromHexString: '64B5F6'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blue400 [
	^ Color fromHexString: '42A5F5'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blue50 [
	^ Color fromHexString: 'E3F2FD'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blue500 [
	^ Color fromHexString: '2196F3'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blue600 [
	^ Color fromHexString: '1E88E5'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blue700 [
	^ Color fromHexString: '1976D2'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blue800 [
	^ Color fromHexString: '1565C0'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blue900 [
	^ Color fromHexString: '0D47A1'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blueA100 [
	^ Color fromHexString: '82B1FF'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blueA200 [
	^ Color fromHexString: '448AFF'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blueA400 [
	^ Color fromHexString: '2979FF'
]

{ #category : #'colors - blue' }
BrMaterialColors class >> blueA700 [
	^ Color fromHexString: '2962FF'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> blueGrey [
	^ self blueGrey500
]

{ #category : #'colors - blue-grey' }
BrMaterialColors class >> blueGrey100 [
	^ Color fromHexString: 'CFD8DC'
]

{ #category : #'colors - blue-grey' }
BrMaterialColors class >> blueGrey200 [
	^ Color fromHexString: 'B0BEC5'
]

{ #category : #'colors - blue-grey' }
BrMaterialColors class >> blueGrey300 [
	^ Color fromHexString: '90A4AE'
]

{ #category : #'colors - blue-grey' }
BrMaterialColors class >> blueGrey400 [
	^ Color fromHexString: '78909C'
]

{ #category : #'colors - blue-grey' }
BrMaterialColors class >> blueGrey50 [
	^ Color fromHexString: 'ECEFF1'
]

{ #category : #'colors - blue-grey' }
BrMaterialColors class >> blueGrey500 [
	^ Color fromHexString: '607D8B'
]

{ #category : #'colors - blue-grey' }
BrMaterialColors class >> blueGrey600 [
	^ Color fromHexString: '546E7A'
]

{ #category : #'colors - blue-grey' }
BrMaterialColors class >> blueGrey700 [
	^ Color fromHexString: '455A64'
]

{ #category : #'colors - blue-grey' }
BrMaterialColors class >> blueGrey800 [
	^ Color fromHexString: '37474F'
]

{ #category : #'colors - blue-grey' }
BrMaterialColors class >> blueGrey900 [
	^ Color fromHexString: '263238'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> brown [
	^ self brown500
]

{ #category : #'colors - brown' }
BrMaterialColors class >> brown100 [
	^ Color fromHexString: 'D7CCC8'
]

{ #category : #'colors - brown' }
BrMaterialColors class >> brown200 [
	^ Color fromHexString: 'BCAAA4'
]

{ #category : #'colors - brown' }
BrMaterialColors class >> brown300 [
	^ Color fromHexString: 'A1887F'
]

{ #category : #'colors - brown' }
BrMaterialColors class >> brown400 [
	^ Color fromHexString: '8D6E63'
]

{ #category : #'colors - brown' }
BrMaterialColors class >> brown50 [
	^ Color fromHexString: 'EFEBE9'
]

{ #category : #'colors - brown' }
BrMaterialColors class >> brown500 [
	^ Color fromHexString: '795548'
]

{ #category : #'colors - brown' }
BrMaterialColors class >> brown600 [
	^ Color fromHexString: '6D4C41'
]

{ #category : #'colors - brown' }
BrMaterialColors class >> brown700 [
	^ Color fromHexString: '5D4037'
]

{ #category : #'colors - brown' }
BrMaterialColors class >> brown800 [
	^ Color fromHexString: '4E342E'
]

{ #category : #'colors - brown' }
BrMaterialColors class >> brown900 [
	^ Color fromHexString: '3E2723'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> cyan [
	^ self cyan500
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyan100 [
	^ Color fromHexString: 'B2EBF2'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyan200 [
	^ Color fromHexString: '80DEEA'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyan300 [
	^ Color fromHexString: '4DD0E1'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyan400 [
	^ Color fromHexString: '26C6DA'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyan50 [
	^ Color fromHexString: 'E0F7FA'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyan500 [
	^ Color fromHexString: '00BCD4'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyan600 [
	^ Color fromHexString: '00ACC1'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyan700 [
	^ Color fromHexString: '0097A7'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyan800 [
	^ Color fromHexString: '00838F'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyan900 [
	^ Color fromHexString: '006064'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyanA100 [
	^ Color fromHexString: '84FFFF'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyanA200 [
	^ Color fromHexString: '18FFFF'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyanA400 [
	^ Color fromHexString: '00E5FF'
]

{ #category : #'colors - cyan' }
BrMaterialColors class >> cyanA700 [
	^ Color fromHexString: '00B8D4'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> deepOrange [
	^ self deepOrange500
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrange100 [
	^ Color fromHexString: 'FFCCBC'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrange200 [
	^ Color fromHexString: 'FFAB91'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrange300 [
	^ Color fromHexString: 'FF8A65'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrange400 [
	^ Color fromHexString: 'FF7043'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrange50 [
	^ Color fromHexString: 'FBE9E7'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrange500 [
	^ Color fromHexString: 'FF5722'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrange600 [
	^ Color fromHexString: 'F4511E'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrange700 [
	^ Color fromHexString: 'E64A19'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrange800 [
	^ Color fromHexString: 'D84315'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrange900 [
	^ Color fromHexString: 'BF360C'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrangeA100 [
	^ Color fromHexString: 'FF9E80'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrangeA200 [
	^ Color fromHexString: 'FF6E40'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrangeA400 [
	^ Color fromHexString: 'FF3D00'
]

{ #category : #'colors - deep-orange' }
BrMaterialColors class >> deepOrangeA700 [
	^ Color fromHexString: 'DD2C00'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> deepPurple [
	^ self deepPurple500
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurple100 [
	^ Color fromHexString: 'D1C4E9'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurple200 [
	^ Color fromHexString: 'B39DDB'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurple300 [
	^ Color fromHexString: '9575CD'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurple400 [
	^ Color fromHexString: '7E57C2'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurple50 [
	^ Color fromHexString: 'EDE7F6'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurple500 [
	^ Color fromHexString: '673AB7'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurple600 [
	^ Color fromHexString: '5E35B1'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurple700 [
	^ Color fromHexString: '512DA8'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurple800 [
	^ Color fromHexString: '4527A0'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurple900 [
	^ Color fromHexString: '311B92'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurpleA100 [
	^ Color fromHexString: 'B388FF'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurpleA200 [
	^ Color fromHexString: '7C4DFF'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurpleA400 [
	^ Color fromHexString: '651FFF'
]

{ #category : #'colors - deep-purple' }
BrMaterialColors class >> deepPurpleA700 [
	^ Color fromHexString: '6200EA'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> green [
	^ self green500
]

{ #category : #'colors - green' }
BrMaterialColors class >> green100 [
	^ Color fromHexString: 'C8E6C9'
]

{ #category : #'colors - green' }
BrMaterialColors class >> green200 [
	^ Color fromHexString: 'A5D6A7'
]

{ #category : #'colors - green' }
BrMaterialColors class >> green300 [
	^ Color fromHexString: '81C784'
]

{ #category : #'colors - green' }
BrMaterialColors class >> green400 [
	^ Color fromHexString: '66BB6A'
]

{ #category : #'colors - green' }
BrMaterialColors class >> green50 [
	^ Color fromHexString: 'E8F5E9'
]

{ #category : #'colors - green' }
BrMaterialColors class >> green500 [
	^ Color fromHexString: '4CAF50'
]

{ #category : #'colors - green' }
BrMaterialColors class >> green600 [
	^ Color fromHexString: '43A047'
]

{ #category : #'colors - green' }
BrMaterialColors class >> green700 [
	^ Color fromHexString: '388E3C'
]

{ #category : #'colors - green' }
BrMaterialColors class >> green800 [
	^ Color fromHexString: '2E7D32'
]

{ #category : #'colors - green' }
BrMaterialColors class >> green900 [
	^ Color fromHexString: '1B5E20'
]

{ #category : #'colors - green' }
BrMaterialColors class >> greenA100 [
	^ Color fromHexString: 'B9F6CA'
]

{ #category : #'colors - green' }
BrMaterialColors class >> greenA200 [
	^ Color fromHexString: '69F0AE'
]

{ #category : #'colors - green' }
BrMaterialColors class >> greenA400 [
	^ Color fromHexString: '00E676'
]

{ #category : #'colors - green' }
BrMaterialColors class >> greenA700 [
	^ Color fromHexString: '00C853'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> grey [
	^ self grey500
]

{ #category : #'colors - grey' }
BrMaterialColors class >> grey100 [
	^ Color fromHexString: 'F5F5F5'
]

{ #category : #'colors - grey' }
BrMaterialColors class >> grey200 [
	^ Color fromHexString: 'EEEEEE'
]

{ #category : #'colors - grey' }
BrMaterialColors class >> grey300 [
	^ Color fromHexString: 'E0E0E0'
]

{ #category : #'colors - grey' }
BrMaterialColors class >> grey400 [
	^ Color fromHexString: 'BDBDBD'
]

{ #category : #'colors - grey' }
BrMaterialColors class >> grey50 [
	^ Color fromHexString: 'FAFAFA'
]

{ #category : #'colors - grey' }
BrMaterialColors class >> grey500 [
	^ Color fromHexString: '9E9E9E'
]

{ #category : #'colors - grey' }
BrMaterialColors class >> grey600 [
	^ Color fromHexString: '757575'
]

{ #category : #'colors - grey' }
BrMaterialColors class >> grey700 [
	^ Color fromHexString: '616161'
]

{ #category : #'colors - grey' }
BrMaterialColors class >> grey800 [
	^ Color fromHexString: '424242'
]

{ #category : #'colors - grey' }
BrMaterialColors class >> grey900 [
	^ Color fromHexString: '212121'
]

{ #category : #'gt - extensions' }
BrMaterialColors class >> gtColorsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Colors';
		priority: 0.5;
		items: [ (self class selectors
				select: [ :each | 
					each numArgs isZero
						and: [ (self class >> each) protocolName beginsWith: 'colors -' ] ])
				sorted ];
		column: 'Icon'
			icon: [ :selector | (self perform: selector) gtInspectorIcon asElement asScalableElement ]
			width: 32;
		column: 'Selector' text: [ :selector | selector asString ];
		column: 'Hex' text: [ :selector | (self perform: selector) asHexString ];
		contextItemLabel: 'Browse method'
			action: [ :anElement :selector | 
				anElement phlow
					spawnTool: (GtMethodCoderTool compiledMethod: self class >> selector) ];
		send: [ :selector | self perform: selector ]
]

{ #category : #'colors - primary' }
BrMaterialColors class >> indigo [
	^ self indigo500
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigo100 [
	^ Color fromHexString: 'C5CAE9'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigo200 [
	^ Color fromHexString: '9FA8DA'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigo300 [
	^ Color fromHexString: '7986CB'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigo400 [
	^ Color fromHexString: '5C6BC0'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigo50 [
	^ Color fromHexString: 'E8EAF6'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigo500 [
	^ Color fromHexString: '3F51B5'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigo600 [
	^ Color fromHexString: '3949AB'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigo700 [
	^ Color fromHexString: '303F9F'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigo800 [
	^ Color fromHexString: '283593'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigo900 [
	^ Color fromHexString: '1A237E'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigoA100 [
	^ Color fromHexString: '8C9EFF'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigoA200 [
	^ Color fromHexString: '536DFE'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigoA400 [
	^ Color fromHexString: '3D5AFE'
]

{ #category : #'colors - indigo' }
BrMaterialColors class >> indigoA700 [
	^ Color fromHexString: '304FFE'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> lightBlue [
	^ self lightBlue500
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlue100 [
	^ Color fromHexString: 'B3E5FC'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlue200 [
	^ Color fromHexString: '81D4FA'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlue300 [
	^ Color fromHexString: '4FC3F7'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlue400 [
	^ Color fromHexString: '29B6F6'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlue50 [
	^ Color fromHexString: 'E1F5FE'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlue500 [
	^ Color fromHexString: '03A9F4'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlue600 [
	^ Color fromHexString: '039BE5'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlue700 [
	^ Color fromHexString: '0288D1'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlue800 [
	^ Color fromHexString: '0277BD'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlue900 [
	^ Color fromHexString: '01579B'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlueA100 [
	^ Color fromHexString: '80D8FF'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlueA200 [
	^ Color fromHexString: '40C4FF'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlueA400 [
	^ Color fromHexString: '00B0FF'
]

{ #category : #'colors - light-blue' }
BrMaterialColors class >> lightBlueA700 [
	^ Color fromHexString: '0091EA'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> lightGreen [
	^ self lightGreen500
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreen100 [
	^ Color fromHexString: 'DCEDC8'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreen200 [
	^ Color fromHexString: 'C5E1A5'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreen300 [
	^ Color fromHexString: 'AED581'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreen400 [
	^ Color fromHexString: '9CCC65'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreen50 [
	^ Color fromHexString: 'F1F8E9'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreen500 [
	^ Color fromHexString: '8BC34A'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreen600 [
	^ Color fromHexString: '7CB342'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreen700 [
	^ Color fromHexString: '689F38'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreen800 [
	^ Color fromHexString: '558B2F'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreen900 [
	^ Color fromHexString: '33691E'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreenA100 [
	^ Color fromHexString: 'CCFF90'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreenA200 [
	^ Color fromHexString: 'B2FF59'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreenA400 [
	^ Color fromHexString: '76FF03'
]

{ #category : #'colors - light-green' }
BrMaterialColors class >> lightGreenA700 [
	^ Color fromHexString: '64DD17'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> lime [
	^ self lime500
]

{ #category : #'colors - lime' }
BrMaterialColors class >> lime100 [
	^ Color fromHexString: 'F0F4C3'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> lime200 [
	^ Color fromHexString: 'E6EE9C'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> lime300 [
	^ Color fromHexString: 'DCE775'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> lime400 [
	^ Color fromHexString: 'D4E157'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> lime50 [
	^ Color fromHexString: 'F9FBE7'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> lime500 [
	^ Color fromHexString: 'CDDC39'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> lime600 [
	^ Color fromHexString: 'C0CA33'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> lime700 [
	^ Color fromHexString: 'AFB42B'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> lime800 [
	^ Color fromHexString: '9E9D24'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> lime900 [
	^ Color fromHexString: '827717'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> limeA100 [
	^ Color fromHexString: 'F4FF81'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> limeA200 [
	^ Color fromHexString: 'EEFF41'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> limeA400 [
	^ Color fromHexString: 'C6FF00'
]

{ #category : #'colors - lime' }
BrMaterialColors class >> limeA700 [
	^ Color fromHexString: 'AEEA00'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> orange [
	^ self orange500
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orange100 [
	^ Color fromHexString: 'FFE0B2'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orange200 [
	^ Color fromHexString: 'FFCC80'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orange300 [
	^ Color fromHexString: 'FFB74D'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orange400 [
	^ Color fromHexString: 'FFA726'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orange50 [
	^ Color fromHexString: 'FFF3E0'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orange500 [
	^ Color fromHexString: 'FF9800'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orange600 [
	^ Color fromHexString: 'FB8C00'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orange700 [
	^ Color fromHexString: 'F57C00'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orange800 [
	^ Color fromHexString: 'EF6C00'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orange900 [
	^ Color fromHexString: 'E65100'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orangeA100 [
	^ Color fromHexString: 'FFD180'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orangeA200 [
	^ Color fromHexString: 'FFAB40'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orangeA400 [
	^ Color fromHexString: 'FF9100'
]

{ #category : #'colors - orange' }
BrMaterialColors class >> orangeA700 [
	^ Color fromHexString: 'FF6D00'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> pink [
	^ self pink500
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pink100 [
	^ Color fromHexString: 'F8BBD0'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pink200 [
	^ Color fromHexString: 'F48FB1'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pink300 [
	^ Color fromHexString: 'F06292'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pink400 [
	^ Color fromHexString: 'EC407A'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pink50 [
	^ Color fromHexString: 'FCE4EC'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pink500 [
	^ Color fromHexString: 'E91E63'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pink600 [
	^ Color fromHexString: 'D81B60'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pink700 [
	^ Color fromHexString: 'C2185B'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pink800 [
	^ Color fromHexString: 'AD1457'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pink900 [
	^ Color fromHexString: '880E4F'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pinkA100 [
	^ Color fromHexString: 'FF80AB'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pinkA200 [
	^ Color fromHexString: 'FF4081'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pinkA400 [
	^ Color fromHexString: 'F50057'
]

{ #category : #'colors - pink' }
BrMaterialColors class >> pinkA700 [
	^ Color fromHexString: 'C51162'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> purple [
	^ self purple500
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purple100 [
	^ Color fromHexString: 'E1BEE7'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purple200 [
	^ Color fromHexString: 'CE93D8'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purple300 [
	^ Color fromHexString: 'BA68C8'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purple400 [
	^ Color fromHexString: 'AB47BC'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purple50 [
	^ Color fromHexString: 'F3E5F5'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purple500 [
	^ Color fromHexString: '9C27B0'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purple600 [
	^ Color fromHexString: '8E24AA'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purple700 [
	^ Color fromHexString: '7B1FA2'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purple800 [
	^ Color fromHexString: '6A1B9A'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purple900 [
	^ Color fromHexString: '4A148C'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purpleA100 [
	^ Color fromHexString: 'EA80FC'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purpleA200 [
	^ Color fromHexString: 'E040FB'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purpleA400 [
	^ Color fromHexString: 'D500F9'
]

{ #category : #'colors - purple' }
BrMaterialColors class >> purpleA700 [
	^ Color fromHexString: 'AA00FF'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> red [
	^ self red500
]

{ #category : #'colors - red' }
BrMaterialColors class >> red100 [
	^ Color fromHexString: 'FFCDD2'
]

{ #category : #'colors - red' }
BrMaterialColors class >> red200 [
	^ Color fromHexString: 'EF9A9A'
]

{ #category : #'colors - red' }
BrMaterialColors class >> red300 [
	^ Color fromHexString: 'E57373'
]

{ #category : #'colors - red' }
BrMaterialColors class >> red400 [
	^ Color fromHexString: 'EF5350'
]

{ #category : #'colors - red' }
BrMaterialColors class >> red50 [
	^ Color fromHexString: 'FFEBEE'
]

{ #category : #'colors - red' }
BrMaterialColors class >> red500 [
	^ Color fromHexString: 'F44336'
]

{ #category : #'colors - red' }
BrMaterialColors class >> red600 [
	^ Color fromHexString: 'E53935'
]

{ #category : #'colors - red' }
BrMaterialColors class >> red700 [
	^ Color fromHexString: 'D32F2F'
]

{ #category : #'colors - red' }
BrMaterialColors class >> red800 [
	^ Color fromHexString: 'C62828'
]

{ #category : #'colors - red' }
BrMaterialColors class >> red900 [
	^ Color fromHexString: 'B71C1C'
]

{ #category : #'colors - red' }
BrMaterialColors class >> redA100 [
	^ Color fromHexString: 'FF8A80'
]

{ #category : #'colors - red' }
BrMaterialColors class >> redA200 [
	^ Color fromHexString: 'FF5252'
]

{ #category : #'colors - red' }
BrMaterialColors class >> redA400 [
	^ Color fromHexString: 'FF1744'
]

{ #category : #'colors - red' }
BrMaterialColors class >> redA700 [
	^ Color fromHexString: 'D50000'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> teal [
	^ self teal500
]

{ #category : #'colors - teal' }
BrMaterialColors class >> teal100 [
	^ Color fromHexString: 'B2DFDB'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> teal200 [
	^ Color fromHexString: '80CBC4'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> teal300 [
	^ Color fromHexString: '4DB6AC'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> teal400 [
	^ Color fromHexString: '26A69A'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> teal50 [
	^ Color fromHexString: 'E0F2F1'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> teal500 [
	^ Color fromHexString: '009688'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> teal600 [
	^ Color fromHexString: '00897B'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> teal700 [
	^ Color fromHexString: '00796B'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> teal800 [
	^ Color fromHexString: '00695C'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> teal900 [
	^ Color fromHexString: '004D40'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> tealA100 [
	^ Color fromHexString: 'A7FFEB'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> tealA200 [
	^ Color fromHexString: '64FFDA'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> tealA400 [
	^ Color fromHexString: '1DE9B6'
]

{ #category : #'colors - teal' }
BrMaterialColors class >> tealA700 [
	^ Color fromHexString: '00BFA5'
]

{ #category : #'colors - neutral' }
BrMaterialColors class >> white [
	^ Color fromHexString: 'FFFFFF'
]

{ #category : #'colors - primary' }
BrMaterialColors class >> yellow [
	^ self yellow500
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellow100 [
	^ Color fromHexString: 'FFF9C4'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellow200 [
	^ Color fromHexString: 'FFF59D'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellow300 [
	^ Color fromHexString: 'FFF176'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellow400 [
	^ Color fromHexString: 'FFEE58'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellow50 [
	^ Color fromHexString: 'FFFDE7'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellow500 [
	^ Color fromHexString: 'FFEB3B'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellow600 [
	^ Color fromHexString: 'FDD835'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellow700 [
	^ Color fromHexString: 'FBC02D'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellow800 [
	^ Color fromHexString: 'F9A825'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellow900 [
	^ Color fromHexString: 'F57F17'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellowA100 [
	^ Color fromHexString: 'FFFF8D'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellowA200 [
	^ Color fromHexString: 'FFFF00'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellowA400 [
	^ Color fromHexString: 'FFEA00'
]

{ #category : #'colors - yellow' }
BrMaterialColors class >> yellowA700 [
	^ Color fromHexString: 'FFD600'
]
