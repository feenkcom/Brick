Class {
	#name : #BrDevScripterMenuStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'Brick-DevTool-Scripter'
}

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertMenuContainerExist: anExpectedCount [
	| anExistingCount |
	^ self assert
		label: ('Assert existing {1} menu {2}'
				format: {anExpectedCount.
						'container' asPluralBasedOn: anExpectedCount});
		satisfies: [ :aRootElement | 
				anExistingCount := (aRootElement query // BrMenuSteppedElement) all size.
				anExistingCount = anExpectedCount ]
			description: [ :aRootElement | 
				'Expected {1} menu container, actual number is: {2}'
					format: {anExpectedCount.
							anExistingCount} ];
		onSpaceRoot
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> keepPermanentlyDropdownInScene [
	^ (self keepPermanentlyMenuInScene: BrGlamorousWithExplicitDropdownAptitude) 
		referenceSender
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> keepPermanentlyMenuInScene: aMenuAptitudeClass [
	"I am used for demo purposes."

	^ self do
		referenceSender;
		onParentStepTarget: self;
		label: 'Keep menu permanently in its scene';
		block: [ :anElement | 
			anElement aptitude
				findActor: aMenuAptitudeClass
				ifFound: [ :aDropdownAptitude | 
					aDropdownAptitude
						removeSceneEventHandlers;
						removeClickOutsideEventHandler;
						removePressEscEventHandler ]
				ifNone: [ NotFound
						signalFor: aMenuAptitudeClass
						in: anElement ] ]
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> prepareSteppedLayoutAnalyzerFor: aMenuAptitudeClass [
	^ self do
		referenceSender;
		label: 'Prepare stepped layout analyser';
		block: [ :aButton :aUserData | 
			aButton
				aptitudeDo: [ :anAptitude | 
					anAptitude
						withAllActorsBreadthFirstDo: [ :eachAptitude | 
							(eachAptitude isKindOf: aMenuAptitudeClass)
								ifTrue: [ 
									| anAnalyzer |
									anAnalyzer := BlSteppedLayoutLastStateAnalyzer new.
									anAnalyzer menuContainer: eachAptitude menuContainer.
									eachAptitude menuContainer layout analyzer: anAnalyzer.
									aUserData at: BlSteppedLayoutLastStateAnalyzer put: anAnalyzer ] ] ] ]
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> prepareSteppedLayoutContextMenuAnalyzer [
	^ (self prepareSteppedLayoutAnalyzerFor: BrGlamorousWithExplicitContextMenuAptitude)
		referenceSender
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> prepareSteppedLayoutDropdownAnalyzer [
	^ (self prepareSteppedLayoutAnalyzerFor: BrWithExplicitDropdownAptitude)
		referenceSender
]
