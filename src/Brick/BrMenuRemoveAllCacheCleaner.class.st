"
I clean all caches.
"
Class {
	#name : #BrMenuRemoveAllCacheCleaner,
	#superclass : #BrMenuCacheCleaner,
	#category : #'Brick-Pager - Support'
}

{ #category : #'api - cleaning' }
BrMenuRemoveAllCacheCleaner >> cleanMenuContainer: aMenuContainer [
	aMenuContainer hide
]
