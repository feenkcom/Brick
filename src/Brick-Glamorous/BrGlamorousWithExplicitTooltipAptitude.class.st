"
I display a label tooltip of a given {{gtMethod:BrGlamorousWithLabelTooltipAptitude class>> #text: | label=text}}. 
# Example
{{gtExample: BrMenuWithScripterExamples>>#hoverButtonWithTooltipKeymap | noCode=true | previewHeight=800}}
"
Class {
	#name : #BrGlamorousWithExplicitTooltipAptitude,
	#superclass : #BrWithExplicitTooltipAptitude,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #initialization }
BrGlamorousWithExplicitTooltipAptitude >> defaultElementBuilder [
	^ BrGlamorousMenuElementBuilder new
]
