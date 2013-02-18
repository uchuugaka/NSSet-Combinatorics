#import <Foundation/Foundation.h>

@interface NSSet (Combinatorics)

- (NSSet*)permutations;

- (NSSet*)variationsOfSize:(NSUInteger)size;
- (NSSet*)variationsWithRepetitionsOfSize:(NSUInteger)size;

- (NSSet*)combinations;
- (NSSet*)combinationsOfSize:(NSUInteger)size;
- (NSSet*)combinationsWithRepetitionsOfSize:(NSUInteger)size;
- (NSSet*)combinationsOfSizesFromSize:(NSUInteger)smallestSize toSize:(NSUInteger)biggestSize;

@end
