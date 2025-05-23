"
# Pager
Use pager to display a horizontally scrollable list of pages.
#### Simple three page pager
The following example displays three predefined pages that occupy all available space within the pager ({{gtMethod:BrPagerPageElement>>#weight:}}is set to `1`). 
{{gtExample:BrGlamorousComponentsPagers>>#threeFullPagePager|previewShow=#gtLiveFor:|previewHeight=250|previewExpanded=true|codeExpanded=false}}
#### Two page pager with custom weight
It is possible, however, to set a different {{gtMethod:BrPagerPageElement>>#weight:}} which will make pages share the space within their pager.
{{gtExample:BrGlamorousComponentsPagers>>#twoHalfPagePager|previewShow=#gtLiveFor:|previewHeight=250|previewExpanded=true|codeExpanded=false}}
#### Dynamically adding a page
If needed, pages can be added dynamically with the same api as we used in the previous examples {{gtMethod:BrPager>>#addPage:}}. However, it is usually required to scroll to a newly created page which can be achieved with the help of the {{gtMethod:BrPager>>#scrollToLast}}method.
{{gtExample:BrGlamorousComponentsPagers>>#dynamicPager|previewShow=#gtLiveFor:|previewHeight=250|previewExpanded=true|codeExpanded=false}}
#### Infinite pager
We can build on the previous example to create an ""infinite"" pager by using a stencil to recursively build new pages:
{{gtExample:BrGlamorousComponentsPagers>>#infinitePager|previewShow=#gtLiveFor:|previewHeight=250|previewExpanded=true|codeExpanded=false}}






"
Class {
	#name : #BrGlamorousComponentsPagers,
	#superclass : #BrGlamorousComponents,
	#category : #'Brick-Examples-! Glamorous components'
}

{ #category : #'pager - examples' }
BrGlamorousComponentsPagers >> dynamicPager [
	<gtExample>
	<return: #BrPager>
	| aPager |
	aPager := BrPager new.
	aPager matchParent.
	aPager
		addPage: (BrPagerPageElement new
				weight: 1.0;
				layout: BlLinearLayout vertical alignCenter;
				background: (Color gray alpha: 0.1);
				addChild: (BrButton new
						beHugeSize;
						aptitude: BrGlamorousButtonWithLabelAptitude new;
						label: 'Next';
						action: [ aPager
								addPage: (BrPagerPageElement new
										layout: BlLinearLayout vertical alignCenter;
										background: (Color random alpha: 0.1);
										weight: 1.0;
										addChild: (BrLabel new
												aptitude: (BrGlamorousLabelAptitude new
														fontSize: 30;
														foreground: Color red);
												text: 'New page')).
							aPager scrollToLast ])).
	^ aPager
]

{ #category : #'pager - examples' }
BrGlamorousComponentsPagers >> infinitePager [
	<gtExample>
	<return: #BrPager>
	| aPager aPageStencil |
	aPager := BrPager new.
	aPager matchParent.
	aPageStencil := nil.
	aPageStencil := [ BrPagerPageElement new
			weight: 1.0;
			layout: BlLinearLayout vertical alignCenter;
			background: (Color random alpha: 0.1);
			addChild: (BrLabel new
					aptitude: (BrGlamorousLabelAptitude new
							fontSize: 30;
							foreground: Color gray);
					margin: (BlInsets all: 30);
					text: ('Page {1}' format: {aPager pages size + 1}));
			addChild: (BrButton new
					aptitude: BrGlamorousButtonWithLabelAptitude new;
					beHugeSize;
					label: 'Next';
					action: [ aPager addPage: aPageStencil asElement.
						aPager scrollToLast ]) ] asStencil.
	aPager addPage: aPageStencil asElement.
	^ aPager
]

{ #category : #'pager - examples' }
BrGlamorousComponentsPagers >> threeFullPagePager [
	<gtExample>
	<return: #BrPager>
	| aPager |
	aPager := BrPager new matchParent.

	aPager
		addPage: (BrPagerPageElement new
				weight: 1.0;
				layout: BlLinearLayout horizontal alignCenter;
				background: (Color gray alpha: 0.1);
				addChild: (BrLabel new
						aptitude: (BrGlamorousLabelAptitude new
								fontSize: 30;
								foreground: Color gray);
						text: 'Page 1')).

	aPager
		addPage: (BrPagerPageElement new
				weight: 1.0;
				layout: BlLinearLayout horizontal alignCenter;
				background: (Color red alpha: 0.1);
				addChild: (BrLabel new
						aptitude: (BrGlamorousLabelAptitude new
								fontSize: 30;
								foreground: Color red);
						text: 'Page 2')).

	aPager
		addPage: (BrPagerPageElement new
				weight: 1.0;
				layout: BlLinearLayout horizontal alignCenter;
				background: (Color blue alpha: 0.1);
				addChild: (BrLabel new
						aptitude: (BrGlamorousLabelAptitude new
								fontSize: 30;
								foreground: Color blue);
						text: 'Page 3')).

	^ aPager
]

{ #category : #'pager - examples' }
BrGlamorousComponentsPagers >> twoHalfPagePager [
	<gtExample>
	<return: #BrPager>
	| aPager |
	aPager := BrPager new matchParent.

	aPager
		addPage: (BrPagerPageElement new
				weight: 0.5;
				layout: BlLinearLayout horizontal alignCenter;
				background: (Color gray alpha: 0.1);
				addChild: (BrLabel new
						aptitude: (BrGlamorousLabelAptitude new
								fontSize: 30;
								foreground: Color gray);
						text: 'Page 1')).

	aPager
		addPage: (BrPagerPageElement new
				weight: 0.5;
				layout: BlLinearLayout horizontal alignCenter;
				background: (Color red alpha: 0.1);
				addChild: (BrLabel new
						aptitude: (BrGlamorousLabelAptitude new
								fontSize: 30;
								foreground: Color red);
						text: 'Page 2')).

	^ aPager
]
