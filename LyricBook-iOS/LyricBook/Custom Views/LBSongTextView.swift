//
//  LBSongTextView.swift
//  LyricBook
//
//  Created by Andrew Lawler on 03/01/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit

class LBSongTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        isEditable = false
        textColor = .systemGray
        font = UIFont.preferredFont(forTextStyle: .body)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
