"
g := FamixCompatibilityGenerator  new.
g builder traitsFlattening: true.
g generateWithoutCleaning.
FamixCompatibilityGenerator resetMetamodel.
"
Class {
	#name : #FamixCompatibilityGenerator,
	#superclass : #FamixBasicInfrastructureGenerator,
	#instVars : [
		'access',
		'annotationInstance',
		'annotationInstanceAttribute',
		'annotationType',
		'annotationTypeAttribute',
		'attribute',
		'behaviouralEntity',
		'cFile',
		'cPPSourceLanguage',
		'cSourceLanguage',
		'cUSTOMSourceLanguage',
		'caughtException',
		'class',
		'compilationUnit',
		'containerEntity',
		'declaredException',
		'dereferencedInvocation',
		'enum',
		'enumValue',
		'exception',
		'function',
		'globalVariable',
		'header',
		'implicitVariable',
		'include',
		'inheritance',
		'invocation',
		'jAVASourceLanguage',
		'leafEntity',
		'localVariable',
		'method',
		'module',
		'namespace',
		'package',
		'parameter',
		'parameterType',
		'parameterizableClass',
		'parameterizedType',
		'pharoAnchor',
		'preprocessorDefine',
		'preprocessorIfdef',
		'preprocessorStatement',
		'primitiveType',
		'reference',
		'sMALLTALKSourceLanguage',
		'scopingEntity',
		'structuralEntity',
		'thrownException',
		'type',
		'typeAlias',
		'unknownVariable',
		'trait',
		'traitUsage',
		'abstractFileAnchor',
		'file',
		'fileAnchor',
		'folder',
		'indexedFileAnchor',
		'multipleFileAnchor',
		'tCanBeVolatile',
		'tCanBeSynchronized',
		'tCanBeTransient',
		'tCanBeClassSide'
	],
	#category : #'Famix-Compatibility-Generator'
}

{ #category : #accessing }
FamixCompatibilityGenerator class >> packageName [

	^ #'Famix-Compatibility-Entities'
]

{ #category : #accessing }
FamixCompatibilityGenerator class >> packageNameForAnnotations [

	^ #'FAMIX'
]

{ #category : #accessing }
FamixCompatibilityGenerator class >> prefix [

	^ #'FAMIX'
]

{ #category : #accessing }
FamixCompatibilityGenerator class >> translationDictionary [

	| classNames associations |

	classNames := 'Famix-Compatibility-Entities' asPackage definedClasses collect: [:e | e name withoutPrefix: 'FAMIX' ].
	
	associations := classNames collect: [ :each | ('FAMIX.', each) -> ('FAMIX.', each) ] as: OrderedCollection.

	^ Dictionary newFrom: associations.	
]

{ #category : #comments }
FamixCompatibilityGenerator >> commentForTCanBeSynchronized [
	^ 'I allow an entity to be synchronized
ex:

```java
public class SynchronizedCounter {
    private int c = 0;

    public synchronized void increment() {
        c++;
    }
}
```'
]

{ #category : #comments }
FamixCompatibilityGenerator >> commentForTCanBeTransient [
	^ 'I allow an entity to be transient
ex:

```java
public class Student implements Serializable{  
 transient int age; //Now it will not be serialized  
}  
```'
]

{ #category : #comments }
FamixCompatibilityGenerator >> commentForTCanBeVolatile [
	^ 'I allow an entity to be volatible
ex:

```java
public class SharedObject {
    public volatile int counter = 0;
}
```'
]

{ #category : #definition }
FamixCompatibilityGenerator >> defineClasses [

	super defineClasses.

	access := builder newClassNamed: #Access.
	annotationInstance := builder newClassNamed: #AnnotationInstance.
	annotationInstanceAttribute := builder newClassNamed: #AnnotationInstanceAttribute.
	annotationType := builder newClassNamed: #AnnotationType.
	annotationTypeAttribute := builder newClassNamed: #AnnotationTypeAttribute.
	attribute := builder newClassNamed: #Attribute.
	behaviouralEntity := builder newClassNamed: #BehaviouralEntity.
	cFile := builder newClassNamed: #CFile.
	cPPSourceLanguage := builder newClassNamed: #CppSourceLanguage.
	cSourceLanguage := builder newClassNamed: #CSourceLanguage.
	cUSTOMSourceLanguage := builder newClassNamed: #CustomSourceLanguage.
	caughtException := builder newClassNamed: #CaughtException.
	class := builder newClassNamed: #Class.
	compilationUnit := builder newClassNamed: #CompilationUnit.
	containerEntity := builder newClassNamed: #ContainerEntity.
	declaredException := builder newClassNamed: #DeclaredException.
	dereferencedInvocation := builder newClassNamed: #DereferencedInvocation.
	enum := builder newClassNamed: #Enum.
	enumValue := builder newClassNamed: #EnumValue.
	exception := builder newClassNamed: #Exception.
	function := builder newClassNamed: #Function.
	globalVariable := builder newClassNamed: #GlobalVariable.
	header := builder newClassNamed: #Header.
	implicitVariable := builder newClassNamed: #ImplicitVariable.
	include := builder newClassNamed: #Include.
	inheritance := builder newClassNamed: #Inheritance.
	invocation := builder newClassNamed: #Invocation.
	jAVASourceLanguage := builder newClassNamed: #JavaSourceLanguage.
	leafEntity := builder newClassNamed: #LeafEntity.
	localVariable := builder newClassNamed: #LocalVariable.
	method := builder newClassNamed: #Method.
	module := builder newClassNamed: #Module.
	namespace := builder newClassNamed: #Namespace.
	package := builder newClassNamed: #Package.
	parameter := builder newClassNamed: #Parameter.
	parameterType := builder newClassNamed: #ParameterType.
	parameterizableClass := builder newClassNamed: #ParameterizableClass.
	parameterizedType := builder newClassNamed: #ParameterizedType.
	pharoAnchor := builder newClassNamed: #PharoAnchor.
	preprocessorDefine := builder newClassNamed: #PreprocessorDefine.
	preprocessorIfdef := builder newClassNamed: #PreprocessorIfdef.
	preprocessorStatement := builder newClassNamed: #PreprocessorStatement.
	primitiveType := builder newClassNamed: #PrimitiveType.
	reference := builder newClassNamed: #Reference.
	sMALLTALKSourceLanguage := builder newClassNamed: #SmalltalkSourceLanguage.
	scopingEntity := builder newClassNamed: #ScopingEntity.
	structuralEntity := builder newClassNamed: #StructuralEntity.
	thrownException := builder newClassNamed: #ThrownException.
	type := builder newClassNamed: #Type.
	typeAlias := builder newClassNamed: #TypeAlias.
	unknownVariable := builder newClassNamed: #UnknownVariable.
	trait := builder newClassNamed: #Trait.
	traitUsage := builder newClassNamed: #TraitUsage.
	
	
	abstractFileAnchor := builder newClassNamed: #AbstractFileAnchor.
	file := builder newClassNamed: #File.
	fileAnchor := builder newClassNamed: #FileAnchor.
	folder := builder newClassNamed: #Folder.
	indexedFileAnchor := builder newClassNamed: #IndexedFileAnchor.
	multipleFileAnchor := builder newClassNamed: #MultipleFileAnchor.

	primitiveType withTesting


]

{ #category : #definition }
FamixCompatibilityGenerator >> defineHierarchy [

	super defineHierarchy.
	
	access --|> #TAccess.

	annotationInstance --|> sourcedEntity.
	annotationInstance --|> #TAnnotationInstance.
	annotationInstance --|> #TWithAnnotationInstanceAttributes.
	annotationInstance --|> #TTypedAnnotationInstance.

	annotationInstanceAttribute --|> sourcedEntity.
	annotationInstanceAttribute --|> #TAnnotationInstanceAttribute.
	annotationInstanceAttribute --|> #TTypedAnnotationInstanceAttribute.

	annotationType --|> type.
	annotationType --|> #TAnnotationType.

	annotationTypeAttribute --|> attribute.
	annotationTypeAttribute --|> #TAnnotationTypeAttribute.
	annotationTypeAttribute --|> #TTypedAnnotationInstanceAttribute.

	attribute --|> structuralEntity.
	attribute --|> #TAttribute.
	attribute --|> tCanBeVolatile.
	attribute --|> tCanBeTransient.
	attribute --|> tCanBeClassSide.

	behaviouralEntity --|> containerEntity.
	behaviouralEntity --|> #TWithParameters.
	behaviouralEntity --|> #TInvocable.
	behaviouralEntity --|> #TWithReferences.
	behaviouralEntity --|> #TTypedEntity.
	behaviouralEntity --|> #TWithLocalVariables.
	behaviouralEntity --|> #TWithImplicitVariables.
	behaviouralEntity --|> #TWithDereferencedInvocations.
	behaviouralEntity --|> #THasSignature.
	behaviouralEntity --|> #TWithStatements.

	cFile --|> file.
	cFile --|> #TWithFileIncludes.

	cPPSourceLanguage --|> cSourceLanguage.

	cSourceLanguage --|> sourceLanguage.

	cUSTOMSourceLanguage --|> sourceLanguage.
	cUSTOMSourceLanguage --|> #TNamedEntity.

	caughtException --|> exception.
	caughtException --|> #TCaughtException.

	class --|> type.
	class --|> #TWithExceptions.
	class --|> #TClass.
	class --|> tCanBeClassSide. 
		
	compilationUnit --|> cFile.
	compilationUnit --|> #TCompilationUnit.
	compilationUnit --|> #TDefinedInModule.

	containerEntity --|> namedEntity.
	containerEntity --|> #TWithClasses.
	containerEntity --|> #TWithFunctions.
	containerEntity --|> #TWithAnnotationTypes.
	containerEntity --|> #TOODependencyQueries.

	declaredException --|> exception.
	declaredException --|> #TDeclaredException.

	dereferencedInvocation --|> invocation.
	dereferencedInvocation --|> #TDereferencedInvocation.

	enum --|> type.
	enum --|> #TEnum.

	enumValue --|> structuralEntity.
	enumValue --|> #TEnumValue.

	exception --|> #TException.

	function --|> behaviouralEntity.
	function --|> #TFunction.
	function --|> #TDefinedInModule.

	globalVariable --|> structuralEntity.
	globalVariable --|> #TGlobalVariable.
	globalVariable --|> #TDefinedInModule.

	header --|> cFile.
	header --|> #THeader.

	implicitVariable --|> structuralEntity.
	implicitVariable --|> #TImplicitVariable.

	include --|> #TFileInclude.

	inheritance --|> #TInheritance.

	invocation --|> #TInvocation.
	invocation --|> #THasSignature.

	jAVASourceLanguage --|> sourceLanguage.

	leafEntity --|> namedEntity.

	localVariable --|> structuralEntity.
	localVariable --|> #TLocalVariable.

	method --|> behaviouralEntity.
	method --|> #TMethod.
	method --|> #TWithThrownExceptions.
	method --|> #TWithDeclaredExceptions.
	method --|> #TWithCaughtExceptions.
	method --|> 	#THasKind.
	method --|> tCanBeSynchronized.
	method --|> tCanBeClassSide.

	module --|> scopingEntity.
	module --|> #TModule.
	module --|> #TWithCompilationUnits.
	module --|> #TWithHeaders.

	namedEntity --|> #TPackageable.
	namedEntity --|> #TInvocationsReceiver.
	namedEntity --|> #TWithAnnotationInstances.
	namedEntity --|> #THasVisibility.
	namedEntity --|> #TCanBeAbstract.
	namedEntity --|> #TCanBeFinal.

	namespace --|> scopingEntity.
	namespace --|> #TNamespace.

	package --|> containerEntity.
	package --|> #TPackage.
	package --|> #TWithGlobalVariables.
	package --|> #TCohesionCouplingMetrics.

	parameter --|> structuralEntity.
	parameter --|> #TParameter.

	parameterType --|> type.
	parameterType --|> #TParameterType.

	parameterizableClass --|> class.
	parameterizableClass --|> #TWithParameterizedTypes.

	parameterizedType --|> type.
	parameterizedType --|> #TParameterizedType.
	parameterizedType --|> #TWithParameterizedTypeUsers.

	pharoAnchor --|> sourceAnchor.

	preprocessorDefine --|> preprocessorStatement.
	preprocessorDefine --|> #TPreprocessorIfdef.

	preprocessorIfdef --|> preprocessorStatement.

	preprocessorStatement --|> sourcedEntity.

	primitiveType --|> type.
	primitiveType --|> #TPrimitiveType.

	reference --|> #TReference.

	sMALLTALKSourceLanguage --|> sourceLanguage.

	scopingEntity --|> containerEntity.
	scopingEntity --|> #TWithGlobalVariables.

	structuralEntity --|> leafEntity.
	structuralEntity --|> #TStructuralEntity.
	structuralEntity --|> #TWithDereferencedInvocations.

	thrownException --|> exception.
	thrownException --|> #TThrownException.

	type --|> containerEntity.
	type --|> #TType.
	type --|> #TWithTypeAliases.
	type --|> #TWithMethods.
	type --|> #TWithInheritances.
	type --|> #TWithAttributes.
	type --|> #TParameterizedTypeUser.
	type --|> #TTraitUser. 

	typeAlias --|> type.
	typeAlias --|> #TTypeAlias.

	unknownVariable --|> structuralEntity.
	unknownVariable --|> #TUnknownVariable.
	
	trait --|> type.
	trait --|> #TTrait.
	
	traitUsage --|> #TTraitUsage.
	
	abstractFileAnchor --|> sourceAnchor.
	abstractFileAnchor --|> #TFileAnchor.

	file --|> namedEntity.
	file --|> #TFile.

	fileAnchor --|> abstractFileAnchor.
	fileAnchor --|> #TFileNavigation.

	folder --|> namedEntity.
	folder --|> #TFolder.

	indexedFileAnchor --|> abstractFileAnchor.
	indexedFileAnchor --|> #TIndexedFileNavigation.

	multipleFileAnchor --|> sourceAnchor.
	multipleFileAnchor --|> #TMultipleFileAnchor.

	sourcedEntity
		--|> #TWithSourceLanguages ;
		--|> #TWithFiles ;
		--|> #TWithComments
	

]

{ #category : #definition }
FamixCompatibilityGenerator >> defineProperties [
	super defineProperties.
	((scopingEntity property: #parentScope)
			comment: 'Parent scope embedding this scope, if any.';
			container)
		*-
	((scopingEntity property: #childScopes)
			comment: 'Child scopes embedded in this scope, if any.').
			
	((tCanBeVolatile property: #isVolatile type: #Boolean) 
		comment: 'Entity can be declared volatile').
	((tCanBeTransient property: #isTransient type: #Boolean) 
		comment: 'Entity can be declared transient').
	((tCanBeSynchronized property: #isSynchronized type: #Boolean) 
		comment: 'Entity can be declared synchronized').
		((tCanBeClassSide property: #isClassSide type: #Boolean) 
		comment: 'Entity can be declared class side i.e. static')
]

{ #category : #definition }
FamixCompatibilityGenerator >> defineTraits [
	super defineTraits.
	tCanBeVolatile := builder newTraitNamed: #TCanBeVolatile comment: self commentForTCanBeVolatile.
	tCanBeTransient := builder newTraitNamed: #TCanBeTransient comment: self commentForTCanBeTransient.
	tCanBeSynchronized := builder newTraitNamed: #TCanBeSynchronized comment: self commentForTCanBeSynchronized.
	tCanBeClassSide := builder newTraitNamed: #TCanBeClassSide.
]

{ #category : #definition }
FamixCompatibilityGenerator >> newBuilder [
	^ super newBuilder
		withImportingContext;
		yourself
]
