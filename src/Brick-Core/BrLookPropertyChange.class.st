Class {
	#name : #BrLookPropertyChange,
	#superclass : #BrLookChange,
	#instVars : [
		'old',
		'new',
		'read',
		'path',
		'value'
	],
	#category : #'Brick-Core-Changes'
}

{ #category : #initialization }
BrLookPropertyChange >> downOn: aLook [
	self assert: [ initialized ].
	old := nil.
	new := nil.
	down value: aLook value: old value: new.
	initialized := false
]

{ #category : #initialization }
BrLookPropertyChange >> initialize [
	super initialize.
	read := [ :e | self readOn: e ].
	up := [ :e :f | 
	self
		writeOn: e
		value:
			(value isBlock
				ifTrue: [ value cull: f ]
				ifFalse: [ value ]) ].
	down := [ :e :f :g | self writeOn: e value: f ]
]

{ #category : #accessing }
BrLookPropertyChange >> path [
	^ path
]

{ #category : #accessing }
BrLookPropertyChange >> path: anObject [
	path := anObject
]

{ #category : #printing }
BrLookPropertyChange >> printOn: aStream [
	aStream nextPutAll: (' ' join: (path collect: #asString))
]

{ #category : #initialization }
BrLookPropertyChange >> readOn: aLook [

	^ path inject: aLook into: [ :e :f | e perform: f ]
]

{ #category : #initialization }
BrLookPropertyChange >> upOn: aLook [
	self assert: [ initialized not ].
	old := read value: aLook.
	up value: aLook value: old.
	new := read value: aLook.
	initialized := true
]

{ #category : #accessing }
BrLookPropertyChange >> value [
	^ value
]

{ #category : #accessing }
BrLookPropertyChange >> value: anObject [
	value := anObject
]

{ #category : #initialization }
BrLookPropertyChange >> writeOn: aLook value: anObject [
	| receiver |
	anObject ifNil: [ ^ self ].
	receiver := (path copyFrom: 1 to: path size - 1)
			inject: aLook
			into: [ :e :f | e perform: f ].
	^ receiver perform: (path last asString , ':') asSymbol with: anObject
]
