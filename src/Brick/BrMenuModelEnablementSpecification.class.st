Class {
	#name : #BrMenuModelEnablementSpecification,
	#superclass : #Object,
	#instVars : [
		'disableBlock'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - initialization' }
BrMenuModelEnablementSpecification >> disableIf: aBlock [
	disableBlock := aBlock
]

{ #category : #'api - testing' }
BrMenuModelEnablementSpecification >> isDisabled: aMenuModel [
	disableBlock ifNil: [ ^ false ].

	^ disableBlock cull: aMenuModel
]

{ #category : #'api - testing' }
BrMenuModelEnablementSpecification >> isEnabled: aMenuModel [
	^ (self isDisabled: aMenuModel) not
]
