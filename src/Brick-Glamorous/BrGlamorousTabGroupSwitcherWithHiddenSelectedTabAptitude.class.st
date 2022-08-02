"
I am a tab switcher look that position tabs at top-center part of container.
I hide a selected tab header widget.

I expect to be attached to a {{gtClass:BrTabGroup}} instance.

## Examples 
### With Labels
{{gtExample:BrExamplesShowroom>>#glamorousTabsSwitcherWithHiddenSelectedTabsWithLabels|codeExpanded=false|previewExpanded=true}}

### With Icons
{{gtExample:BrExamplesShowroom>>#glamorousTabsSwitcherWithHiddenSelectedTabsWithIcons|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #BrGlamorousTabGroupSwitcherWithHiddenSelectedTabAptitude,
	#superclass : #BrGlamorousTabGroupSwitcherAptitude,
	#category : #'Brick-Glamorous-Tabs - Switcher'
}

{ #category : #'instance creation' }
BrGlamorousTabGroupSwitcherWithHiddenSelectedTabAptitude >> newHeaderLook [
	^ BrGlamorousTabGroupSwitcherHeaderWithHiddenSelectedTabAptitude new
]
