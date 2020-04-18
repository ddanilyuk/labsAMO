//
//  MatrixEnter.swift
//  labsAMO
//
//  Created by Денис Данилюк on 12.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit


protocol MatrixDelgate {
    func didMatrixChanged(_ matrixEnterView: MatrixView, matrix: MatrixCustom)
}


class MatrixView: UIView {
    
    var matrixSize: Int = 0
    
    var spacing: CGFloat = 8
    
    var delegate: MatrixDelgate?
    
    var textFieldArray: [UITextField] = []
        
    
    override func layoutSubviews() {
        self.addSubview(getMatrix())
    }
    
    
    func getMatrix() -> UIView {
        textFieldArray.removeAll()

        let spacingInsetsForRow = CGFloat((matrixSize - 1)) * spacing
        let spacingInsetsColumn = CGFloat(matrixSize) * spacing

        let rowsStackView = UIStackView(frame: bounds)
        
        rowsStackView.axis = .vertical
        rowsStackView.distribution = .fillEqually
        rowsStackView.spacing = spacing
        rowsStackView.translatesAutoresizingMaskIntoConstraints = false

        for _ in 0..<matrixSize {
            let size = CGRect(x: 0, y: 0,
                              width: CGFloat(rowsStackView.bounds.width),
                              height: CGFloat(rowsStackView.bounds.height - spacingInsetsForRow) / CGFloat(matrixSize))
            
            let actualRowStackView = UIStackView(frame: size)
            
            actualRowStackView.translatesAutoresizingMaskIntoConstraints = false
            actualRowStackView.distribution = .fillEqually
            actualRowStackView.spacing = spacing
            actualRowStackView.axis = .horizontal
            
            for columnNumber in 0..<matrixSize + 1 {

                let size = CGRect(x: 0, y: 0, width: (actualRowStackView.bounds.width - spacingInsetsColumn) / CGFloat(matrixSize + 1), height: (actualRowStackView.bounds.height))
                
                let viewToInsert = UIView(frame: size)
                viewToInsert.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                viewToInsert.heightAnchor.constraint(equalToConstant: size.height).isActive = true
                
                let textField = UITextField(frame: CGRect(x: 25, y: (size.height - 30) / 2, width: size.width - 25, height: 30))
                let label = UILabel(frame: CGRect(x: 0, y: 3, width: 20, height: 25))
                let labelContainerView = UIView(frame: CGRect(x: 0, y: (actualRowStackView.bounds.height  - 30 ) / 2,
                                                              width: 20, height: 30))
                
                label.text = columnNumber == matrixSize ? "=" : "x\(columnNumber + 1)"
                labelContainerView.addSubview(label)
        
                setupTextField(textField)
                textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                textFieldArray.append(textField)

                viewToInsert.addSubview(textField)
                viewToInsert.addSubview(labelContainerView)

                actualRowStackView.addArrangedSubview(viewToInsert)
            }
            
            rowsStackView.addArrangedSubview(actualRowStackView)
        }
        
        return rowsStackView
    }

    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.placeholder = ""
        getMatrixResult()
    }
    
    
    func setupTextField(_ textField: UITextField) {
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textAlignment = .center
        textField.keyboardType = .numbersAndPunctuation
        textField.translatesAutoresizingMaskIntoConstraints = true
        textField.backgroundColor = .clear
        textField.font = UIFont(name: "Helvetica", size: 15) ?? UIFont()
        
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    func getMatrixResult() {
        var dataArray: [Double] = []
        var answerArray: [Double] = []
        var counter: Int = 0
        
        for i in 0..<textFieldArray.count {
            let value = (textFieldArray[i].text ?? "").doubleValue

            if counter == matrixSize {
                counter = 0
                answerArray.append(value)
            } else {
                counter += 1
                dataArray.append(value)
            }
        }
    
        let matrix = MatrixCustom(data: dataArray, dataAnswers: answerArray, rows: matrixSize, columns: matrixSize)
        delegate?.didMatrixChanged(self, matrix: matrix)
    }
}
