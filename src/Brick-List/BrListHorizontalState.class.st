"
I am a {{gtClass:BrListHorizontalState}}.
I define a horizontal {{gtClass:BrSimpleList}} representation.
Use {{gtClass:BrListOrientationLook}} to define how a {{gtClass:BrSimpleList}} should look like in the horizontal state.

"
Class {
	#name : #BrListHorizontalState,
	#superclass : #BrListOrientationState,
	#category : #'Brick-List-Support'
}

{ #category : #accessing }
BrListHorizontalState >> name [
	^ 'horizontal'
]
