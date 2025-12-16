Class {
	#name : #BrSearchFoundItemsWish,
	#superclass : #BrSearchWish,
	#instVars : [
		'marker',
		'context',
		'foundItems',
		'cache'
	],
	#category : #'Brick-List - Search Events'
}

{ #category : #accessing }
BrSearchFoundItemsWish >> cache [
	^ cache
]

{ #category : #accessing }
BrSearchFoundItemsWish >> cache: anObject [
	cache := anObject
]

{ #category : #accessing }
BrSearchFoundItemsWish >> cacheDo: aBlock [
	^ cache ifNotNil: aBlock
]

{ #category : #accessing }
BrSearchFoundItemsWish >> context [
	^ context
]

{ #category : #accessing }
BrSearchFoundItemsWish >> context: anObject [
	context := anObject
]

{ #category : #accessing }
BrSearchFoundItemsWish >> foundItems [
	<return: #Array of: #BrSearchFoundItem>
	^ foundItems ifNil: [ #() ]
]

{ #category : #accessing }
BrSearchFoundItemsWish >> foundItems: aCollection [
	foundItems := aCollection
]

{ #category : #accessing }
BrSearchFoundItemsWish >> marker [
	^ marker
]

{ #category : #accessing }
BrSearchFoundItemsWish >> marker: anObject [
	marker := anObject
]
