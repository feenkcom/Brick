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
	"Get an anchor element, which is the element to which a BrWithExplicitMenuAptitude is attached to.
	This is a convenience method to get an anchor element.
	It is likely preferable to use BrMenuAnchorElementEvent instead.
	Note: Anchor is unavailable if a menu is closed.
	Note: Try to fire events:
		- to keep your code more generic, and
		- to keep your elements usable also ouside of menu containers."

	^ self userData at: #brickAnchor ifAbsent: [ self parent ifNotNil: #anchor ]
]

{ #category : #'*Brick' }
BlElement >> anchor: anElementOrNil [
	"Set anchor element, which is an element to which a BrWithExplicitMenuAptitude is attached.
	This is a convenience method to get an anchor element using BlElement>>#anchor.
	It is likely preferable to use BrMenuAnchorElementEvent instead.
	Note: Anchor is unavailable if a menu is closed.
	Note: Try to fire events:
		- to keep your code more generic, and
		- to keep your elements usable also ouside of menu containers."

	anElementOrNil
		ifNotNil: [ self userData at: #brickAnchor put: anElementOrNil ]
		ifNil: [ self userData removeKey: #brickAnchor ifAbsent: [  "ignore" ] ]
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
