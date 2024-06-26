Class {
	#name : #BrItemsProvider,
	#superclass : #Object,
	#instVars : [
		'listModel',
		'announcer',
		'userData'
	],
	#category : #'Brick-! Core - Item Providers'
}

{ #category : #'api - announcer' }
BrItemsProvider >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #converting }
BrItemsProvider >> asBrItemsProvider [
	^ self
]

{ #category : #accessing }
BrItemsProvider >> attachToListModel: aListModel [
	listModel := aListModel
]

{ #category : #'api - loading' }
BrItemsProvider >> bufferLoadingPromise [
	<return: #TAsyncPromise>

	^ true asAsyncPromise
]

{ #category : #accessing }
BrItemsProvider >> currentItems [
	^ self subclassResponsibility
]

{ #category : #'api - loading' }
BrItemsProvider >> finish [
]

{ #category : #accessing }
BrItemsProvider >> isDone [

	^ self subclassResponsibility
]

{ #category : #accessing }
BrItemsProvider >> itemAt: anIndex [
	^ self subclassResponsibility
]

{ #category : #accessing }
BrItemsProvider >> itemCount [
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'api - loading' }
BrItemsProvider >> itemSuchThat: aMatchBlock do: anActionBlock [
	"Attempt to find the first item matching a given block which may involve
	preloading items until such item is found"
	<return: #TAsyncPromise>

	^ ((self preloadUntilFoundSuchThat: aMatchBlock)
		then: [ :anIndex | self bufferLoadingPromise then: [ anIndex ] ])
		then: [ :anIndex :isSynchronous |
			anActionBlock cull: anIndex cull: isSynchronous.
			anIndex ]
]

{ #category : #accessing }
BrItemsProvider >> listModel [

	^ listModel
]

{ #category : #'private - notifying' }
BrItemsProvider >> notifyItemsChangedSynchronously: isSynchronous [
	listModel ifNotNil: [ :aListModel |
		aListModel dispatchEvent: (BrItemsProviderItemsChangedEvent new
			viewModel: aListModel;
			isSynchronous: isSynchronous) ]
]

{ #category : #'private - notifying' }
BrItemsProvider >> notifyItemsDone [
	self announce: (BrItemsProviderDoneEvent new itemsProvider: self).
	listModel ifNotNil: [ :aListModel | aListModel dispatchEvent: (BrItemsProviderDoneEvent new itemsProvider: self) ]
]

{ #category : #'private - notifying' }
BrItemsProvider >> notifyItemsLoaded: aCollectionOfNewItems at: anIndexOfTheFirstLoadedItem [
	self announce: (BrItemsProviderNewItemsLoadedEvent new
		itemsProvider: self;
		newItems: aCollectionOfNewItems;
		index: anIndexOfTheFirstLoadedItem)
]

{ #category : #'api - loading' }
BrItemsProvider >> preloadUntilFoundSuchThat: aBlock [
	<return: #TAsyncPromise>

	^ self subclassResponsibility
]

{ #category : #'api - announcer' }
BrItemsProvider >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #accessing }
BrItemsProvider >> userData [
	^ userData ifNil: [ userData := Dictionary new ]
]

{ #category : #'api - announcer' }
BrItemsProvider >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
BrItemsProvider >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (self when: anAnnouncementClass do: aBlock)
		subscriber: aSubscriber;
		yourself
]

{ #category : #'api - announcer' }
BrItemsProvider >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
