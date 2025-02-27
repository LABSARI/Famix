Class {
	#name : #FamixJavaClass,
	#superclass : #FamixJavaType,
	#traits : 'FamixJavaTCanBeClassSide + FamixJavaTClassMetrics + FamixTCanBeAbstract + FamixTCanBeFinal + FamixTClass + FamixTClassMetrics + FamixTHasVisibility + FamixTLCOMMetrics + FamixTPackageable + FamixTWithComments + FamixTWithExceptions',
	#classTraits : 'FamixJavaTCanBeClassSide classTrait + FamixJavaTClassMetrics classTrait + FamixTCanBeAbstract classTrait + FamixTCanBeFinal classTrait + FamixTClass classTrait + FamixTClassMetrics classTrait + FamixTHasVisibility classTrait + FamixTLCOMMetrics classTrait + FamixTPackageable classTrait + FamixTWithComments classTrait + FamixTWithExceptions classTrait',
	#category : #'Famix-Java-Entities-Entities'
}

{ #category : #meta }
FamixJavaClass class >> annotation [

	<FMClass: #Class super: #FamixJavaType>
	<package: #'Famix-Java-Entities'>
	<generated>
	^self
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixJavaClass >> accessedAttributes [
	
	"Returns my attributes accessed by my methods. If the same attribute is accessed 
	by two different methods it is counted twice.
	Used to support the calculation of LCOM"
	
	^ self methodsWithoutSutbsAndConstructors asOrderedCollection flatCollect: [ :method | method accessedAttributes ]
]

{ #category : #accessing }
FamixJavaClass >> incomingAccesses [
	^ self 
		cacheAt: #incomingAccesses
		ifAbsentPut: [ attributes flatCollect: [ :each | each incomingAccesses ] ]
]

{ #category : #testing }
FamixJavaClass >> isADirectSubclassOf: aClass [
	^ aClass class = FamixJavaClass
		ifTrue: [ aClass directSubclasses includes: self ]
		ifFalse: [ false ]
]

{ #category : #testing }
FamixJavaClass >> isADirectSuperclassOf: aClass [
	^ aClass class = FamixJavaClass
		ifTrue: [ aClass superclass = self ]
		ifFalse: [ false ]
]

{ #category : #testing }
FamixJavaClass >> isASubclassOf: aClass [ 
	 
	^aClass class = FamixJavaClass 
		ifTrue: [aClass subclassHierarchyGroup includes: self] 
		ifFalse: [false]
]

{ #category : #testing }
FamixJavaClass >> isASuperclassOf: aClass [ 
	 
	^aClass class = FamixJavaClass 
		ifTrue: [aClass superclassHierarchyGroup includes: self] 
		ifFalse: [false]
]

{ #category : #testing }
FamixJavaClass >> isAccessedBy: anAccess [ 
	 
	^anAccess accesses == self
]

{ #category : #testing }
FamixJavaClass >> isIgnored [
	<FMProperty: #isIgnored type: #Boolean>
	<multivalued>
	<derived>
	<FMComment:
		'If the class is a test class, it can be annotated with Ignore, all the tests of contained are bypassed'>
	^ (self isAnnotatedWith: 'Ignore') 
]

{ #category : #testing }
FamixJavaClass >> isInheritedBy: anInheritance [ 
	 
	^anInheritance superclass == self
]

{ #category : #testing }
FamixJavaClass >> isInterface [

	<FMProperty: #isInterface type: #Boolean>
	<FMComment: 'This is a boolean flag used to distinguish between classes with implementation and interfaces'>

	^ self attributeAt: #isInterface ifAbsent: [ false ]
]

{ #category : #testing }
FamixJavaClass >> isInterface: aBoolean [

	^ self attributeAt: #isInterface put: true
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixJavaClass >> methodsWithoutSutbsAndConstructors [

	"Removing stub and contructor methods. Used to support the calculation of LCOM."
	
	^ (self methods select: [ :each | 
		each isStub not and: [each isConstructor not]]) asSet
]

{ #category : #accessing }
FamixJavaClass >> numberOfComments [
	"Overrides to include method comments in the numberOfComments of the class"
	^ self
		lookUpPropertyNamed: #numberOfComments
		computedAs: [ self children asArray
			inject: self comments size into: [ :sum :child | child numberOfComments + sum ] ]

]

{ #category : #'Famix-Extensions' }
FamixJavaClass >> structuralChildren [
	^ (OrderedCollection withAll: self methods), self attributes
]
