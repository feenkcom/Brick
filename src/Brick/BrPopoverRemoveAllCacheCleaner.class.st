"
I clean all caches.
"
Class {
	#name : #BrPopoverRemoveAllCacheCleaner,
	#superclass : #BrPopoverCacheCleaner,
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - cleaning' }
BrPopoverRemoveAllCacheCleaner >> cleanMenuContainer: aMenuContainer [
	aMenuContainer hide
]
