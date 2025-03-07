"
I am {{gtClass:BrMenuModel}}.
I decorate menu elements using {{gtMethod:BrMenuDecoratoringModel >> #decorator | label=#selector}}.

"
Class {
	#name : #BrMenuDecoratoringModel,
	#superclass : #BrMenuModel,
	#traits : 'TBrMenuWithMenuModel',
	#classTraits : 'TBrMenuWithMenuModel classTrait',
	#instVars : [
		'decorator'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenuDecoratoringModel >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuDecoratingModel: self
]

{ #category : #accessing }
BrMenuDecoratoringModel >> decorator [
	"Return a block with one argument: [ :anElement | anElement ].
	The block receives a menu element which can be adjusted, 
	e.g., adding another aptitude."

	<return: #BlockClosure>
	^ decorator
]

{ #category : #accessing }
BrMenuDecoratoringModel >> decorator: aBlockClosure [
	"Set a block with one argument: [ :anElement | anElement ].
	The block receives a menu element which can be adjusted, 
	e.g., adding another aptitude."

	decorator := aBlockClosure
]
