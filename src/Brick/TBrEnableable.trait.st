"
I add API that allows users to enable/disable widgets that support it, for example {{gtClass:BrButton}} or {{gtClass:BrToggle}}

"
Trait {
	#name : #TBrEnableable,
	#category : #'Brick-! Core - Support'
}

{ #category : #'api - enablement' }
TBrEnableable >> disable [
	self states addState: BlElementState disabled
]

{ #category : #'api - enablement' }
TBrEnableable >> disabled: aBoolean [
	aBoolean value
		ifTrue: [ self disable ]
		ifFalse: [ self enable ]
]

{ #category : #'api - enablement' }
TBrEnableable >> enable [
	self states removeState: BlElementState disabled
]

{ #category : #'api - enablement' }
TBrEnableable >> enabled: aBoolean [
	aBoolean value
		ifTrue: [ self enable ]
		ifFalse: [ self disable ]
]

{ #category : #'api - enablement' }
TBrEnableable >> isDisabled [
	<return: #Boolean>

	^ self states hasState: BlElementState disabled
]

{ #category : #'api - enablement' }
TBrEnableable >> isEnabled [
	^ self isDisabled not
]
