Class {
	#name : #BrGlamorousBreadcrumbAptitude,
	#superclass : #BrBreadcrumbLinearAptitude,
	#category : #'Brick-Glamorous-Breadcrumb'
}

{ #category : #initialization }
BrGlamorousBreadcrumbAptitude >> initialize [
	super initialize.
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal alignCenterLeft ]
]
