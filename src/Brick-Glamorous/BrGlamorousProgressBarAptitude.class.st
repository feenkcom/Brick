"
I am basic {{gtClass:BrProgress}} bar glamorous look.
See {{gtClass:BrGlamorousProgressExamples}} class comment for spefic glamorous examples.

"
Class {
	#name : #BrGlamorousProgressBarAptitude,
	#superclass : #BrProgressAnimatedBarAptitude,
	#category : #'Brick-Glamorous-Progress'
}

{ #category : #'instance creation' }
BrGlamorousProgressBarAptitude >> newProgressBarElement [
	^ super newProgressBarElement
		background: self theme button defaultTextColor;
		margin: (BlInsets all: 1);
		geometry: BlStadiumGeometry new
]

{ #category : #'instance creation' }
BrGlamorousProgressBarAptitude >> newProgressContainerElement [
	^ super newProgressContainerElement
		background: self theme button defaultBackground;
		border: (BlBorder paint: self theme button defaultBorderColor width: 1);
		geometry: BlStadiumGeometry new;
		margin: (BlInsets left: 4)
]
