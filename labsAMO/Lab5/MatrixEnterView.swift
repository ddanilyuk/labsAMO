//
//  MatrixEnter.swift
//  labsAMO
//
//  Created by Денис Данилюк on 12.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit


protocol MatrixEnteredDelgate {
    func getAllMatrix(_ matrixEnterView: MatrixEnterView, matrix: MatrixCustom)
}

//protocol LocationNameCellDelegate {
//    func locationNameCell(_ indexPath: IndexPath, didChange text:String)
//}

//class LocationNameCell: UITableViewCell {
//
//   @IBOutlet weak var nameTextField: UITextField!
//
//}

class MatrixEnterView: UIView {
    
    var matrixSize: Int = 0
    
    var spacing: CGFloat = 10
    
    var delegate: MatrixEnteredDelgate?
    
//    var delegateHere: LocationNameCellDelegate?

    var textFieldArray: [UITextField] = []
        
    override func layoutSubviews() {

        print("layoutSubviews")
        self.addSubview(matrixView)
    }
    
    lazy var matrixView: UIView = {
        let spacingInsetsForRow = CGFloat((matrixSize - 1)) * spacing
        
        let spacingInsetsColumn = CGFloat(matrixSize) * spacing


        let rowsStackView = UIStackView(frame: bounds)
        
        rowsStackView.axis = .vertical
        rowsStackView.distribution = .fillEqually
        rowsStackView.spacing = 10
        rowsStackView.translatesAutoresizingMaskIntoConstraints = false

        for i in 0..<matrixSize {
            let size = CGRect(x: 0, y: 0,
                              width: CGFloat(rowsStackView.bounds.width),
                              height: CGFloat(rowsStackView.bounds.height / CGFloat(matrixSize)) - spacingInsetsForRow)
            
            let actualRowStackView = UIStackView(frame: size)
            
            actualRowStackView.translatesAutoresizingMaskIntoConstraints = false

            actualRowStackView.distribution = .fillEqually
            actualRowStackView.spacing = 10
            actualRowStackView.axis = .horizontal
            
            for j in 0..<matrixSize + 1 {

                let viewToInsert = UITextField()
                let indexPath = IndexPath(row: i, section: j)
//                print(viewToInsert.description)
                
                viewToInsert.autocorrectionType = .no
                viewToInsert.autocapitalizationType = .none
                viewToInsert.textAlignment = .center
                viewToInsert.keyboardType = .decimalPad
                viewToInsert.translatesAutoresizingMaskIntoConstraints = false
                viewToInsert.backgroundColor = .gray
                
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: viewToInsert.bounds.height))
                view.backgroundColor = .yellow
                viewToInsert.leftView? = view
//                viewToInsert.leftView?.backgroundColor = .yellow
                
//                viewToInsert.leftView?.bounds =
                viewToInsert.layer.cornerRadius = CGFloat(actualRowStackView.bounds.height / 4)
                //                viewToInsert.leftView.text
                
                
                viewToInsert.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

                
                
                viewToInsert.widthAnchor.constraint(equalToConstant: (actualRowStackView.bounds.width - spacingInsetsColumn) / CGFloat(matrixSize + 1)).isActive = true
                viewToInsert.heightAnchor.constraint(equalToConstant: (actualRowStackView.bounds.height)).isActive = true
                
                textFieldArray.append(viewToInsert)

                actualRowStackView.addArrangedSubview(viewToInsert)
            }
            
            rowsStackView.addArrangedSubview(actualRowStackView)
        }
        
        return rowsStackView
        
    }()
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        getResult()
//        print(textField.text)
    }
    

    func getResult() {
        let matrix = MatrixCustom(rows: matrixSize, columns: matrixSize)
        
        var column = 0

        for i in 0..<textFieldArray.count {
            let row = (i / (matrixSize + 1))
            
             let textField = textFieldArray[i]
                        
//            print(i, row, column)
            let text = (textField.text ?? "").doubleValue
//            if column ==
            if column == matrixSize {
                column = 0
                
                matrix.dataAnswers[row] = text
                continue
            }
           
//            text.repa
            matrix[row, column] = text
            column += 1

        }
//        print(matrix.description)
        delegate?.getAllMatrix(self, matrix: matrix)
    }
    
//    @objc func textFieldDidChange2(_ textField: UITextField, _ indexPath: IndexPath) {
//        print(indexPath)
//        print(textField.text)
//    }
    
//    func layoutMatrix() {
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        if matrixSize == 0 {
//            print(self.bounds)
//            print(self.frame)
//            return
//        }
//        // standard initialization logic
////        let nib = UINib(nibName: "CaptionableImageView", bundle: nil)
////        nib.instantiateWithOwner(self, options: nil)
////        contentView.frame = bounds
////        addSubview(contentView)
//        print(self.bounds)
//        print(self.frame)
//
//        print(screenWidth, screenHeight)
//
//        let spacingInsets = CGFloat((matrixSize - 1)) * spacing
//
////        let horizontalStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: bounds.width - 20, height: bounds.height - 20))
//        let horizontalStackView = UIStackView(frame: self.bounds)
//
//
//
////        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
//
//
////        horizontalStackView.contentMode = .topLeft
//
//        horizontalStackView.axis = .vertical
//        horizontalStackView.distribution = .fillEqually
//
//        horizontalStackView.spacing = 10
//        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
//
//
//
//        for i in 0..<matrixSize {
//            let size = CGRect(x: 0, y: 0, width: CGFloat(horizontalStackView.bounds.width), height: CGFloat(horizontalStackView.bounds.height / CGFloat(matrixSize)) - 20)
//            let verticalStackView = UIStackView(frame: size)
//            verticalStackView.translatesAutoresizingMaskIntoConstraints = false
//
//            verticalStackView.distribution = .fillEqually
//            verticalStackView.spacing = 10
//            verticalStackView.axis = .horizontal
//
//
////            verticalStackView.widthAnchor.constraint(equalToConstant: CGFloat(horizontalStackView.bounds.width)).isActive = true
////            verticalStackView.heightAnchor.constraint(equalToConstant: CGFloat(horizontalStackView.bounds.height / CGFloat(matrixSize)) - 20).isActive = true
//
//
//            for j in 0..<matrixSize {
////                let viewToInsert: UIView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(verticalStackView.bounds.width - 20) / 3, height: verticalStackView.bounds.height))
//                let viewToInsert: UIView = UIView()
//
//                viewToInsert.translatesAutoresizingMaskIntoConstraints = false
//                viewToInsert.backgroundColor = .green
////                print(CGFloat(verticalStackView.bounds.width - 20) / 3)
////                viewToInsert.heightAnchor.constraint(equalToConstant: 20).isActive = true
//                viewToInsert.widthAnchor.constraint(equalToConstant: (verticalStackView.bounds.width - 20) / 3).isActive = true
//                viewToInsert.heightAnchor.constraint(equalToConstant: (verticalStackView.bounds.height)).isActive = true
//
////                viewToInsert.widthAnchor.constraint(equalToConstant: bounds.width - 30).isActive = true
//                verticalStackView.addArrangedSubview(viewToInsert)
//            }
//            horizontalStackView.addArrangedSubview(verticalStackView)
//        }
//
//
//
//        // custom initialization logic
//        addSubview(horizontalStackView)
//    }
}

extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}
