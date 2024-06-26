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
	| alignedButton fileInputFieldContainer |
	breadcrumb := self createBreadcrumb.
	table := self createTable.
	table
		when: BrSelectionChanged
		do: [ :anEvent | 
			anEvent indices
				ifNotEmpty: [ :theIndices | 
					| aWidgetElement selectedObject |
					aWidgetElement := anEvent currentTarget.
					selectedObject := aWidgetElement viewModel itemAt: theIndices first.
					fileInputField text: selectedObject basename ] ].
	alignedButton := self createOkButton.
	fileInputFieldContainer := self createFileInputField.
	self
		addChildren: {BrScrollPane new
					aptitude: BrScrollPaneAptitude;
					hMatchParent;
					vFitContent;
					content: breadcrumb;
					when: BlElementLayoutComputedEvent
						doOnce: [ :anEvent | anEvent currentTarget scrollBy: Float infinity negated @ 0 ].
				table.
				fileInputFieldContainer.
				alignedButton}
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
