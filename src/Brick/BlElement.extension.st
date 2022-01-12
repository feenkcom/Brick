Extension { #name : #BlElement }

{ #category : #'*Brick' }
BlElement >> actors [
	^ Array streamContents: [ :aStream |
		self viewModelDo: [ :aViewModel | aStream nextPut: aViewModel ].	
		self aptitudeDo: [ :aLook | aStream nextPut: aLook ] ]
]

{ #category : #'*Brick' }
BlElement >> addAptitude: aLook [
	self aptitude
		ifNil: [ self aptitude: aLook ]
		ifNotNil: [ self aptitude add: aLook ].
]

{ #category : #'*Brick' }
BlElement >> addInteractiveModelState: aState [
	self viewModel
		ifNil: [ self viewModel: (BrInteractiveModel with: aState) ]
		ifNotNil: [ self viewModel addInteractiveModelState: aState ].
]

{ #category : #'*Brick' }
BlElement >> addLook: anAptitude [
	self
		deprecated: 'Please use addAptitude: instead.'
		transformWith:
			'`@receiver addLook: `@statements1'
				-> '`@receiver addAptitude: `@statements1'.

	self addAptitude: anAptitude 
]

{ #category : #'*Brick' }
BlElement >> addViewModel: aViewModel [
	self viewModel
		ifNil: [ self viewModel: aViewModel ]
		ifNotNil: [ self viewModel add: aViewModel ].
]

{ #category : #'*Brick' }
BlElement >> anchor [
	^ self userData at: #brickAnchor ifAbsent: [ self parent ifNotNil: #anchor ]
]

{ #category : #'*Brick' }
BlElement >> anchor: anElement [
	self userData at: #brickAnchor put: anElement
]

{ #category : #'*Brick' }
BlElement >> aptitude [
	^ self userData at: #brickLook ifAbsent: nil
]

{ #category : #'*Brick' }
BlElement >> aptitude: aLook [
	| aLookInstance |
	
	self aptitudeDo: [ :aCurrentLook |
		aCurrentLook onUninstalledIn: self.
		self userData at: #brickLook put: nil ].

	aLookInstance := aLook asLook.

	self userData at: #brickLook put: aLookInstance.
	aLookInstance onInstalledIn: self
]

{ #category : #'*Brick' }
BlElement >> aptitudeDo: aBlock [
	self aptitude ifNotNil: aBlock
]

{ #category : #'*Brick' }
BlElement >> asBrAnchoredAnchorBounds [
	^ BrAnchoredElementAnchorBounds element: self
]

{ #category : #'*Brick' }
BlElement >> asStencil [
	^ self
]

{ #category : #'*Brick' }
BlElement >> asVerticallyResizableDo: aBlock [
	^ aBlock value: (BlElement new
		aptitude: BrGlamorousWithVerticalResizerAptitude;
		addChild: self)
]

{ #category : #'*Brick' }
BlElement >> asyncFuture [
	^ self userData
		at: #asyncFuture
		ifAbsentPut: [ BrAsyncElementFuture on: self ]
]

{ #category : #'*Brick' }
BlElement >> asyncPromise [
	^ self userData
		at: #asyncPromise
		ifAbsentPut: [ BrAsyncElementPromise on: self ]
]

{ #category : #'*Brick' }
BlElement >> asyncSink [
	^ self userData
		at: #asyncSink 
		ifAbsentPut: [ BrAsyncElementSink on: self ]
]

{ #category : #'*Brick' }
BlElement >> gtInspectorModelAptitudeGraphIn: aComposite [
	<gtInspectorPresentationOrder: 30>
	
	^ aComposite blocMondrian
		title: 'Widget';
		painting: [ :view | self gtInspectorPaintModelAptitudeIn: view ] 
]

{ #category : #'*Brick' }
BlElement >> gtInspectorPaintModelAptitudeIn: aMondrianView [
	| nodes |

	nodes := { self }.
	self viewModelDo: [ :aViewModel | nodes := nodes, aViewModel withAllChildren ].
	self aptitudeDo: [ :aLook | nodes := nodes, aLook withAllChildren ].
	nodes := nodes asSet asArray.
	
	aMondrianView nodes
		stencil: [ :each |
			BrHorizontalPane new
				fitContent;
				alignCenter;
				padding: (BlInsets right: 5);
				addChild: (BrHorizontalPane new 
					background: Color veryLightGray;
					geometry: BlCircleGeometry new;
					padding: (BlInsets all: 5);
					margin: (BlInsets right: 5);
					fitContent;
					addChild: (BrLabel new
						aptitude: (BrGlamorousLabelAptitude new fontSize: 10);
						text: (((each isKindOf: BlElement)
							ifTrue: [ 'W' ]
							ifFalse: [ (each isKindOf: BrAptitude)
								ifTrue: [ 'A' ]
								ifFalse: [ 'M' ] ]))));
				addChild: (BrLabel new
					aptitude: (BrGlamorousLabelAptitude new);
					text: each class name )
				 ];
		with: nodes.
	
	aMondrianView edges 
		stencil: [ :x | 
			"BlSigmoidElement new 
				beHorizontal;"
			BlLineElement new
				border: (BlBorder paint: (Color gray alpha: 0.5))];
		fromRightCenter;
		toLeftCenter;
		connectToAll: #actors.
	
	aMondrianView layout horizontalTree nodeDistance: 20
]

{ #category : #'*Brick' }
BlElement >> layoutResizerPropagations [
	^ self userData
		at: #brickLayoutResizerPropagations
		ifAbsentPut: [ BrLayoutResizerElementPropagations new element: self ]
]

{ #category : #'*Brick' }
BlElement >> look [
	self
		deprecated: 'Please use #aptitude instead.'
		transformWith: '`@receiver look' -> '`@receiver aptitude'.
	^ self aptitude
]

{ #category : #'*Brick' }
BlElement >> look: anAptitude [
	self
		deprecated: 'Please use aptitude: instead.'
		transformWith:
			'`@receiver look: `@statements1'
				-> '`@receiver aptitude: `@statements1'.

	self aptitude: anAptitude 
]

{ #category : #'*Brick' }
BlElement >> removeAptitude: aLook [
	self aptitude
		ifNotNil: [
			self aptitude = aLook
				ifTrue: [
					self aptitude onUninstalledIn: self.
					self userData at: #brickLook put: nil ]
				ifFalse: [ self aptitude remove: aLook ] ]
]

{ #category : #'*Brick' }
BlElement >> removeLook: anAptitude [
	self
		deprecated: 'Please use removeAptitude: instead.'
		transformWith:
			'`@receiver removeLook: `@statements1'
				-> '`@receiver removeAptitude: `@statements1'.

	self removeAptitude: anAptitude 
]

{ #category : #'*Brick' }
BlElement >> viewModel [
	^ self userData at: #brickViewModel ifAbsent: nil
]

{ #category : #'*Brick' }
BlElement >> viewModel: aBrViewModel [
	self aptitudeDo: [ :aLook | self error: 'View model must be added before look' ].

	self viewModelDo: [ :aCurrentModel |
		aCurrentModel onUninstalledIn: self.
		self userData at: #brickViewModel put: nil ].

	self userData at: #brickViewModel put: aBrViewModel.
	aBrViewModel onInstalledIn: self
]

{ #category : #'*Brick' }
BlElement >> viewModelDo: aBlock [
	self userData at: #brickViewModel ifPresent: aBlock
]

{ #category : #'*Brick' }
BlElement >> viewModelDo: aBlock ifAbsent: anAbsentBlock [
	^ self userData
		at: #brickViewModel
		ifPresent: aBlock
		ifAbsent: anAbsentBlock
]

{ #category : #'*Brick' }
BlElement >> withAsyncFutureDo: aBlock [
	aBlock value: self asyncFuture
]

{ #category : #'*Brick' }
BlElement >> withAsyncPromiseDo: aBlock [
	aBlock value: self asyncPromise
]

{ #category : #'*Brick' }
BlElement >> withAsyncSinkDo: aBlock [
	aBlock value: self asyncSink
]
