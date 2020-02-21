//
//  LBButton.swift
//  LyricBook
//
//  Created by Andrew Lawler on 03/01/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit

class LBButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(text: String, Color: UIColor) {
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.backgroundColor = Color
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    

}
