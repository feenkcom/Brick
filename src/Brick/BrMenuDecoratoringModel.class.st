"
I am {{gtClass:BrMenuModel}}.
I decorate menu elements using {{gtMethod:BrMenuDecoratoringModel >> #decorator | label=#selector}}.
Element builders should not create new elements, but rather decorate existing elements. See, {{gtMethod:BrMenuElementBuilder>>#visitMenuDecoratingModel:}}. 
Menu elements do not know about me. I exists only in the {{gtClass:BrMenuModel}} hierarchy model.
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

{ #category : #accessing }
BrMenuDecoratoringModel >> elementMenuModel [
	^ self menuModel ifNotNil: #elementMenuModel
]

{ #category : #'event handling' }
BrMenuDecoratoringModel >> onMenuModelChanged [
	self menuModel parent: self
]
