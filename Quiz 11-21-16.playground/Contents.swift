//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//Given an array of Ints as input, write a function that returns a Tuple, where the first value is the sum of the even numbers, the second value is the product of the odd numbers, and the third number is the sum of the negative numbers. 
//Sample Input: [5,3,4,-2,-7]
//Sample Output: (2, -105, -9)

func getResults (array: [Int]) -> (Int,Int,Int)? {
    var sumOfEven = 0
    var productOfOdd = 1
    var sumOfNegative = 0
    for i in array {
        if i % 2 == 0 {
            sumOfEven += i
        }
        if i % 2 == 1 || i % 2 == -1 {
            productOfOdd *= i
        }
        if i < 0 {
            sumOfNegative += i
        }
    }
    return (sumOfEven, productOfOdd,sumOfNegative)
}

getResults(array: [5,3,4,-2,-7])

func tupleTrouble(arr: [Int]) -> (Int, Int, Int) {
    var finalTuple = (evenSum: 0, oddProduct: 1, negativeSum: 0)
    for value in arr {
        if value % 2 == 0 {
            finalTuple.evenSum += value
        } else {
            finalTuple.oddProduct *= value
        }
        if value < 0 {
            finalTuple.negativeSum += value
        }
    }
    return finalTuple
}