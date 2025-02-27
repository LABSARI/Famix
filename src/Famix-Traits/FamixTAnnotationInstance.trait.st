"
AnnotationInstance is an instance of an AnnotationType. It links an AnnotationType to an actual entity.

For example, the following is an annotation instance in Smalltalk.
<primitive: 'primAnyBitFromTo' module:'LargeIntegers'>.

And the following is an AnnotationInstance in Java:
@Test(timeout = 500)

Instance Variables:
	annotatedEntity	<FAMIXEntity>
	annotationType		<FAMIXAnnotationType>
"
Trait {
	#name : #FamixTAnnotationInstance,
	#instVars : [
		'#annotatedEntity => FMOne type: #FamixTWithAnnotationInstances opposite: #annotationInstances'
	],
	#traits : 'TEntityMetaLevelDependency',
	#classTraits : 'TEntityMetaLevelDependency classTrait',
	#category : #'Famix-Traits-AnnotationInstance'
}

{ #category : #meta }
FamixTAnnotationInstance classSide >> annotation [

	<FMClass: #TAnnotationInstance super: #Object>
	<package: #'Famix-Traits'>
	<generated>
	^self
]

{ #category : #groups }
FamixTAnnotationInstance classSide >> annotationFamixAnnotationInstanceGroup [
	<generated>
	<mooseGroup>
	^ FamixAnnotationInstanceGroup
]

{ #category : #accessing }
FamixTAnnotationInstance >> annotatedEntity [
	"Relation named: #annotatedEntity type: #FamixTWithAnnotationInstances opposite: #annotationInstances"

	<generated>
	<FMComment: 'The NamedEntity on which the annotation occurs.'>
	^ annotatedEntity
]

{ #category : #accessing }
FamixTAnnotationInstance >> annotatedEntity: anObject [

	<generated>
	annotatedEntity := anObject
]

{ #category : #printing }
FamixTAnnotationInstance >> displayStringOn: aStream [

	self annotationType displayStringOn: aStream.
	aStream << ' on '.
	self annotatedEntity displayStringOn: aStream
]
