//
//  MatrixCustom.swift
//  labsAMO
//
//  Created by Денис Данилюк on 12.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit


class MatrixCustom {

    static var maximumValue: Double = 0.0
    
    var data: [Double] = []
    
    var dataAnswers: [Double] = []
    
    var rows: Int
    
    var columns: Int
    
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.data = Array(repeating: 0.0, count: rows * columns)
        self.dataAnswers = Array(repeating: 0.0, count: rows)
    }
    
    
    init(data: [Double], dataAnswers: [Double], rows: Int, columns: Int) {
        
        self.rows = rows
        self.columns = columns
        
        if rows * columns == data.count {
            self.data = data
        } else {
            assert(false, "rows * columns != data.count")
        }
        
        if rows == dataAnswers.count {
            self.dataAnswers = dataAnswers
        } else {
            assert(false, "rows != dataAnswers.count")
        }
        
    }
    
    
    init(dataDoubleArray: [[Double]], dataAnswers: [Double]) {
        
        self.rows = dataDoubleArray[0].count
        self.columns = dataAnswers.count
        
        for row in dataDoubleArray {
            for element in row {
                data.append(element)
            }
        }
        
        self.dataAnswers = dataAnswers
    }
    
    
    func copy(with zone: NSZone? = nil) -> MatrixCustom {
        let copy = MatrixCustom(data: data, dataAnswers: dataAnswers, rows: rows, columns: columns)
        return copy
    }
    
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    
    var description: String {
        var descriptionString = ""
        
        for row in 0..<rows {
            for column in 0..<columns {
                let element = self[row, column]

                descriptionString += formatNumber(element)
            }
            
            descriptionString += "= \(formatNumber(self.dataAnswers[row]))"
            descriptionString += "\n"
        }
        return descriptionString
    }
    
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return data[(row * columns) + column]
        }
        
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            self.data[(row * columns) + column] = newValue
        }
    }
    
    
    func getRow(index: Int) -> (row: [Double], answer: Double) {
        
        var row: [Double] = []
        for i in 0..<columns {
            let element = self[index, i]
            row.append(element)
        }
        
        return (row: row, answer: self.dataAnswers[index])
    }
    
    
    func removeRow(index: Int) -> (row: [Double], answer: Double) {
        var result: (row: [Double], answer: Double)
    
        var row: [Double] = []
        
        for _ in 0..<columns {
            row.append(self.data[columns * index])
            data.remove(at: columns * index)
        }
        
        let answer = self.dataAnswers[index]
        dataAnswers.remove(at: index)

        result.row = row
        result.answer = answer
        
        self.rows -= 1
        
        return result
    }
    
    
    @discardableResult
    func insertRow(row: [Double], answer: Double, in index: Int) -> Bool {
        
        if row.count != columns {
            assert(false, "line.count != columns")
            return false
        }
        
        for i in 0..<columns {
            data.insert(row[i], at: columns * index + i)
        }
        
        dataAnswers.insert(answer, at: index)
        
        self.rows += 1
        
        return true
    }
    
    
    func formatNumber(_ number: Double) -> String {

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2 // minimum number of fraction digits on right
        formatter.maximumFractionDigits = 2 // maximum number of fraction digits on right, or comment for all available
        formatter.minimumIntegerDigits = 1 // minimum number of integer digits on left (necessary so that 0.5 don't return .500)
        
        let isMinus = number >= 0.0 ? false : true
        
        if let formattedNumber = formatter.string(from: NSNumber.init(value: abs(number))) {
            if isMinus {
                return "‒\(formattedNumber) "
            } else {
                return "  " + formattedNumber + " "
            }
        } else {
            return ""
        }
    }
}
