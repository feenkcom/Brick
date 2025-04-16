"
I am responsible for cleaning {{gtClass:BrMenuSteppedElement}} caches.
My subclasses may define what to clean after a menu hide action.
I am used by {{gtClass:BrWithExplicitPopoverAptitude}}. 

"
Class {
	#name : #BrPopoverCacheCleaner,
	#superclass : #Object,
	#category : #'Brick-Menu - Support'
}

{ #category : #'instance  creation' }
BrPopoverCacheCleaner class >> allCleaner [
	^ BrPopoverRemoveAllCacheCleaner new
]

{ #category : #'instance  creation' }
BrPopoverCacheCleaner class >> allKeeper [
	^ BrPopoverKeepAllCacheCleaner new
]

{ #category : #'api - cleaning' }
BrPopoverCacheCleaner >> cleanMenuContainer: aMenuContainer [
]
