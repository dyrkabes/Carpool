//
//  NetworkError.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case parsingFailure
    case webServiceError(String)
    case networkProblem(Error)
    case userCancelled
    case unknown
    
    // MARK: - Init
    init(error: Error) {
        self = .networkProblem(error)
    }
    
    // MARK: - Public
    var statusCode: Int {
        switch self {
        case .parsingFailure:
            return 1001
        case .webServiceError(_):
            return 1002
        case .networkProblem(_):
            return 10001
        case .unknown:
            return 10002
        case .userCancelled:
            return 10003
        }
    }
}

// MARK: - LocalizedError
extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parsingFailure:
            return AppTexts.parsingFailure
        case .webServiceError(let string):
            return string
        case .networkProblem(let error):
            return error.localizedDescription
        case .userCancelled:
            return nil
        case .unknown:
            return AppTexts.unknownError
        }
    }
}

// MARK: - Equatable
extension NetworkError: Equatable {
    static func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.statusCode == rhs.statusCode
    }
}
