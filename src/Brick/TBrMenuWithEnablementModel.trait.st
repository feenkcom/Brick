Trait {
	#name : #TBrMenuWithEnablementModel,
	#instVars : [
		'enableSpecifications'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - enablement' }
TBrMenuWithEnablementModel >> defaultEnableSpecifications [
	^ BrMenuModelEnablementSpecifications new
]

{ #category : #'api - enablement' }
TBrMenuWithEnablementModel >> disableIf: aBlock [
	self enableSpecifications disableIf: aBlock
]

{ #category : #'api - enablement' }
TBrMenuWithEnablementModel >> enableSpecifications [
	^ enableSpecifications
		ifNil: [ enableSpecifications := self defaultEnableSpecifications ]
]

{ #category : #'api - enablement' }
TBrMenuWithEnablementModel >> hasEnableSpecifications [
	^ enableSpecifications isNotNil
]

{ #category : #'api - enablement' }
TBrMenuWithEnablementModel >> isEnabled [
	^ self enableSpecifications isEnabled: self
]
