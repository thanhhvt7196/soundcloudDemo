//
//  SearchSuggestionHeaderView.swift
//  myNews
//
//  Created by kennyS on 4/20/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation
import Reusable

class SearchSuggestionHeaderView: UIView, NibOwnerLoadable {
    @IBOutlet weak var titleLabel: UILabel!
    
    private func commonInit() {
        loadNibContent()
        titleLabel.textColor = .gray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
