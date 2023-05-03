Class {
	#name : #BrLazyStyleCommonAptitude,
	#superclass : #BrLazyStyleAptitude,
	#category : #'Brick-! Core - Looks'
}

{ #category : #'api - styles' }
BrLazyStyleCommonAptitude >> collapsed: aBlock [
	self
		when: BlElementState collapsed
		style: aBlock
]

{ #category : #'api - styles' }
BrLazyStyleCommonAptitude >> default: aBlock [
	self
		when: BlElementState default
		style: aBlock
]

{ #category : #'api - styles' }
BrLazyStyleCommonAptitude >> deselected: aBlock [
	self
		when: BlElementState deselected
		style: aBlock
]

{ #category : #'api - styles' }
BrLazyStyleCommonAptitude >> disabled: aBlock [
	self
		when: BlElementState disabled
		style: aBlock
]

{ #category : #'api - styles' }
BrLazyStyleCommonAptitude >> enabled: aBlock [
	self
		when: BlElementState enabled
		style: aBlock
]

{ #category : #'api - styles' }
BrLazyStyleCommonAptitude >> expanded: aBlock [
	self
		when: BlElementState expanded
		style: aBlock
]

{ #category : #'api - styles' }
BrLazyStyleCommonAptitude >> focused: aBlock [
	self
		when: BlElementState focused
		style: aBlock
]

{ #category : #'api - styles' }
BrLazyStyleCommonAptitude >> hovered: aBlock [
	self
		when: BlElementState hovered
		style: aBlock
]

{ #category : #'api - styles' }
BrLazyStyleCommonAptitude >> pressed: aBlock [
	self
		when: BlElementState pressed
		style: aBlock
]

{ #category : #'api - styles' }
BrLazyStyleCommonAptitude >> selected: aBlock [
	self
		when: BlElementState selected
		style: aBlock
]

{ #category : #'api - styles' }
BrLazyStyleCommonAptitude >> unfocused: aBlock [
	self
		when: BlElementState unfocused
		style: aBlock
]
