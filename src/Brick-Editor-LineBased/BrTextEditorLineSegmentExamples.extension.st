Extension { #name : #BrTextEditorLineSegmentExamples }

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_HelloCrWorld_0_to_5_to_be_0_to_11 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_HelloCrWorld_0_to_5.
	aSegment scopeText: 0 end: 11.
	
	self assert: aSegment textStart equals: 0.
	self assert: aSegment textEnd equals: 11.
	self assert: aSegment textInterval equals: (0 to: 11).
	self assert: aSegment textLength equals: 11.
	self assert: aSegment text asString equals: 'Hello', String cr, 'World'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_HelloCrWorld_0_to_5_to_be_0_to_5 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_HelloCrWorld_0_to_5.
	aSegment scopeText: 0 end: 5.
	
	self assert: aSegment textStart equals: 0.
	self assert: aSegment textEnd equals: 5.
	self assert: aSegment textInterval equals: (0 to: 5).
	self assert: aSegment textLength equals: 5.
	self assert: aSegment text asString equals: 'Hello'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_HelloCrWorld_0_to_5_to_be_0_to_6 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_HelloCrWorld_0_to_5.
	aSegment scopeText: 0 end: 6.
	
	self assert: aSegment textStart equals: 0.
	self assert: aSegment textEnd equals: 6.
	self assert: aSegment textInterval equals: (0 to: 6).
	self assert: aSegment textLength equals: 6.
	self assert: aSegment text asString equals: 'Hello', String cr.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_HelloCrWorld_0_to_5_to_be_1_to_5 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_HelloCrWorld_0_to_5.
	aSegment scopeText: 1 end: 5.
	
	self assert: aSegment textStart equals: 1.
	self assert: aSegment textEnd equals: 5.
	self assert: aSegment textInterval equals: (1 to: 5).
	self assert: aSegment textLength equals: 4.
	self assert: aSegment text asString equals: 'ello'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_HelloCrWorld_0_to_5_to_be_3_to_5 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_HelloCrWorld_0_to_5.
	aSegment scopeText: 3 end: 5.
	
	self assert: aSegment textStart equals: 3.
	self assert: aSegment textEnd equals: 5.
	self assert: aSegment textInterval equals: (3 to: 5).
	self assert: aSegment textLength equals: 2.
	self assert: aSegment text asString equals: 'lo'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_HelloCrWorld_6_to_11_to_be_0_to_11 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_HelloCrWorld_6_to_11.
	aSegment scopeText: 0 end: 11.
	
	self assert: aSegment textStart equals: 0.
	self assert: aSegment textEnd equals: 11.
	self assert: aSegment textInterval equals: (0 to: 11).
	self assert: aSegment textLength equals: 11.
	self assert: aSegment text asString equals: 'Hello', String cr, 'World'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_HelloCrWorld_6_to_11_to_be_6_to_11 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_HelloCrWorld_6_to_11.
	aSegment scopeText: 6 end: 11.
	
	self assert: aSegment textStart equals: 6.
	self assert: aSegment textEnd equals: 11.
	self assert: aSegment textInterval equals: (6 to: 11).
	self assert: aSegment textLength equals: 5.
	self assert: aSegment text asString equals: 'World'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_sub_HelloCrWorld_0_to_5_to_be_0_to_11 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_sub_HelloCrWorld_0_to_5.
	aSegment scopeText: 0 end: 11.
	
	self assert: aSegment textStart equals: 0.
	self assert: aSegment textEnd equals: 11.
	self assert: aSegment textInterval equals: (0 to: 11).
	self assert: aSegment textLength equals: 11.
	self assert: aSegment text asString equals: 'Hello', String cr, 'World'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_sub_HelloCrWorld_0_to_5_to_be_0_to_5 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_sub_HelloCrWorld_0_to_5.
	aSegment scopeText: 0 end: 5.
	
	self assert: aSegment textStart equals: 0.
	self assert: aSegment textEnd equals: 5.
	self assert: aSegment textInterval equals: (0 to: 5).
	self assert: aSegment textLength equals: 5.
	self assert: aSegment text asString equals: 'Hello'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_sub_HelloCrWorld_0_to_5_to_be_0_to_6 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_sub_HelloCrWorld_0_to_5.
	aSegment scopeText: 0 end: 6.
	
	self assert: aSegment textStart equals: 0.
	self assert: aSegment textEnd equals: 6.
	self assert: aSegment textInterval equals: (0 to: 6).
	self assert: aSegment textLength equals: 6.
	self assert: aSegment text asString equals: 'Hello', String cr.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_sub_HelloCrWorld_0_to_5_to_be_1_to_5 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_sub_HelloCrWorld_0_to_5.
	aSegment scopeText: 1 end: 5.
	
	self assert: aSegment textStart equals: 1.
	self assert: aSegment textEnd equals: 5.
	self assert: aSegment textInterval equals: (1 to: 5).
	self assert: aSegment textLength equals: 4.
	self assert: aSegment text asString equals: 'ello'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_sub_HelloCrWorld_0_to_5_to_be_3_to_5 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_sub_HelloCrWorld_0_to_5.
	aSegment scopeText: 3 end: 5.
	
	self assert: aSegment textStart equals: 3.
	self assert: aSegment textEnd equals: 5.
	self assert: aSegment textInterval equals: (3 to: 5).
	self assert: aSegment textLength equals: 2.
	self assert: aSegment text asString equals: 'lo'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_sub_HelloCrWorld_6_to_11_to_be_0_to_11 [
	<gtExample>
	| aSegment |

	aSegment := self segment_sub_HelloCrWorld_6_to_11.
	aSegment scopeText: 0 end: 11.

	self assert: aSegment textStart equals: 0.
	self assert: aSegment textEnd equals: 11.
	self assert: aSegment textInterval equals: (0 to: 11).
	self assert: aSegment textLength equals: 11.
	self assert: aSegment text asString equals: 'Hello', String cr, 'World'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> scope_segment_sub_HelloCrWorld_6_to_11_to_be_6_to_11 [
	<gtExample>
	| aSegment |
	
	aSegment := self segment_sub_HelloCrWorld_6_to_11.
	aSegment scopeText: 6 end: 11.
	
	self assert: aSegment textStart equals: 6.
	self assert: aSegment textEnd equals: 11.
	self assert: aSegment textInterval equals: (6 to: 11).
	self assert: aSegment textLength equals: 5.
	self assert: aSegment text asString equals: 'World'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> segment_HelloCrWorld_0_to_5 [
	<gtExample>
	| aSegment |
	
	aSegment := BrTextEditorLineSegment new.
	aSegment initializeWith: (self text_HelloCrWorld from: 1 to: 5) from: 0 to: 5 delimiter: 1.
	
	self assert: aSegment textStart equals: 0.
	self assert: aSegment textEnd equals: 5.
	self assert: aSegment textInterval equals: (0 to: 5).
	self assert: aSegment textLength equals: 5.
	self assert: aSegment text asString equals: 'Hello'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> segment_HelloCrWorld_6_to_11 [
	<gtExample>
	| aSegment |

	aSegment := BrTextEditorLineSegment new.
	aSegment initializeWith: (self text_HelloCrWorld from: 7 to: 11) from: 6 to: 11 delimiter: 0.

	self assert: aSegment textStart equals: 6.
	self assert: aSegment textEnd equals: 11.
	self assert: aSegment textInterval equals: (6 to: 11).
	self assert: aSegment textLength equals: 5.
	self assert: aSegment text asString equals: 'World'.

	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> segment_sub_HelloCrWorld_0_to_5 [
	<gtExample>
	| aSegment |
	
	aSegment := BrTextEditorLineSegment new.
	aSegment initializeWith: (self text_sub_HelloCrWorld from: 1 to: 5) from: 0 to: 5 delimiter: 1.
	
	self assert: aSegment textStart equals: 0.
	self assert: aSegment textEnd equals: 5.
	self assert: aSegment textInterval equals: (0 to: 5).
	self assert: aSegment textLength equals: 5.
	self assert: aSegment text asString equals: 'Hello'.
	
	^ aSegment
]

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorLineSegmentExamples >> segment_sub_HelloCrWorld_6_to_11 [
	<gtExample>
	| aSegment |

	aSegment := BrTextEditorLineSegment new.
	aSegment initializeWith: (self text_sub_HelloCrWorld from: 7 to: 11) from: 6 to: 11 delimiter: 0.

	self assert: aSegment textStart equals: 6.
	self assert: aSegment textEnd equals: 11.
	self assert: aSegment textInterval equals: (6 to: 11).
	self assert: aSegment textLength equals: 5.
	self assert: aSegment text asString equals: 'World'.

	^ aSegment
]
