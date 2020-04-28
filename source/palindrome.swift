import UIKit

// These are all palindromes
let str0 = ""
let str1 = "racecar"
let str1a = "racecaR"
let str2 = "a man a plan a canal panama"
let str3 = "a man a plan a canal Panama"
let str4 = "a man, a plan, a canal: Panama"
let str5 = "a m;an, a plan, a canal: Panam!a"


func isPalindrome(str:String) -> Bool {
    
    // Naive solution: if our string is just one word (or an empty string)
    // return a bool
    // is the string the same forwards and backwards
    // str.reversed is a reversed collection
    //    return str == String(str.reversed())
    
    // refine a little: deal with any string, regardless of case
    //    return str.lowercased() == String(str.lowercased().reversed())
    
    // why doesn't str2 work? there is whitespace
    // we can trim these characters -> trim removes from the end
    // replacing occurrences handles each time it sees a space
    //    let sanitizedString = str.replacingOccurrences(of: " ", with: "").lowercased()
    
    // how do we handle punctuation? or any non-alphanumerics?
    //    CharacterSet.alphanumerics.inverted -> everything except what's in that set
    // What other function out there lets us take a string, look for something(s) in it, and separate out by those things
    // components returns [String] -> each letter/group of letters will be Element in the array
    // what array function lets us combine everything into one object -> reduce("") {$0 + $1}
    // joined is a function SPECIFIC to arrays of strings that allows us to cram everything back together into one string
    let sanitizedString = str.lowercased().components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    print(sanitizedString)
    return sanitizedString == String(sanitizedString.reversed())
    
    /* Approaches
     1. Sanitize string and compare the reversed string (above)
     
     2. make sure first and last character in a string match-> Recursively
     
     let s = "Swift"
     let i = s.index(s.startIndex, offsetBy: 4)
     print(s[i])
     index of first character: s.index(s.startIndex, offsetBy: 0)
     index of last character: s.index(s.startIndex, offsetBy: s.count - 1)
     
     if string at first index and string at last index are same
     if s[first] == s[last] {
        index of second character: s.index(s.startIndex, offsetBy: 1)

        call this function on string[secondIndex..<last] -> can use a range, so long as the lower/upper limit are StringIndex (not numbers)
     } else { return false }
     
     
     3. loop through both str and str.reversed and compare the last alphanumeric character found in each of str and str.reversed
     
     
     */

}

assert(isPalindrome(str: str0))
assert(isPalindrome(str: str1))
assert(isPalindrome(str: str1a))
assert(isPalindrome(str: str2))
assert(isPalindrome(str: str3))
assert(isPalindrome(str: str4))
