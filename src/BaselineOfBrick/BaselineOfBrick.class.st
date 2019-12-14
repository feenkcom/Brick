"
I am a Baseline of Brick.
"
Class {
	#name : #BaselineOfBrick,
	#superclass : #BaselineOf,
	#category : #BaselineOfBrick
}

{ #category : #baseline }
BaselineOfBrick >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.7.252/src' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:38cb3436c9593de5abd580b8bb23d06753afdb33/repository' ].
		spec 
			package: #'Brick-Editor' with: [
				spec requires: #('Bloc' 'Beacon' ). ];
			package: #Brick with: [
				spec requires: #('Bloc' 'Brick-Editor' 'Beacon' ). ];
			package: #'Brick-Editor-Extensions' with: [
				spec requires: #('Brick' ). ];
			package: #'Brick-Material' with: [
				spec requires: #('Brick' ). ];
			package: #'Brick-Hydra' with: [
				spec requires: #('Brick' ). ];
			package: #'Brick-Glamorous' with: [
				spec requires: #('Brick' ). ];
			package: #'Brick-Examples' with: [
				spec requires: #('Brick' 'Brick-Material' 'Brick-Glamorous' 'Brick-Hydra' ). ]. ].

]
