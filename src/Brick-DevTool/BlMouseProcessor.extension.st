Extension { #name : #BlMouseProcessor }

{ #category : #'*Brick-DevTool' }
BlMouseProcessor >> gtLastClickEventTargetsFor: aView [
	<gtView>
	
	lastClickEvent ifNil: [ ^ aView empty ].
	
	^ aView columnedTree
		title: 'Last Click Event Targets';
		priority: 15;
		items: [ lastClickEvent
				ifNotNil: [ :anEvent | 
					| aPickedElement |
					aPickedElement := self processPicking: anEvent.
					aPickedElement withAllParents reversed ]
				ifNil: [ #() ] ];
		children: #children;
		column: 'Name' text: #yourself;
		column: 'Target'
			text: [ :anElement | 
				| anEvent |
				anEvent := lastClickEvent.
				anEvent
					ifNotNil: [ (anElement findMouseEventTargetAt: anEvent position)
							ifNil: [ 'nil' asRopedText foreground: BrGlamorousColors failureBackgroundColor ]
							ifNotNil: [ :aPickedElement | 
								aPickedElement == anElement
									ifTrue: [ 'itself' asRopedText foreground: BrGlamorousColors successBackgroundColor ]
									ifFalse: [ 'child' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ] ]
					ifNil: [ '' ] ]
			width: 60;
		column: 'Contains Point'
			text: [ :anElement | 
				lastClickEvent
					ifNotNil: [ :anEvent | 
						(anElement containsGlobalPoint: anEvent position)
							ifFalse: [ (anElement bounds inSpace asRectangle containsPoint: anEvent position)
									ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
									ifTrue: [ 'no' asRopedText foreground: BrGlamorousColors errorBackgroundColor ] ]
							ifTrue: [ 'yes' asRopedText
									foreground: BrGlamorousColors successBackgroundColor ] ]
					ifNil: [ '' ] ]
			width: 90;
		column: 'Debug'
			stencil: [ :anElement | 
				| anEvent |
				anEvent := lastClickEvent.
				BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons debug;
					beTinySize;
					label: 'Debug Find Mouse Event Target';
					enabled: anEvent isNotNil;
					action: [ :theButton | 
						anEvent
							ifNotNil: [ [ self halt.
								anElement findMouseEventTargetAt: anEvent position ] fork ] ] ]
			width: 50;
		send: [ :anElement | 
			BlMouseProcessorExaminedTargetElement new
				event: lastClickEvent;
				element: anElement;
				space: self space ];
		contextItemLabel: 'Inspect element'
			action: [ :aWidget :aNode | aWidget phlow spawnObject: aNode value ];
		contextItemLabel: 'Preview point in element'
			action: [ :aWidget :aNode | 
				aWidget phlow
					spawnObject: (BlMouseProcessorExaminedTargetElement new
							event: lastClickEvent;
							element: aNode value;
							space: self space) ]
]
