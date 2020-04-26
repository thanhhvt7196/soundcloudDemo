//
//  ErrorDetails.swift
//  myNews
//
//  Created by kennyS on 12/17/19.
//  Copyright © 2019 kennyS. All rights reserved.
//

import Foundation

class ErrorDetails: Codable, Error {
    var code: Int? = nil
    var message: String = ""

    init(code: Int? = nil, message: String) {
        self.code = code
        self.message = message
    }
}

extension Error {
    func toErrorDetails() -> ErrorDetails {
        return ErrorDetails(message: localizedDescription)
    }
}
