import UIKit

/*
 The prime factors of 13195 are 5, 7, 13 and 29. The largest of those is 29.
 Write a function that finds the largest prime factor of any Int.
 
 Approach:
 - Figure out how to find factors of a number
 - Find out which of those factors is prime
 - Return the largest of those prime factors
 
 Are there built-ins for factors(of: Int) or isPrime -> Bool. No. They don't exist. SRY
 
 how do we know if a number is prime? divisible ONLY by 1 and itself.
 what is a factor? Ints that multiply to a certain number.
 largest -> could use .max() on array, could definitely do other stuff
 -----> we'll need to figure out how we can keep looking at a number to find its largest prime.
 
 
 */

//Opinion: For something like isPrime, I like to extend the type because we're talking about the "identity" of some var. var num = 13. return num.isPrime

// Helper
extension Int {
    var isPrime: Bool {
        // how do we know if a number is prime? divisible ONLY by 1 and itself.
        // rule out evens? divisible by 2
        // think about 87. do we need to see if it can divide by every number up to 83 to see if it's prime? 3 * 29
        guard self > 1 else {return false}
        // if i made sure the number is greater than 1, then at this step i have the numbers between 2 and the highest number i can compute
        guard self > 3 else {return true} // 2 or 3 -> both prime
        // the range would be invalid if the sqrt of my number is less than 2
        for i in 2...Int(sqrt(Double(self))) {
            print(i)
            if self % i == 0 {
                return false
            }
        }
        // if none of those numbers divide in evenly, the number is prime
        return true
    }
}

var num = 12
num.isPrime

func largestPrimeFactor(of num: Int) -> Int {
    /*
    // how do we find factors? we can use %. compare the num to some number, if the remainder of dividing by that number is zero, it's a factor!
    
    // get all the factors. when we see factor, what should we do? check if it's prime
    // if it's not prime, disregard. what about if it IS prime? store in an array, which we can look in later.
    var primeFactors = [Int]()

    // 1 is not a prime number, just by definition (tbh idk why)
    for i in 2...num {
        // check if i is a factor. let's ALSO check if i is prime
        if num % i == 0 && i.isPrime {
            primeFactors.append(i)
        }
    }
    // returning an Int. what should I do if there are NO prime factors?
    // Common practice: If there's no valid answer, just return zero.
    return primeFactors.max() ?? 0
 */
    // let's use no space
    // currently i'm counting from low to high, so i have to keep calculating until i reach the end of the range
    for i in (2...num).reversed() {
        if num % i == 0 && i.isPrime {
            return i
        }
    }
    return 0
    
    // note: we can reduce the operations by only looking at half the input.
    /*
     guard !num.isPrime else {return num}
     for i in (2..<num/2).reversed() {
         if num % i == 0 && i.isPrime {
             return i
         }
     }
     */
}

largestPrimeFactor(of: num)
