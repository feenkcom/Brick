"
I provide activation behavior shared by BrToggle and BrRadioButton. I install BrToggleModel and expose activation, enabling, alignment, resizing and sizing. Concrete subclasses decide their content models and click policy; I have no label or icon model.
"
Class {
	#name : #BrAbstractToggle,
	#superclass : #BlElement,
	#traits : 'TBrEnableable + TBrLayoutAlignable + TBrLayoutResizable + TBrSizeAdjustable',
	#classTraits : 'TBrEnableable classTrait + TBrLayoutAlignable classTrait + TBrLayoutResizable classTrait + TBrSizeAdjustable classTrait',
	#category : #'Brick-Toggle - UI'
}

{ #category : #testing }
BrAbstractToggle class >> isAbstract [
	^ self == BrAbstractToggle
]

{ #category : #activation }
BrAbstractToggle >> activate [
	"Activate the toggle if it is deactivated, otherwise do nothing"

	self viewModel activate
]

{ #category : #activation }
BrAbstractToggle >> activated: aBoolean [
	self viewModel activated: aBoolean
]

{ #category : #activation }
BrAbstractToggle >> deactivate [
	"Deactivate the toggle if it is activated, otherwise do nothing"

	self viewModel deactivate
]

{ #category : #initialization }
BrAbstractToggle >> initialize [
	super initialize.
	self
		vLocal;
		alignCenter;
		beNormalSize.
	self viewModel: BrToggleModel new
]

{ #category : #activation }
BrAbstractToggle >> isActivated [
	<return: #Boolean>
	^ self viewModel isActivated
]

{ #category : #activation }
BrAbstractToggle >> toggle [
	"Invert the toggle's state:
	 - activate if the toggle is deactivated
	 - deactivate if the toggle is already activated"

	self viewModel toggle
]
