//
//  LBTextFieldArtist.swift
//  LyricBook
//
//  Created by Andrew Lawler on 03/01/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit

class LBTextFieldArtist: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        configure()
    }
    
    private func configure() {

        translatesAutoresizingMaskIntoConstraints = false
                    
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemRed.cgColor
                    
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
                            
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .yes
        returnKeyType = .next
    }

}
