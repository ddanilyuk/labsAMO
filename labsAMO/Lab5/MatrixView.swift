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
            
            for j in 0..<matrixSize + 1 {

                let size = CGRect(x: 0, y: 0, width: (actualRowStackView.bounds.width - spacingInsetsColumn) / CGFloat(matrixSize + 1), height: (actualRowStackView.bounds.height))
                
                let viewToInsert = UIView(frame: size)
                
                let textField = UITextField(frame: CGRect(x: 25, y: (size.height - 30) / 2, width: size.width - 25, height: 30))
                
                
                let label = UILabel(frame: CGRect(x: 0, y: 3, width: 20, height: 25))
                if j == matrixSize {
                    label.text = "="
                } else {
                    label.text = "x\(j + 1)"
                }
                let iconContainerView: UIView = UIView(frame:
                               CGRect(x: 0, y: (actualRowStackView.bounds.height  - 30 ) / 2, width: 20, height: 30))
                iconContainerView.addSubview(label)
            

                viewToInsert.addSubview(iconContainerView)
                
                viewToInsert.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                viewToInsert.heightAnchor.constraint(equalToConstant: size.height).isActive = true
                
                textField.widthAnchor.constraint(equalToConstant: size.width - 20).isActive = true
                textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
                
                textField.autocorrectionType = .no
                textField.autocapitalizationType = .none
                textField.textAlignment = .center
                textField.keyboardType = .decimalPad
                textField.translatesAutoresizingMaskIntoConstraints = true
                textField.backgroundColor = .clear
                textField.font = UIFont(name: "Helvetica", size: 15) ?? UIFont()
                
                textField.borderStyle = .roundedRect
                textField.layer.borderColor = UIColor.gray.cgColor
                

                viewToInsert.addSubview(textField)

                textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

                textFieldArray.append(textField)

                actualRowStackView.addArrangedSubview(viewToInsert)
            }
            
            rowsStackView.addArrangedSubview(actualRowStackView)
        }
        
        return rowsStackView
    }

    
    @objc func textFieldDidChange(_ textField: UITextField) {
        getMatrixResult()
    }
    
    
    func getMatrixResult() {
        let matrix = MatrixCustom(rows: matrixSize, columns: matrixSize)
        
        var column = 0

        for i in 0..<textFieldArray.count {
            let row = (i / (matrixSize + 1))
            
            let textField = textFieldArray[i]
                        
            let double = (textField.text ?? "").doubleValue

            if column == matrixSize {
                column = 0
                
                matrix.dataAnswers[row] = double
                continue
            }
            matrix[row, column] = double
            column += 1

        }
        delegate?.didMatrixChanged(self, matrix: matrix)
    }
}
