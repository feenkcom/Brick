"
I am responsible for cleaning {{gtClass:BrMenuSteppedElement}} caches.
My subclasses may define what to clean after a menu hide action.
I am used by {{gtClass:BrWithExplicitMenuAptitude}}. 

"
Class {
	#name : #BrMenuCacheCleaner,
	#superclass : #Object,
	#category : #'Brick-Pager - Support'
}

{ #category : #'instance  creation' }
BrMenuCacheCleaner class >> allCleaner [
	^ BrMenuRemoveAllCacheCleaner new
]

{ #category : #'instance  creation' }
BrMenuCacheCleaner class >> allKeeper [
	^ BrMenuKeepAllCacheCleaner new
]

{ #category : #'api - cleaning' }
BrMenuCacheCleaner >> cleanMenuContainer: aMenuContainer [
]
