Class {
	#name : #BrTextReadonlyWordPieceStencilBuilder,
	#superclass : #BrTextWordPieceStencilBuilder,
	#category : #'Brick-Editor-UI - Stencils'
}

{ #category : #initialization }
BrTextReadonlyWordPieceStencilBuilder class >> initialize [
	TextPiecePool := BlObjectPool new: 1000
]

{ #category : #'api - instantiation' }
BrTextReadonlyWordPieceStencilBuilder >> createWordElement [
	<return: #BrTextElementWithCursors>

	^ BrTextElementWithCursors new
			editorMeasurement;
			beFocusable;

			"to support event-handling attributes"
			addEventHandler: BrTextEditorLineSegmentTextListener uniqueInstance;
			
			"for screen position to cursor index transformation"
			addEventHandler: BrTextWordPieceScreenToCursorHandler uniqueInstance;

			addEventHandler: BrTextWordPieceFocusHandler uniqueInstance;
			addEventHandler: BrTextWordPieceBlurHandler uniqueInstance;
			
			"selection changed in the editor, select a given interval"
			addEventHandler: BrTextWordPieceSelectionHandler uniqueInstance;
			
			"selection changed in the editor, deselect a given interval"
			addEventHandler: BrTextWordPieceDeselectionHandler uniqueInstance;
			
			"text changed in the editor"
			addEventHandler: BrTextWordPieceTextChangeHandler uniqueInstance;		

			"text piece got inside of selected area"
			addEventHandler: BrTextWordPieceSelectionAcquiredHandler uniqueInstance;

			"text piece got outside of then selected area"
			addEventHandler: BrTextWordPieceSelectionLostHandler uniqueInstance;

			yourself
]
