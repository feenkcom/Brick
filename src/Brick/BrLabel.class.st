Class {
	#name : #BrLabel,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TBrLayoutAlignable + TBrSizeAdjustable',
	#classTraits : 'TBrLayoutResizable classTrait + TBrLayoutAlignable classTrait + TBrSizeAdjustable classTrait',
	#category : #'Brick-Label - UI'
}

{ #category : #layout }
BrLabel >> baselineOffset [
	^ self
		childWithId: #label
		ifFound: [ :aTextElement | aTextElement baselineOffset + self padding top + aTextElement margin top ]
		ifNone: [ 0 ]
]

{ #category : #printing }
BrLabel >> gtDisplayOn: aStream [ 

	aStream nextPutAll: self text asString
]

{ #category : #initialization }
BrLabel >> initialize [
	super initialize.
	
	self
		fitContent;
		beNormalSize;
		alignCenterLeft.

	self viewModel: BrLabelModel new
]

{ #category : #layout }
BrLabel >> supportsBaseline [
	^ true
]

{ #category : #accessing }
BrLabel >> text [
	<return: #BlText>

	^ self viewModel text
]

{ #category : #accessing }
BrLabel >> text: aTextOrString [
	self viewModel text: aTextOrString
]

{ #category : #'time label' }
BrLabel >> updatingDateAndModel [
	"Display updating date and time as a since now text, e.g., 1 minute ago.
	Note: The updating date and time must be initialized before aptitudes."

	^ self userData
		at: #brickUpdatingDateAndTimeViewModel
		ifPresent: [ :aViewModel | aViewModel ]
		ifAbsentPut: [ | aViewModel |
			aViewModel := BrUpdatingDateAndTimeModel new.
			self viewModel add: aViewModel.
			aViewModel ]
]

{ #category : #'time label' }
BrLabel >> updatingDateAndTime: aDateAndTime [
	"Display updating date and time as a since now text, e.g., 1 minute ago.
	Note: The updating date and time must be initialized before aptitudes."

	^ self updatingDateAndModel dateAndTime: aDateAndTime
]
