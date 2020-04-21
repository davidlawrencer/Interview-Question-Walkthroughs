import UIKit

/*
 Single Number
 Given a non-empty array of integers, every element appears twice except for one. Find that single one.
 Note:
 Your algorithm should have a linear runtime complexity.
 // AHHHHH: Could you implement it without using extra memory?
 Example 1:
 Input: [2,2,1]
 Output: 1
 Example 2:
 Input: [4,1,2,1,2]
 Output: 4

 What do we know:
 - All elements appear *exactly* 2x, but one appears once.
 - Array won't be empty
 
 Approaches:
 - For loop iterating through. Use:
 - Dictionary: Keep track of freq. of numbers, look for key that has freq. of 1, return that key.
 - Alt Dict: Add key to the dictionary if there was no value for it, remove the value if there WAS a key. Remove key from dict? Want it to not be there at all -> set it nil. Remove value(for Key) fn also helps,
 - The freq would be 2 or 1 for any key in a dict. We're looking for 1. Once the freq is greater that 1, we can discard it.
 - Set: if something isn't in the set, add it. if something is in the set, remove it.
 - Think of it like turning a switch on/off.
 - In our Set solution, how do we know what the answer is? Only one thing will be in the set by the end of the problem.
 */
let inputOne = [2,2,1]
let inputTwo = [4,1,2,1,2]

func singleNumberSetSolution(_ arr: [Int]) -> Int {
    var set = Set<Int>()
    for i in arr {
//      OR:   if !set.contains(i) {
//            // put i into the set
//            set.insert(i)
//        } else {
//            set.remove(i)
//        }
        // These two return different things
        let _: Any = !set.contains(i) ? set.insert(i) : set.remove(i)

    }
    // how could we do that without a for-loop? higher-order array function.
    // map? reduce? filter? forEach?
    // reduce: we want to perform some operations on each element, while also keeping track of some "total" (generic intermediate Result)
    // forEach: goes through each item and "does something to it" -> doesn't change the array. how's it different than a map? map returns an array, forEach allows us to do something to the array.
    //    return whateverisleftintheset
    return set.first!
    
    
}

assert(singleNumberSetSolution(inputOne) == 1)
assert(singleNumberSetSolution(inputTwo) == 4)

func singleNumberManipulatingBits(_ arr: [Int]) -> Int {
    var result = 0
    // "Exclusive OR" or XOR operator -> wut??? Bitwise Manipulation: https://en.wikipedia.org/wiki/Bitwise_operation
    for i in arr {
        result ^= i
    }
    return result
}
