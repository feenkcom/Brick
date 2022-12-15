Class {
	#name : #BrPackageTagNameInputFilter,
	#superclass : #BrTextEditorInputFilter,
	#category : #'Brick-Editor-Model'
}

{ #category : #accessing }
BrPackageTagNameInputFilter >> filter: aString [
	^ aString
		select: [ :eachCharacter | eachCharacter isAlphaNumeric or: [ '_-! ' includes: eachCharacter ] ]
]
