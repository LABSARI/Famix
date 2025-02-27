Class {
	#name : #FamixStMethod,
	#superclass : #FamixStNamedEntity,
	#traits : 'FamixStTCanBeClassSide + FamixTCanBeAbstract + FamixTHasKind + FamixTMethod + FamixTWithAnnotationTypes + FamixTWithComments',
	#classTraits : 'FamixStTCanBeClassSide classTrait + FamixTCanBeAbstract classTrait + FamixTHasKind classTrait + FamixTMethod classTrait + FamixTWithAnnotationTypes classTrait + FamixTWithComments classTrait',
	#instVars : [
		'#protocol => FMProperty'
	],
	#category : #'Famix-PharoSmalltalk-Entities-Entities'
}

{ #category : #meta }
FamixStMethod class >> annotation [

	<FMClass: #Method super: #FamixStNamedEntity>
	<package: #'Famix-PharoSmalltalk-Entities'>
	<generated>
	^self
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> accessedAttributes [
	
	"Returns the set of attributes of my class accessed by me (method). 
	Used to support the calculation of LCOM"
	
	^ (self queryOutgoingAccesses opposites withinParentUsing: FamixTClass) asSet select: #isAttribute
]

{ #category : #accessing }
FamixStMethod >> category [
	<FMProperty: #category type: #String>
	<FMComment: 'Category of the method'>
	
	^ self attributeAt: #category ifAbsentPut: [ nil ]
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> category: aString [

	self attributeAt: #category put: aString

	
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> compiledMethod [
	"Return the compiled method associated to the receiver or nil"
	
	^ self smalltalkClass compiledMethodAt: self name asSymbol
	
	
]

{ #category : #'Famix-Extensions-private' }
FamixStMethod >> computeCyclomaticComplexity [
	^ self isStub
		ifTrue: [ self notExistentMetricValue ]
		ifFalse: [ (RBVisitorForFAMIXMetrics for: self) cyclomaticNumber ]
]

{ #category : #'Famix-Extensions-private' }
FamixStMethod >> computeNumberOfConditionals [
	^ self isStub
		ifTrue: [ self notExistentMetricValue ]
		ifFalse: [ (RBVisitorForFAMIXMetrics for: self) numberOfConditionals ]
]

{ #category : #'Famix-Extensions-private' }
FamixStMethod >> computeNumberOfMessageSends [
	^ self isStub
		ifTrue: [ self notExistentMetricValue ]
		ifFalse: [ (RBVisitorForFAMIXMetrics for: self) numberOfMessageSends ]
]

{ #category : #'Famix-Extensions-private' }
FamixStMethod >> computeNumberOfStatements [
	^ self isStub
		ifTrue: [ self notExistentMetricValue ]
		ifFalse: [ (RBVisitorForFAMIXMetrics for: self) numberOfStatements ]
]

{ #category : #'Famix-Extensions-private' }
FamixStMethod >> hasEmptyBody [
	"Copied from FAMIX2.
	 The closest we can get in FAMIX2 to determine if a body is empty is to check if the method
	 performs no invocations and/or accesses. The only thing left to do would be the declaration
	 of local variables (that are not accesses afterwards).

	Note that an abstract method with only 'self subclassResponsibility' is not regarded as an 
	empty method in this scheme (which is questionable)."
	"note that the presence of statements should be checked too for that..."
	^ self numberOfAccesses = 0 and: [ self numberOfOutgoingInvocations = 0 ]
]

{ #category : #initialization }
FamixStMethod >> initialize [
	super initialize.
	isClassSide := false
]

{ #category : #'Famix-Extensions' }
FamixStMethod >> invokedBehaviours [
	^ self queryAllOutgoingInvocations opposites
]

{ #category : #'Famix-Extensions' }
FamixStMethod >> invokedMethods [
	<FMProperty: #invokedMethods type: #FamixStMethod> <derived> <multivalued>
	<FMComment: 'The methods invoked by the receiver'>
	
	^ self invokedBehaviours select: [ :each | each isMethod ]
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> isCalledInternally [
	^self incomingInvocations
		anySatisfy:
			[:each | each sender isMethod and: [each sender belongsTo == self belongsTo]]
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> isInitializer [
	^ (('*initialize*' match: self protocol) or: [ '*initialize*' match: self name ]) or: [ self isConstructor ] 
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> isInternalImplementation [
	<FMProperty: #isInternalImplementation type: #Boolean>
	<derived>
	<FMComment: 'Public Interface Layer Method'>

	^ (self isInitializer not and: [ self isCalledInternally ])
		and: [ self isPureAccessor not ]
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> isJUnit4Test [
	<FMProperty: #isJUnit4Test type: #Boolean>
	<derived>
	<FMComment: 'True if the method is considered as a Junit 4 Java test'>
	^ self isAnnotatedWith: 'Test'
]

{ #category : #testing }
FamixStMethod >> isOverriden [
	"If we have a stub and we don't have the container, we can't have the information"

	<FMProperty: #isOverriden type: #Boolean>
	<derived>
	<FMComment: 'The method is overrided in a sub class'>
	(self parentType isNil and: [ self isStub ])
		ifTrue: [ ^ false ].
	^ self parentType subclassHierarchyGroup
		anySatisfy: [ :each | each implements: self signature ]
]

{ #category : #testing }
FamixStMethod >> isOverriding [
	<FMProperty: #isOverriding type: #Boolean>
	<derived>
	<FMComment: 'The method is overrinding a method defined in a super class'>
	^ self parentType directSuperclasses
		anySatisfy: [ :each | each understands: self signature ]
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> isSurelyInvokedBy: aFAMIXMethod [
	| outgoingInvo |
	((self isAbstract or: [ aFAMIXMethod isAbstract ]) or: [ (outgoingInvo := aFAMIXMethod queryAllOutgoingInvocations) isEmpty ])
		ifFalse: [ outgoingInvo
				do: [ :invo | 
					(invo signature = self signature and: [ invo isASureInvocation ])
						ifTrue: [ | invocationRVar |
							invocationRVar := invo getReceivingFAMIXClass.
							(invocationRVar isNotNil and: [ (invocationRVar lookUp: self signature) = self ]) ifTrue: [ ^ true ] ] ] ].
	^ false
]

{ #category : #'Famix-Extensions-private' }
FamixStMethod >> numberOfAccesses [
	<FMProperty: #numberOfAccesses type: #Number>
	<derived>
	<FMComment: 'The number of accesses from a method'>
	
	^ self 
		lookUpPropertyNamed: #numberOfAccesses
		computedAs: [ self accesses size ]
]

{ #category : #'Famix-Extensions-private' }
FamixStMethod >> numberOfComments [
	<FMProperty: #numberOfComments type: #Number>
	<FMComment: 'The number of comment fragments'>
	<derived>
	^ self lookUpPropertyNamed: #numberOfComments computedAs: [ self comments size ]
]

{ #category : #'Famix-Extensions-private' }
FamixStMethod >> numberOfConditionals [
	<FMProperty: #numberOfConditionals type: #Number>
	<FMComment: 'The number of conditionals in a method'>
	^ self
		lookUpPropertyNamed: #numberOfConditionals
		computedAs: [ self computeNumberOfConditionals ]
]

{ #category : #'Famix-Extensions-private' }
FamixStMethod >> numberOfConditionals: aNumber [
	self cacheAt: #numberOfConditionals put: aNumber
]

{ #category : #'Famix-Extensions-private' }
FamixStMethod >> numberOfMessageSends [
	<FMProperty: #numberOfMessageSends type: #Number>
	<derived>
	<FMComment: 'The number of message from a method'>
	^ self
		lookUpPropertyNamed: #numberOfMessageSends
		computedAs: [ self computeNumberOfMessageSends ]
]

{ #category : #'Famix-Extensions-private' }
FamixStMethod >> numberOfStatements [
	<FMProperty: #numberOfStatements type: #Number>
	<FMComment: 'The number of statements in a method'>
	^ self
		lookUpPropertyNamed: #numberOfStatements
		computedAs: [ self computeNumberOfStatements ]
]

{ #category : #accessing }
FamixStMethod >> protocol [

	<FMProperty: #protocol type: #String>
	<generated>
	<FMComment: 'Protocol of the method'>
	^ protocol
]

{ #category : #accessing }
FamixStMethod >> protocol: anObject [
	<generated>
	protocol := anObject
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> smalltalkClass [ 
	"Return the smalltalk class associated with the receiver. Note that it may be different than doing self parentType because the class and metaclass can be merged."
	
	^   ('*_class' match: self parentType name)
			ifTrue: [self parentType smalltalkClass]
			ifFalse: [self isClassSide 
							ifTrue: [self parentType smalltalkClass class]
							ifFalse: [self parentType smalltalkClass]]
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> sourceText [
	self flag: 'This code should be delegated to the FAMIXPharoAnchor'.
	^ [ self compiledMethod sourceCode ]
		on: Error
		do: [ "probably class is not in the system" super sourceText ]
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> timeStamp [
	<FMProperty: #timeStamp type: #String>
	<FMComment: 'TimeStamp of the method with author and time of the last change'>
	<package: 'Smalltalk'>
	^ self attributeAt: #timeStamp ifAbsentPut: [ '' ]
]

{ #category : #'Famix-Extensions-metrics-support' }
FamixStMethod >> timeStamp: aTimeStamp [

	self attributeAt: #timeStamp put: aTimeStamp
]
