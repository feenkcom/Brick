Class {
	#name : #BrMenuModelEnablementSpecifications,
	#superclass : #Object,
	#instVars : [
		'specifications'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - initialization' }
BrMenuModelEnablementSpecifications >> disableIf: aBlock [
	self
		specification: (BrMenuModelEnablementSpecification new
				disableIf: aBlock)
]

{ #category : #initialization }
BrMenuModelEnablementSpecifications >> initialize [
	super initialize.
	specifications := Array empty
]

{ #category : #'api - testing' }
BrMenuModelEnablementSpecifications >> isEnabled: aMenuModel [
	<return: #Boolean>
	
	^ self specifications allSatisfy: [ :eachSpecification | 
		eachSpecification isEnabled: aMenuModel ]
]

{ #category : #'api - initialization' }
BrMenuModelEnablementSpecifications >> specification: anUpdateSpecification [
	self specifications: (self specifications copyWith: anUpdateSpecification)
]

{ #category : #accessing }
BrMenuModelEnablementSpecifications >> specifications [
	^ specifications ifNil: [ specifications := Array empty ]
]

{ #category : #accessing }
BrMenuModelEnablementSpecifications >> specifications: aCollection [
	specifications := aCollection
]
