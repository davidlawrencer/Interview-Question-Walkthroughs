import UIKit

/*
 Function to see if a player's guesses is valid
 [[Int]] where each subarray has 3 values
 arr[0] is row for guess
 arr[1] is column for guess
 arr[2] is value being guessed (aka, can I add this to my Sudoku problem)
 
 How would you track this info (the guesses)?
 - dictionary -> store the value as a key, have the coordinates as an array of tuples
     [Int: [(Int, Int)] ]
     [value: [(row,colum)] ]
     how did you use this? checked if a value (arr[2]) is a key, then see if the dictionary value for that key in the [(row,column)] array has the row and column from the guess (arr[0],arr[1])
     TODO/THINK ON: How to account for subgrids
    3 dict: rowDict, columnDict, subGridDict
    [Int: Set<Int>] -> key being the guessed value, and value being a set of the row/column/subgrid they were found in
 
 - array -> there are 81 potential locations for a guess
 - how many guesses can go in a row? 9
 - how many guesses can go in a column? 9
 
*/

func validateGuesses(sudokuMatrix: [[Int]]) -> Bool {
    // how should we construct our array?
    // we could have an array of arrays
    // how many subarrays should there be? 9
    // how many elements will be in each subarray? 9
    
//    var grid = Array(repeating: <#T##_#>, count: 9)
//    [_,_,_,_,_,_,_,_,_]
    // by default, an empty space holds the value 0. this will be important when we model/create our solver
    
    var grid = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    
    // grid is a fixed size (9 rows x 9 columns)
    // when we look through, we don't have to check some dynamic number
    // to look at each row, look at row #s 1-9, which in computers is indexes 0-8
    // to subscript for a row, grid[0][0...8] -> grid[0] -> grid[rowFromGuess]
    
    // to look at each column, look at columns 1-9
    // to subscript for a column, grid[someNumber][columnFromGuess]
    
    // because of the fixed size, to get to any row and match it against the guessed row, and to get to any column and match it against the guessed column, we can just iterate through a "static" range 0...8
    
    // guess[0] is row, guess[1] is column, guess[2] is the value being guessed for that row/column space
    for guess in sudokuMatrix {
        // row is 1...9
        // to match the indices of this array, row must be 0...8
        
        /*
        [[0,0,0,0,0,0,0,0,0],
         [1,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0,0]]
         
         [[1...9],
         [2...9, 1],
         [3...9,1,2]
         ....
         ]
         // guarantee that one (and only one) value can go in a specific spot
        */
        let row = guess[0] - 1
        let column = guess[1] - 1
        let value = guess[2]
        
        // row and column are both 9-long, so we can iterate through
        for i in 0...8 {
            if grid[row][i] == value {
                return false
            }
            
            if grid[i][column] == value {
                return false
            }
        }
        
        // if we know the row and the column, we can find the subgrid using... math
        // rows of center subgrid -> 4,5,6 (indices 3,4,5)
        // columns of center subgrid -> 4,5,6 (indices 3,4,5)
        // computer math helps (regular sucks)
        // Round down in division when there is any remainder
        // first subgrid -> goes from (0,0) to (2,2)
        // second subgrid -> goes frmo (0,3) to (2,5)
        // third subgrid goes from (0,6) to (2,8)
        
        // if for any row/column, we can find the starting point of that subgrid, we can iterate through a short range
        // first subgrid
//        for i in 0...2 {
//            for j in 0...2 {
//                if grid[i][j] == value {
//                    return false
//                }
//            }
//        }
        // pattern works for any subgrid so long as we can find the indices of the top-left of that subgrid, we can just iterate through two spaces to the right, and two spaces down
        // second subgrid
        //        for i in 0...2 {
        //            for j in 3...5 {
        //                if grid[i][j] == value {
        //                    return false
        //                }
        //            }
        //        }
        
        // for any position, if we divide row/column each by three, then multiplying by 3
        
        // subgrid 6 -> top left is 3,6
        // if i'm in the middle of this subgrid (4,7)
        // 4 / 3 = 1 * 3 = 3
        // 7 / 3 = 2 * 3 = 6
        
        // because sudoku is a fixed size!
        let subgridRowStartIndex = row / 3 /*our remainder is gone*/ * 3
        let subgridColumnStartIndex = column / 3 /*our remainder is gone*/ * 3
        
        for i in subgridRowStartIndex...(subgridRowStartIndex + 2) {
            for j in subgridColumnStartIndex...(subgridColumnStartIndex + 2) {
                if grid[i][j] == value {
                    return false
                }
            }
        }
            grid[row][column] = value
    }
        return true
}


func validateWithDict(sudokuMatrix: [[Int]]) -> Bool {
    
    var dict = [Int:[(Int,Int)]]()
    var tupleArr = [(Int,Int)]()
    
    // a is the guess (as an array)
    for a in sudokuMatrix {
        if dict[a[2]] != nil {
            for i in dict[a[2]]! {
                // for a given value, if the row matches or the column matches
                if i.0 == a[0] || i.1 == a[1] {
                    return false
                }
            }
            // otherwise, append new (row,column) tuple to the array at that key (the guessed value)
            tupleArr = dict[a[2]]!
            tupleArr.append((a[0],a[1]))
            dict[a[2]] = tupleArr
        } else {
            // default case when the dictionary doesnt have a key for the guessed value
            dict[a[2]] = [(a[0],a[1])]
        }
        
        //no grid solver
    }
    return true
}

// work for empty board
let testSetOne = [[Int]]()

// multiple guesses in a row
let testSetTwo = [
    [2, 2, 5], // 5 in row 2
    [2, 5, 1],
    [5, 2, 3],
    [2, 8, 5]] // 5 in row 2

// should work!
let testSetThree = [
    [3, 1, 3],
    [2, 8, 3],
    [1, 4, 3],
    [7, 2, 3],
    [6, 3, 3],
    [5, 5, 3],
    [4, 7, 3],
    [8, 6, 3],
    [9, 9, 3]]

// multiple guesses in a subgrid
let testSetFour = [
    [1, 2, 3], // subgrid 1
    [5, 4, 3], // subgrid 5
    [3, 1, 3]] // subgrid 1

//assert(validateWithDict(sudokuMatrix: testSetOne) == true)
//assert(validateWithDict(sudokuMatrix: testSetTwo) == false)
//assert(validateWithDict(sudokuMatrix: testSetThree) == true)
//assert(validateWithDict(sudokuMatrix: testSetFour) == false) //dangit

assert(validateGuesses(sudokuMatrix: testSetOne) == true)
assert(validateGuesses(sudokuMatrix: testSetTwo) == false)
assert(validateGuesses(sudokuMatrix: testSetThree) == true)
assert(validateGuesses(sudokuMatrix: testSetFour) == false)
print("EOF")


/*
 
 Solver: given any grid (9x9) with any number of filled in spaces, could you get the computer to find a working solution?
 Part of this is figuring out how to make a guess and how the "event loop" will work
 Part of this is figuring out when you have an invalid board
 There is only one solution for a given game board
 
 Instead of holding a 0 in each space, let's use OOP!
 Gameboard isn't just made up of Int's 0...9
 Gameboard is made up of Cells
 Cell can hold a value 0...9
 Cell can also hold a set of "potential guesses" that initially has any value that can go in the row (1...9), but each time a guess gets put into that cell's subgrid, row, or column, you remove the potential guess from the Cell
 
 Goal is to successfully fill the board
 Could have multiple solutions IF a full board has any cells whose potential guesses have more than 1 item in them
 */
