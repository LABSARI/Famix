Trait {
	#name : #FamixTClassMetrics,
	#category : #'Famix-Traits-Class'
}

{ #category : #meta }
FamixTClassMetrics classSide >> annotation [

	<FMClass: #TClassMetrics super: #Object>
	<package: #'Famix-Traits'>
	<generated>
	^self
]

{ #category : #metrics }
FamixTClassMetrics >> numberOfLocallyDefinedMethods [

	<FMProperty: #numberOfLocallyDefinedMethods type: #Number>
	<derived>
	<FMComment:
	'The number of methods in a class added with respect to super classes'>
	^ self
		  lookUpPropertyNamed: #numberOfLocallyDefinedMethods
		  computedAs: [ self addedMethods size ]
]

{ #category : #metrics }
FamixTClassMetrics >> numberOfLocallyDefinedMethods: aNumber [

	self cacheAt: #numberOfLocallyDefinedMethods put: aNumber
]

{ #category : #metrics }
FamixTClassMetrics >> numberOfMethodsAdded [

	self
		deprecated: 'Use #numberOfLocallyDefinedMethods instead.'
		transformWith: '`@receiver numberOfMethodsAdded'
			-> '`@receiver numberOfLocallyDefinedMethods'.
	^ self numberOfLocallyDefinedMethods
]

{ #category : #metrics }
FamixTClassMetrics >> numberOfMethodsAdded: aNumber [

	self
		deprecated: 'Use #numberOfLocallyDefinedMethods: instead.'
		transformWith: '`@receiver numberOfMethodsAdded: `@arg'
			-> '`@receiver numberOfLocallyDefinedMethods: `@arg'.
	^ self numberOfLocallyDefinedMethods: aNumber
]

{ #category : #metrics }
FamixTClassMetrics >> numberOfMethodsInHierarchy [
	<FMProperty: #numberOfMethodsInHierarchy type: #Number>
	<derived>
	<FMComment: 'The number of methods of a class included the inherited ones'>	
	
	| totNom |
	totNom := self methods size.
	self superclassHierarchyGroup
		do: [:aClass | totNom := totNom + aClass methods size].
	^totNom
]

{ #category : #metrics }
FamixTClassMetrics >> numberOfMethodsInHierarchy: aNumber [
	self cacheAt: #numberOfMethodsInHierarchy put: aNumber
]

{ #category : #metrics }
FamixTClassMetrics >> numberOfMethodsInherited [
	<FMProperty: #numberOfMethodsInherited type: #Number>
	<derived>
	<FMComment: 'The number of methods in a class inherited from super classes'>	

	^self
		lookUpPropertyNamed: #numberOfMethodsInherited
		computedAs: [self inheritedMethods size]
]

{ #category : #metrics }
FamixTClassMetrics >> numberOfMethodsInherited: aNumber [
	self cacheAt: #numberOfMethodsInherited put: aNumber
]