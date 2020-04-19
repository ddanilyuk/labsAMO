//
//  MatrixCustom.swift
//  labsAMO
//
//  Created by Денис Данилюк on 12.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit


class MatrixCustom {
    
    var maximum: Double = 0.0
    
    var rows: Int
    
    var columns: Int
    
    var data: [Double] = [] {
        didSet {
            let max = data.max() ?? 0.0
            if self.maximum < max {
                self.maximum = max
            }
        }
    }
    
    var dataAnswers: [Double] = [] {
        didSet {
            let max = dataAnswers.max() ?? 0.0
            if self.maximum < max {
                self.maximum = max
            }
        }
    }
    
    
    /// Empty matrix
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.data = Array(repeating: 0.0, count: rows * columns)
        self.dataAnswers = Array(repeating: 0.0, count: rows)
    }
    
    
    init(data: [Double], dataAnswers: [Double], rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        
        if rows * columns != data.count {
            assert(false, "rows * columns != data.count")
            return
        } else if rows != dataAnswers.count {
            assert(false, "rows != dataAnswers.count")
            return
        }
        
        defer {
            self.data = data
            self.dataAnswers = dataAnswers
        }
    }
    
    
    init(dataDoubleArray: [[Double]], dataAnswers: [Double]) {
        self.rows = dataDoubleArray[0].count
        self.columns = dataAnswers.count
        
        var dataArray: [Double] = []
        for row in dataDoubleArray {
            for element in row {
                dataArray.append(element)
            }
        }
        
        defer {
            self.data = dataArray
            self.dataAnswers = dataAnswers
        }
    }
    
    
    func copy(with zone: NSZone? = nil) -> MatrixCustom {
        let copy = MatrixCustom(data: data, dataAnswers: dataAnswers, rows: rows, columns: columns)
        return copy
    }
    
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    
    func findAbsMaxInColumn(column: Int, from row: Int = 0) -> (rowNumber: Int, maxInColumn: Double) {
        var rowNumber = 0
        var maxInColumn: Double = abs(self[row, column])
        
        for i in row + 1..<self.columns {
            let element = self[i, column]
            if maxInColumn < abs(element) {
                maxInColumn = element
                rowNumber = i
            }
        }
        
        return (rowNumber: rowNumber, maxInColumn: maxInColumn)
    }
    
    
    func findMaxInRow(row: Int) -> Double? {
        let rowWithAnswer = getRow(index: row)
        var maxInRow: Double = rowWithAnswer.row[0]
        
        for element in rowWithAnswer.row {
            if maxInRow < element {
                maxInRow = element
            }
        }
        
        return maxInRow
    }
    
    
    var description: String {
        var descriptionString = String()

        for row in 0..<rows {
            for column in 0..<columns {
                let element = self[row, column]
                
                if element < 0 {
                    descriptionString += column != 0 ? " " : ""
                    descriptionString += "− 𝗑\(column + 1)⋅\(formatNumber(abs(element)))"
                } else {
                    descriptionString += column != 0 ? " +" : ""
                    descriptionString += " 𝗑\(column + 1)⋅\(formatNumber(abs(element)))"
                }
            }
            
            /// Add answer value
            descriptionString += self.dataAnswers[row] < 0 ? " = −\(formatNumber(abs(self.dataAnswers[row])))" : " =  \(formatNumber(abs(self.dataAnswers[row])))"
            
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
        
        if self.maximum < 10 {
            formatter.minimumIntegerDigits = 1
        } else if self.maximum < 100 {
            formatter.minimumIntegerDigits = 2
        } else {
            formatter.minimumIntegerDigits = 3
        }
        
        if let formattedNumber = formatter.string(from: NSNumber.init(value: number)) {
            return formattedNumber
        } else {
            return ""
        }
    }
}
