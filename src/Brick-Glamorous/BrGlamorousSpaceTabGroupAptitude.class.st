Class {
	#name : #BrGlamorousSpaceTabGroupAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Tabs - Space'
}

{ #category : #initialization }
BrGlamorousSpaceTabGroupAptitude >> createTabDropEventHandler [
	^ (BlDropHandler new
		acceptOnlyFromThisElement;
		whenDragOverDo: [ :anItemsDraggedOverEvent |
			| container locationElement position childPosition |

			container := anItemsDraggedOverEvent currentTarget.
			locationElement := container
				childWithId: #'drop-area--drop-location'
				ifFound: [ :anElement | anElement ]
				ifNone: [
					| anElement |

					anElement := BlElement new
						background: Color orange;
						width: 2;
						constraintsDo: [ :c |
							c ignoreByLayout.
							c vertical matchParent ].

					container addChild: anElement as: #'drop-area--drop-location'.
					anElement ].

			position := anItemsDraggedOverEvent position x.
			childPosition := container children accountedByLayout
				detect: [ :eachChild | position < eachChild bounds inParent center x ] 
				ifFound: [ :eachChild | eachChild bounds inParent left - 10 ]
				ifNone: [ container children accountedByLayout last bounds inParent right + 10 ].

			locationElement relocate: childPosition @ 0 ];

		whenDragLeftDo: [ :anItemsLeftEvent | anItemsLeftEvent currentTarget removeChildNamed: #'drop-area--drop-location' ];
		whenHorizontalDroppedDo: [ :anItemsDroppedEvent :anIndex |  ])
]

{ #category : #initialization }
BrGlamorousSpaceTabGroupAptitude >> initialize [
	super initialize.

	self add: (BrGlamorousTabGroupHeaderAptitude new
		headerDo: [ :e | e padding: ((BlInsets all: 10) withBottom: 0) ];
		tabbarDo: [ :e | e addEventHandler: self createTabDropEventHandler ]).
	self add: BrTabGroupContentAptitude new.

	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout vertical ].

	self
		addChange:
			(BrLookChange new
				up: [ :e | 
					self
						widgetDo:
							[ :aWidget | aWidget background: self theme header defaultBackgroundColor ] ];
				down: [ :e |  ];
				yourself)
]
