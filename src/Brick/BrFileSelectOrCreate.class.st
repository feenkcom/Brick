Class {
	#name : #BrFileSelectOrCreate,
	#superclass : #BrFileSelector,
	#instVars : [
		'fileInputField'
	],
	#category : #'Brick-File - UI'
}

{ #category : #accessing }
BrFileSelectOrCreate >> buildUI [
	| fileInputFieldContainer |
	super buildUI.
	fileInputFieldContainer := self createFileInputField.
	table
		when: BrSelectionChanged
		do: [ :anEvent | 
			anEvent indices
				ifNotEmpty: [ :theIndices | 
					| aWidgetElement selectedObject |
					aWidgetElement := anEvent currentTarget.
					selectedObject := aWidgetElement viewModel itemAt: theIndices first.
					fileInputField text: selectedObject basename ] ].
	self addChild: fileInputFieldContainer after: table
]

{ #category : #accessing }
BrFileSelectOrCreate >> createFileInputField [
	|fileInputFieldLabel |
	fileInputFieldLabel := self createFileInputFieldLabel .
	fileInputField := BrEditableLabel new.
	fileInputField aptitude: BrGlamorousEditableLabelAptitude.
	fileInputField hMatchParent.
	fileInputField switchToEditor.
	fileInputField editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | 
				(anEvent text asString size > 0) 
						ifTrue: [ okButton enable ];
						ifFalse: [  okButton disable ]].
	^ BrHorizontalPane new 
		hMatchParent; 
		vFitContent;
		margin: (BlInsets top: 10); 
		addChild:fileInputFieldLabel; 
		addChild:fileInputField.

	
]

{ #category : #accessing }
BrFileSelectOrCreate >> createFileInputFieldLabel [
	^ BrLabel new text:'New file name:'; 
		addAptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
		fitContent;
		margin: (BlInsets right: 5).
]

{ #category : #accessing }
BrFileSelectOrCreate >> executeAction [ 
	"Execute the receiver's load action"
	| newFile |

	newFile := (folder / fileInputField text asString).
	self updateDisplay.
	fileInputField text: ''.
	^ self okAction 
				cull: newFile
				cull: okButton.
]
