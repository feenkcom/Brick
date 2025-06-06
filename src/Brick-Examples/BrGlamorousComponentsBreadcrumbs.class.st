"
# Breadcrumb
Indicate the current location within a navigational hierarchy that automatically adds separators between items.
#### With labels
{{gtExample:BrGlamorousComponentsBreadcrumbs>>#breadcrumbWithLabels|previewShow=#gtLiveFor:|previewHeight=65|previewExpanded=true|codeExpanded=false}}
#### With buttons
{{gtExample:BrGlamorousComponentsBreadcrumbs>>#breadcrumbWithButtons|previewShow=#gtLiveFor:|previewHeight=65|previewExpanded=true|codeExpanded=false}}
#### Without separator
{{gtExample:BrGlamorousComponentsBreadcrumbs>>#breadcrumbWithoutSeparator|previewShow=#gtLiveFor:|previewHeight=85|previewExpanded=true|codeExpanded=false}}

"
Class {
	#name : #BrGlamorousComponentsBreadcrumbs,
	#superclass : #BrGlamorousComponents,
	#category : #'Brick-Examples-! Glamorous components'
}

{ #category : #breacrumb }
BrGlamorousComponentsBreadcrumbs >> breadcrumbWithButtons [
	<gtExample>
	<return: #BrBreadcrumb>
	^ BrBreadcrumb new
		aptitude: (BrGlamorousBreadcrumbAptitude new
				separator: [ BrLabel new
						aptitude: (BrGlamorousLabelAptitude new thin foreground: Color gray);
						text: '/';
						margin: (BlInsets left: 5 right: 5) ]);
		addItem: (BrButton new
				aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new glamorousRegularFont;
				label: 'Home');
		addItem: (BrButton new
				aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new glamorousRegularFont;
				label: 'Store');
		addItem: (BrButton new
				aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new glamorousRegularFont;
				label: 'T-Shirt')
]

{ #category : #breacrumb }
BrGlamorousComponentsBreadcrumbs >> breadcrumbWithLabels [
	<gtExample>
	<return: #BrBreadcrumb>
	^ BrBreadcrumb new
		aptitude: (BrGlamorousBreadcrumbAptitude new
				separator: [ BrLabel new
						aptitude: (BrGlamorousLabelAptitude new thin foreground: Color gray);
						text: '>';
						margin: (BlInsets left: 5 right: 5) ]);
		addItem: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'Home');
		addItem: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'Store');
		addItem: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'T-Shirt')
]

{ #category : #breacrumb }
BrGlamorousComponentsBreadcrumbs >> breadcrumbWithoutSeparator [
	<gtExample>
	<return: #BrBreadcrumb>
	^ BrBreadcrumb new
		aptitude: BrGlamorousBreadcrumbAptitude;
		addItem: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'Home');
		addItem: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'Store');
		addItem: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'T-Shirt')
]
