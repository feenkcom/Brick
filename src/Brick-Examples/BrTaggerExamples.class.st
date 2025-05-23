Class {
	#name : #BrTaggerExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Tagger'
}

{ #category : #'instance creation' }
BrTaggerExamples >> newGlamorousTagger [
	<gtExample>
	<return: #BrTagger>
	^ BrTagger new
		aptitude: BrGlamorousTaggerEditableAptitude new;
		namedTags: {'How'.
				'Are'.
				'You'};
		when: BrTaggerAddTagRequest
			do: [ :aRequest | aRequest tag name ifNotEmpty: [ aRequest currentTarget addTag: aRequest tag ] ];
		when: BrTaggerRemoveTagRequest
			do: [ :aRequest | aRequest currentTarget removeTag: aRequest tag ];
		when: BrTaggerRenameTagRequest
			do: [ :aRequest | 
				aRequest newName trimmed
					ifEmpty: [ aRequest currentTarget removeTag: aRequest tag ]
					ifNotEmpty: [ :aNewName | aRequest currentTarget renameTag: aRequest tag to: aNewName ] ]
]

{ #category : #'instance creation' }
BrTaggerExamples >> newGlamorousTaggerWithDropdown [
	<gtExample>
	<return: #BrTagger>
	^ BrTagger new
		aptitude: (BrGlamorousTaggerEditableDropdownAptitude new
				content: [ :aDropdown :anAcceptAction | 
					| fileBrowser |
					fileBrowser := BrFileSelector new.

					fileBrowser vExact: 250.
					fileBrowser hExact: 400.
					fileBrowser padding: (BlInsets all: 10).

					fileBrowser buttonLabel: 'Add'.
					fileBrowser
						okAction: [ :filePath | anAcceptAction value: filePath basename ].
					fileBrowser ]);
		namedTags: {'.'.
				'..'};
		when: BrTaggerAddTagRequest
			do: [ :aRequest | aRequest tag name ifNotEmpty: [ aRequest currentTarget addTag: aRequest tag ] ];
		when: BrTaggerRemoveTagRequest
			do: [ :aRequest | aRequest currentTarget removeTag: aRequest tag ];
		when: BrTaggerRenameTagRequest
			do: [ :aRequest | 
				aRequest newName trimmed
					ifEmpty: [ aRequest currentTarget removeTag: aRequest tag ]
					ifNotEmpty: [ :aNewName | aRequest currentTarget renameTag: aRequest tag to: aNewName ] ]
]

{ #category : #'instance creation' }
BrTaggerExamples >> newGlamorousTaggerWithExplicitTags [
	<gtExample>
	<return: #BrTagger>
	^ BrTagger new
		aptitude: BrGlamorousTaggerSelectableAptitude new;
		explicitAllowedTags: {BrExampleTaggerCatTag new.
				BrExampleTaggerDogTag new};
		when: BrTaggerAddTagRequest
			do: [ :aRequest | aRequest tag name ifNotEmpty: [ aRequest currentTarget addTag: aRequest tag ] ];
		when: BrTaggerRemoveTagRequest
			do: [ :aRequest | aRequest currentTarget removeTag: aRequest tag ];
		when: BrTaggerRenameTagRequest
			do: [ :aRequest | 
				aRequest newName trimmed
					ifEmpty: [ aRequest currentTarget removeTag: aRequest tag ]
					ifNotEmpty: [ :aNewName | aRequest currentTarget renameTag: aRequest tag to: aNewName ] ]
]
