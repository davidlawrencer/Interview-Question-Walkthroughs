import UIKit
/*
The Problem: Two Sum
Given an array of integers, return indices of the two numbers such that they add up to a specific target.
You may assume that each input would have exactly one solution, and you may not use the same element twice.
Example:
Given nums = [2, 7, 11, 15], target = 9,
Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].
 
 Approach:
 - Brute Force: use two for-loops to compare every number O(n^2)
        for i in nums
            for j in nums
                can't do this. we need the indices of those numbers in nums
    
    How can we get the indices for our for-loop? Enumerate
        for (index, value) in nums.enumerated() -> reminder, enumerated starts counting frm 0 , it's not actually referring to the indices but close 'nuff right now
    
    How do we know when we have our answer? We could subtract target - value in each iteration, and add it to a dictionary
    keys in dictionary are the remainder, and value is indices
 
    [numberWeGotFromMath: indexInOriginalArray]
 
    ex: [2, 7, 11, 15], target: 9
    
    first iteration: See if 2 is in our dict (it isn't)
                    add it to dictionary -> dict[target - value] = index
                    What is time complexity of lookup/write to dictionary? O(1) -> Constant time

    another approach (only slightly different) -> find the difference between target and the value we're looking at. look in the dictionary to see if that value exists, and if it does, the value we get from looking it up provides us with the index for this "compliment"
 
    [Int:Int] -> [valueInOriginalArray: indexInOriginalArray]

 
    1st: compliment 9 - 2 = 7. Not in dict. Add dict[2] = 0
    2nd: compliment 9 - 7 = 2. dict[2] exists (its value is 0), return [dict[2], index]
 
    // this approach with a dict to make a "memo" or a "past-facing guide" is pretty common in interview q's. i can "backtrack" in the array at each index of the iteration by using this dictionary. this won't work if the array has duplicate values.
    
    
 
 */

func twoSum(nums: [Int], target: Int) -> [Int] /*array with 2 indices in it*/ {
    // dictionary
    var dict = [Int:Int]()
    
    // alt: can use indexes by looping through a range, and looking at nums[i]
    // for i in 0..<nums.count {}
    
    // loop through enumerated array
    for (index,num) in nums.enumerated() { //(0,value1), (1,value2)
        // calculate the "compliment" -> the number that we add to num to get target
        let compliment = target - num
        
        // return if we find the compliment as a key in the dict
        if let complimentIndex = dict[compliment] { // we use binding as a way of both checking for nil, and then having that value as an unwrapped optional
            // the index stored in the dictionary, and the index of the number we're looking at currently.
            return [complimentIndex, index]
        }
        // if we don't find compliment in the dict, add the current value and its index to the dict. dict's keys are the numbers in the array, and its values are the indexes those numbers occurred at.
        dict[num] = index
    }
    // hacky: at the end, return empty array if we dont find anything
    return []
}

assert(twoSum(nums: [1,7,3,4], target: 5) == [0,3])
assert(twoSum(nums: [1,7,3,4], target: 7) == [2,3])
assert(twoSum(nums: [1,7,3,4,2,5,9], target: 16) == [1,6])
