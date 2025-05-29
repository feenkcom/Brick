Class {
	#name : #BrGlamorousThemePreviewElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'container'
	],
	#category : #'Brick-Theme-Tools'
}

{ #category : #'as yet unclassified' }
BrGlamorousThemePreviewElement >> initialize [
	super initialize.

	container := BrHorizontalFlow new
			matchParent;
			padding: (BlInsets all: 10);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
			border: (BlBorder builder dashed
					paint: Color gray;
					build);
			background: BlTheme default default contentBackground.

	self
		matchParent;
		cellSpacing: 10;
		addChildren: {BrHorizontalPane new
					hMatchParent;
					vFitContent;
					addChildren: {BrButton new
								aptitude: BrGlamorousButtonWithLabelAptitude;
								label: 'Dark';
								action: [ container theme: BrGlamorousDarkTheme new ];
								margin: (BlInsets all: 2).
							BrButton new
								aptitude: BrGlamorousButtonWithLabelAptitude;
								label: 'Light';
								action: [ container theme: BrGlamorousLightTheme new ];
								margin: (BlInsets all: 2)}.
				container}
]

{ #category : #'as yet unclassified' }
BrGlamorousThemePreviewElement >> widgets: aCollectionOfElements [
	container removeChildren.
	container addChildren: aCollectionOfElements
]
