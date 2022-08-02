"
I am a {{gtClass:BrListHorizontalState}}.
I define a vertical {{gtClass:BrSimpleList}} representation.
Use {{gtClass:BrListOrientationLook}} to define how a {{gtClass:BrSimpleList}} should look like in the vertical state.

"
Class {
	#name : #BrListVerticalState,
	#superclass : #BrListOrientationState,
	#category : #'Brick-List-Support'
}

{ #category : #accessing }
BrListVerticalState >> name [
	^ 'vertical'
]
