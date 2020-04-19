/*

Happy Number: Write an algorithm to determine if a number n is “happy”. Return a bool
 
A “happy number” is a number defined by the following process: Starting with any positive integer, replace the number by the SUM OF ITS SQUARES of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers.
Return True if n is a happy number, and False if not.

 Key aspects:
 - num must be positive
 - split it into its individual digits, square each digits, and sum the result of squaring each
 - approaches to split/square/sum:
   Array: Array(String(happy)).compactMap{$0.wholeNumberValue}
       split: 145 -> "145" -> ["1","4","5"] -> [1,4,5]
       square/sum:
          var sum = Int()
          for i in arr {
              sum += i * i
          }
          *OR*
          split.reduce(0){$0 + ($1 * $1)}
   Mathiness: use % 10 to "loop" through all digits
      var num  = 145
      var sum = 0
      while num > 0 {
         var digit = num % 10
         sum += (digit * digit)
         num = num / 10
      }
      145 % 10 = 5
      (145 / 10) % 10 = 4
      (145 / 10 / 10) % 10 = 1
      1 / 10 = 0
      
 
 ...
 - see if that split/square/sum is 1.
 - If sum is 1... return true
 - If sum isn't 1... insert it in a set (to keep track of sums)
 
 
 - Why set? If sum is in the set, return false.
 - If the number is NOT happy, it, and the numbers that we square+sum to get it, will NEVER be happy.
 - Ex: 11 (1sq + 1sq) -> 2 -> 4 -> 16 -> 37 -> 58 -> 89 -> 145 -> 42 -> 20 -> 4
 - If i see the same number twice, I'm in an unhappy cycle
 
 
 - Why set as opposed to dictionary? We're looking for duplicates. Lookup in a set O(1), just like looking up a key in a dictionary is O(1), but the main difference is, for a set we can just say set.contains(n), as opposed to having to manipulate some k/v pair in dictionary. We don't need the "value" that a dictionary would provide for a key, we just want want to know if the key exists.
 
 */


func isHappy(_ n: Int) -> Bool {
    //
    var numbersSeen = Set<Int>()
    // is the number 1?  return true
    // guard n != 1 else {return true} -> checks only once
    // is there a duplicate number in the set? return false
    
    // split the num and square its digits
    var num = n
    while num > 1 {
        guard !numbersSeen.contains(num) else { return false }
        numbersSeen.insert(num)
        num = sumOfSquaredDigits(num)
    }
    // if we get the value 1, we are no longer in the loop, so we can return true here
    return true
}

func sumOfSquaredDigits(_ n: Int) -> Int {
    var sum = 0
    var num = n
    while num > 0 { // 145
       let digit = num % 10 // 5, 4, 1
       sum += (digit * digit)
       num = num / 10 // 145 -> 14 -> 1 -> 0
    }
    return sum
}


assert(isHappy(20) == false)
assert(isHappy(1) == true)
assert(isHappy(23) == true)
