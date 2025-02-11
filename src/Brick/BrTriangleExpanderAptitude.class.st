Class {
	#name : #BrTriangleExpanderAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'isExpanded',
		'collapsedStencil',
		'expandedStencil',
		'collapsedTriangle',
		'expandedTriangle'
	],
	#category : #'Brick-Triangle - Look'
}

{ #category : #'api - expandable' }
BrTriangleExpanderAptitude >> collapse [
	self isExpanded ifFalse: [ ^ self ].
	isExpanded := false.
	self updateVisibleTriangle.
]

{ #category : #'private - ui' }
BrTriangleExpanderAptitude >> collapseWidget: aWidget [
	self collapsedTriangle removeFromParent.
	self expandedTriangle removeFromParent.
	self widgetContent addChild: self collapsedTriangle as: #triangle.
	isExpanded := false.
]

{ #category : #accessing }
BrTriangleExpanderAptitude >> collapsedStencil [
	^ collapsedStencil
]

{ #category : #accessing }
BrTriangleExpanderAptitude >> collapsedStencil: aStencil [
	collapsedStencil := aStencil.
	collapsedTriangle ifNotNil: [ :aTriangle | aTriangle removeFromParent ].
	collapsedTriangle := nil.
	self updateVisibleTriangle.
]

{ #category : #accessing }
BrTriangleExpanderAptitude >> collapsedTriangle [
	collapsedTriangle ifNil: [ 
		collapsedTriangle := self collapsedStencil asElement.
		self initializeTriangle: collapsedTriangle ].
	^ collapsedTriangle.
]

{ #category : #defaults }
BrTriangleExpanderAptitude >> defaultCollapsedStencil [
	^ BrCollapsedTriangleStencil new
]

{ #category : #defaults }
BrTriangleExpanderAptitude >> defaultExpandedStencil [
	^ BrExpandedTriangleStencil new
]

{ #category : #'api - expandable' }
BrTriangleExpanderAptitude >> expand [
	self isExpanded ifTrue: [ ^ self ].
	isExpanded := true.
	self updateVisibleTriangle.
]

{ #category : #'private - ui' }
BrTriangleExpanderAptitude >> expandWidget: aWidget [
	self collapsedTriangle removeFromParent.
	self expandedTriangle removeFromParent.
	self widgetContent addChild: self expandedTriangle as: #triangle.
	isExpanded := true
]

{ #category : #accessing }
BrTriangleExpanderAptitude >> expandedStencil [
	^ expandedStencil
]

{ #category : #accessing }
BrTriangleExpanderAptitude >> expandedStencil: aStencil [
	expandedStencil := aStencil.
	expandedTriangle ifNotNil: [ :aTriangle | aTriangle removeFromParent ].
	expandedTriangle := nil.
	self updateVisibleTriangle.
]

{ #category : #accessing }
BrTriangleExpanderAptitude >> expandedTriangle [
	expandedTriangle ifNil: [ 
		expandedTriangle := self expandedStencil asElement.
		self initializeTriangle: expandedTriangle ].
	^ expandedTriangle.
]

{ #category : #initialization }
BrTriangleExpanderAptitude >> initialize [
	super initialize.
	
	isExpanded := false.
	
	collapsedStencil := self defaultCollapsedStencil.
	expandedStencil := self defaultExpandedStencil.
	
	self 
		addChangeAddChildAs: #(content triangle) 
		with: [ self triangle ]
]

{ #category : #initialization }
BrTriangleExpanderAptitude >> initializeListeners [
	super initializeListeners.
	
	self when: BrTriangleStencilsChanged do: [ :anEvent | self onStencilsChanged: anEvent ].
	self when: BrExpandedEvent do: [ :anEvent | self expandWidget: self widget ].
	self when: BrCollapsedEvent do: [ :anEvent | self collapseWidget: self widget ]
]

{ #category : #initialization }
BrTriangleExpanderAptitude >> initializeRequests [
	super initializeRequests.
	
	self request: BrTriangleStencilsRequest new.
]

{ #category : #initialization }
BrTriangleExpanderAptitude >> initializeTriangle: aTriangle [
	"subclasses may configure collapsed and expanded triangle elements"
]

{ #category : #'api - expandable' }
BrTriangleExpanderAptitude >> isExpanded [
	<return: #Boolean>
	^ isExpanded
]

{ #category : #hooks }
BrTriangleExpanderAptitude >> onStencilsChanged: anEvent [
	self collapsedStencil: anEvent collapsedStencil.
	self expandedStencil: anEvent expandedStencil.
]

{ #category : #'api - expandable' }
BrTriangleExpanderAptitude >> toggle [
	isExpanded := isExpanded not.
	self updateVisibleTriangle.
]

{ #category : #accessing }
BrTriangleExpanderAptitude >> triangle [
	^ self isExpanded 
		ifTrue: [ self expandedTriangle ]
		ifFalse: [ self collapsedTriangle ] 
]

{ #category : #'private - ui' }
BrTriangleExpanderAptitude >> updateVisibleTriangle [
	self widgetDo: [ :aWidget |
		self isExpanded 
			ifTrue: [ self expandWidget: aWidget ]
			ifFalse: [ self collapseWidget: aWidget ] ]
]
