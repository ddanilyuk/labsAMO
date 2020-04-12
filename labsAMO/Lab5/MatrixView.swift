//
//  MatrixView.swift
//  labsAMO
//
//  Created by Денис Данилюк on 11.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class MatrixView: UIView {
    private let data: [[Int]]

    init(frame: CGRect, data: [[Int]]) {
        self.data = data
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor = .yellow
        layoutMatrix()
    }

    private func layoutMatrix() {
        let dataLenght = data.count
        let dataHeight  = data[0].count
        let horizontalStackView = UIStackView(frame: bounds)
        horizontalStackView.axis = .horizontal

        let imageViewWidth = frame.width / CGFloat(dataHeight)
        let imageViewHeight = frame.height / CGFloat(dataLenght)
        let imageViewRect = CGRect(x: 0, y: 0, width: imageViewWidth, height: imageViewHeight)

        for i in 0..<dataLenght {
            let verticalStackView = UIStackView()
            verticalStackView.axis = .vertical
            verticalStackView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
            verticalStackView.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
            for j in 0..<dataHeight {
                let viewToInsert: UIView
                if data[i][j] == 1 {
                    let image = UIImageView(image: #imageLiteral(resourceName: "lab2Task1"))
                    image.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
                    image.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
                    viewToInsert = image
                } else {
                    let empty = UIView(frame: imageViewRect)
                    empty.backgroundColor = .white
                    empty.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
                    empty.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
                    viewToInsert = empty
                }
                verticalStackView.addArrangedSubview(viewToInsert)
            }
            horizontalStackView.addArrangedSubview(verticalStackView)
        }

        addSubview(horizontalStackView)
    }
}
