Class {
	#name : #BrGlamorousSpaceTabGroupAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Tabs - Space'
}

{ #category : #initialization }
BrGlamorousSpaceTabGroupAptitude >> createTabDropHandler [
	^ BlDropHandler new
		acceptOnlyFromThisElement;
		whenDragOverDo: [ :anItemsDraggedOverEvent | 
			| container locationElement position |
			container := anItemsDraggedOverEvent currentTarget.
			locationElement := container
					childWithId: #'drop-area--drop-location'
					ifFound: [ :anElement | anElement ]
					ifNone: [ | anElement |
						anElement := BlElement new
								background: container theme default primaryBorderColor;
								width: 2;
								elevation: (BlRelativeElevation elevation: 100);
								constraintsDo: [ :c | 
									c ignoreByLayout.
									c vertical matchParent ].
						container addChild: anElement as: #'drop-area--drop-location'.
						anElement ].
			position := anItemsDraggedOverEvent position x.
			self
				dragOverTo: position
				in: container
				withMarker: locationElement ];
		whenDragLeftDo: [ :anItemsLeftEvent | anItemsLeftEvent currentTarget removeChildNamed: #'drop-area--drop-location' ];
		whenHorizontalDroppedDo: [ :anItemsDroppedEvent :anIndex | 
			self
				dropTabs: (anItemsDroppedEvent items
						collect: [ :eachDragItem | eachDragItem sourceElement ])
				at: anIndex ]
]

{ #category : #initialization }
BrGlamorousSpaceTabGroupAptitude >> dragOverTo: aHorizontalPosition in: aContainerElement withMarker: aMarkerElement [
	"Relocate a marker to a possible tab drop position.
	It is not allowed to drop a tab in front of the `home` tab at position 1"
	| childPosition childBefore |

	childBefore := aContainerElement children accountedByLayout
		detect: [ :eachChild | aHorizontalPosition < eachChild bounds inParent center x ]
		ifFound: [ :eachChild | eachChild ]
		ifNone: [ nil ].

	self widgetDo: [ :aTabGroup | (childBefore notNil and: [ (aTabGroup tabIndexOf: childBefore) = 1 ])
		ifTrue: [
			aMarkerElement visibility: BlVisibility gone.
			^ self ] ].

	childPosition := childBefore
			ifNotNil: [ :eachChild | eachChild bounds inParent left - 1 ]
			ifNil: [ aContainerElement children accountedByLayout last bounds inParent right - 1 ].

	aMarkerElement
		visibility: BlVisibility visible;
		relocate: childPosition @ 0
]

{ #category : #initialization }
BrGlamorousSpaceTabGroupAptitude >> dropTabs: aCollectionOfTabs at: anIndex [
	anIndex = 0
		ifTrue: [ ^ self ].

	self
		widgetDo: [ :aTabGroup |
			| targetTabIndex |

			targetTabIndex := anIndex.
			aCollectionOfTabs do: [ :eachTab | aTabGroup moveTab: eachTab atCursor: targetTabIndex ].
			aCollectionOfTabs ifNotEmpty: [ :theTabs | theTabs first select ] ]
]

{ #category : #initialization }
BrGlamorousSpaceTabGroupAptitude >> initialize [
	super initialize.

	self add: (BrGlamorousTabGroupHeaderAptitude new
		headerDo: [ :e | e padding: ((BlInsets all: 10) withBottom: 0) ];
		tabbarDo: [ :e | e addEventHandler: self createTabDropHandler ]).
	self add: BrTabGroupContentAptitude new.

	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout vertical ]
]
