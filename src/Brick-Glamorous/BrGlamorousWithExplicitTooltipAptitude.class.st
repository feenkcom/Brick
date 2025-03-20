Class {
	#name : #BrGlamorousWithExplicitTooltipAptitude,
	#superclass : #BrWithExplicitTooltipAptitude,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #accessing }
BrGlamorousWithExplicitTooltipAptitude class >> text: aLabelString [
	^ self text: aLabelString shortcut: nil
]

{ #category : #accessing }
BrGlamorousWithExplicitTooltipAptitude class >> text: aLabelString do: anAptitudeBlock [
	^ self
		text: aLabelString
		shortcut: nil
		do: anAptitudeBlock
]

{ #category : #accessing }
BrGlamorousWithExplicitTooltipAptitude class >> text: aLabelString shortcut: aShortcutString [
	"Keymap can be:
		- a text, e.g., 'F5',
		- a BlKeyCombination instance, or
		- nil"

	^ self
		text: aLabelString
		shortcut: aShortcutString
		do: [ :anAptitude |  ]
]

{ #category : #accessing }
BrGlamorousWithExplicitTooltipAptitude class >> text: aLabelString shortcut: aShortcutString do: anAptitudeBlock [
	"Keymap can be:
		- a text, e.g., 'F5',
		- a BlKeyCombination instance, or
		- nil"

	^ self
		menu: [ aShortcutString
				ifNotNil: [ BrMenuLabelItem new label: aLabelString shortcut: aShortcutString asString ]
				ifNil: [ BrMenuLabelItem new label: aLabelString ] ]
		do: anAptitudeBlock
]

{ #category : #initialization }
BrGlamorousWithExplicitTooltipAptitude >> defaultElementBuilder [
	^ BrGlamorousMenuElementBuilder new
]
