//
//  sortFunctions.swift
//  labsAMO
//
//  Created by Денис Данилюк on 26.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit


/// QUICKSORT1
func quicksort<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else {
        return a
    }
    let pivot = a[a.count/2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }

    return quicksort(less) + equal + quicksort(greater)
}



/// QUICKSORT2
func quickSort2(_ input: [Double], startIndex:Int, endIndex: Int)-> [Double] {
    var inputArray = input
    if startIndex<endIndex {
        let pivot = inputArray[endIndex]
        var index = startIndex

        for demo in startIndex..<endIndex {
            if inputArray[demo] <= pivot {
                (inputArray[index], inputArray[demo]) = (inputArray[demo], inputArray[index])
                index += 1
            }
        }
        (inputArray[index], inputArray[endIndex]) = (inputArray[endIndex], inputArray[index])
        inputArray = quickSort2(inputArray, startIndex: startIndex, endIndex: index-1)
        inputArray = quickSort2(inputArray, startIndex: index+1, endIndex: endIndex)
    }
    return inputArray
}


/// BUBLE
func buble(array: [Double]) -> [Double]{
    var arrayReturn = array
    for i in 0..<arrayReturn.count {
      for j in 1..<arrayReturn.count - i {
        if arrayReturn[j] < arrayReturn[j-1] {
          let tmp = arrayReturn[j-1]
          arrayReturn[j-1] = arrayReturn[j]
          arrayReturn[j] = tmp
        }
      }
    }
    return arrayReturn
}


/// HOARE
func partitionHoare(_ a: inout [Double], low: Int, high: Int) -> Int {
    let pivot = a[low]
    var i = low - 1
    var j = high + 1
    
    while true {
        repeat { j -= 1 } while a[j] > pivot
        repeat { i += 1 } while a[i] < pivot
        
        if i < j {
            a.swapAt(i, j)
        } else {
            return j
        }
    }
}

func quicksortHoare(_ a: inout [Double], low: Int, high: Int) {
    if low < high {
        let p = partitionHoare(&a, low: low, high: high)
        quicksortHoare(&a, low: low, high: p)
        quicksortHoare(&a, low: p + 1, high: high)
    }
}
