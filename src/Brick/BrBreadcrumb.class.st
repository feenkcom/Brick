Class {
	#name : #BrBreadcrumb,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TBrLayoutAlignable',
	#classTraits : 'TBrLayoutResizable classTrait + TBrLayoutAlignable classTrait',
	#category : #'Brick-Breadcrumb - UI'
}

{ #category : #'api - adding / removing' }
BrBreadcrumb >> addItem: anElement [
	self viewModel addItem: anElement viewModel
]

{ #category : #'api - adding / removing' }
BrBreadcrumb >> addItems: aCollectionOfWidgets [
	aCollectionOfWidgets
		do: [ :aWidgetElement | self viewModel addItem: aWidgetElement viewModel ]
]

{ #category : #testing }
BrBreadcrumb >> hasItems [
	<return: #Boolean>
	
	^ self viewModel hasItems
]

{ #category : #initialization }
BrBreadcrumb >> initialize [
	super initialize.
	
	self alignCenterLeft.
	self fitContent.

	self viewModel: BrBreadcrumbModel new
]

{ #category : #accessing }
BrBreadcrumb >> itemAt: anIndex [
	<return: #BrWidgetModel>

	^ self viewModel itemAt: anIndex
]

{ #category : #accessing }
BrBreadcrumb >> numberOfItems [
	<return: #Number>

	^ self viewModel numberOfItems
]

{ #category : #'api - adding / removing' }
BrBreadcrumb >> removeAllItems [
	self viewModel removeAllItems
]

{ #category : #'api - adding / removing' }
BrBreadcrumb >> removeItem: anElement [
	self viewModel removeItem: anElement viewModel
]

{ #category : #'api - adding / removing' }
BrBreadcrumb >> removeItemAt: anIndex [
	self viewModel removeItemAt: anIndex
]
