#import "NSSet+Combinatorics.h"

@implementation NSSet (Combinatorics)

- (NSSet*) permutations {
	return [self variationsOfSize:[self count]];
}

- (NSSet*) variationsOfSize:(NSUInteger)size {
	NSMutableSet* retVal = [[[NSMutableSet alloc] init] autorelease];

	if (size == 0) return [NSSet setWithObjects:[NSMutableArray array],nil];
	if (size == 1) {
		for (id i in self)
			[retVal addObject:[NSArray arrayWithObject:i]];
		return retVal;
	}
		
	for (id i in self) {
		NSMutableSet* tail = [[NSMutableSet alloc] initWithSet:self];
		[tail removeObject:i];

		NSSet* variations = [tail variationsOfSize:(size - 1)];
		
		for (NSArray* j in variations) {
			NSMutableArray* add = [[NSMutableArray alloc] initWithObjects:i, nil];
			[add addObjectsFromArray:j];
			[retVal addObject:add];
			[add release];
		}
		
		[tail release];
	}
	
	return retVal;
}

- (NSSet*) variationsWithRepetitionsOfSize:(NSUInteger)size {
	NSMutableSet* retVal = [[[NSMutableSet alloc] init] autorelease];
	
	if (size == 0) return [NSSet setWithObjects:[NSMutableArray array],nil];
	if (size == 1) {
		for (id i in self)
			[retVal addObject:[NSArray arrayWithObject:i]];
		return retVal;
	}
	
	for (id i in self) {
		NSMutableSet* tail = [[NSMutableSet alloc] initWithSet:self];
		
		NSSet* variations = [tail variationsWithRepetitionsOfSize:(size - 1)];
		
		for (NSArray* j in variations) {
			NSMutableArray* add = [[NSMutableArray alloc] initWithObjects:i, nil];
			[add addObjectsFromArray:j];
			[retVal addObject:add];
			[add release];
		}
		
		[tail release];
	}
	
	return retVal;
}

- (NSSet*) combinationsOfSize:(NSUInteger)size {
	if (size == 0) return [NSSet setWithObjects:[NSMutableSet set],nil];
	if ([self count] == 0) return self;
	
	NSSet* retVal;
	
	NSMutableSet* tail = [[NSMutableSet alloc] initWithSet:self];
	id head = [self anyObject];
	[tail removeObject:head];
	
	NSMutableSet* subSet = [[NSMutableSet alloc] initWithSet:[tail combinationsOfSize:(size - 1)]];
	
	for (NSMutableSet* i in subSet) {
		[i addObject:head];
	}
	
	[subSet unionSet:[tail combinationsOfSize:size]];
	
	retVal = [[[NSSet alloc] initWithSet:subSet] autorelease];
	
	[tail release];
	[subSet release];
	
	return retVal;
}

- (NSSet*) combinationsWithRepetitionsOfSize:(NSUInteger)size {
	if (size == 0) return [NSSet setWithObjects:[NSCountedSet set],nil];
	if ([self count] == 0) return self;
	
	NSSet* retVal;
	
	NSMutableSet* tail = [[NSMutableSet alloc] initWithSet:self];
	id head = [self anyObject];
	[tail removeObject:head];
	
	NSMutableSet* subSet = [[NSMutableSet alloc] initWithSet:[self combinationsWithRepetitionsOfSize:(size - 1)]];
	
	for (NSCountedSet* i in subSet) {
		[i addObject:head];
	}
	
	[subSet unionSet:[tail combinationsWithRepetitionsOfSize:size]];
	
	retVal = [[[NSSet alloc] initWithSet:subSet] autorelease];
	
	[tail release];
	[subSet release];
	
	return retVal;
}

- (NSSet*) combinationsOfSizesFromSize:(NSUInteger)smallestSize toSize:(NSUInteger)biggestSize {
	NSMutableSet *finalSet = [[NSMutableSet alloc] init];
	
	for (NSUInteger counter = smallestSize; counter < biggestSize + 1; counter++) {
		NSSet *tempSet = [self combinationsOfSize:counter];
		[finalSet addObjectsFromArray:[tempSet allObjects]];
	}
	
	return finalSet;
}

	// Convenience method that assumes all combination sizes from 1 to count of items in set.
- (NSSet*)combinations {
	return [self combinationsOfSizesFromSize:1 toSize:self.count];
}

@end
