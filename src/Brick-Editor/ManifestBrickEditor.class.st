"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBrickEditor,
	#superclass : #PackageManifest,
	#category : 'Brick-Editor-Manifest'
}

{ #category : #accessing }
ManifestBrickEditor class >> mustNotDependOn [
	^ { 
		'Brick'
	}
]

{ #category : #'code-critics' }
ManifestBrickEditor class >> ruleRBCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#BrTextEditorNavigator)) #'2018-12-14T14:42:28.622334+01:00') )
]

{ #category : #accessing }
ManifestBrickEditor class >> shouldValidateBaseline [
	^ true
]
