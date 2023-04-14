Class {
	#name : #BrPackageNameInputFilter,
	#superclass : #BrTextEditorInputFilter,
	#category : #'Brick-Editor-Model'
}

{ #category : #accessing }
BrPackageNameInputFilter >> filter: aString [
	^ aString
		select: [ :eachCharacter | 
			eachCharacter isAlphaNumeric
				or: [ eachCharacter = $_
						or: [ eachCharacter = $- or: [ eachCharacter = Character space ] ] ] ]
]
