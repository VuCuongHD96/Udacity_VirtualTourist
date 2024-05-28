//
//  BaseError.swift
//  MovieSwiftUI
//
//  Created by Work on 18/03/2023.
//

import Foundation

public enum BaseError: Error {
    case networkError
    case httpError(httpCode: Int)
    case unexpectedError
    case redirectionError
    case errorParsing(Error)
    case locationError
    case internetError

    struct Errors {
        static let networkError = "Network Error"
        static let error = "Error"
        static let unexpectedError = "Unexpected Error"
        static let redirectionError = "It was transferred to a different URL. I'm sorry for causing you trouble"
        static let clientError = "An error occurred on the application side. Please try again later!"
        static let serverError = "A server error occurred. Please try again later!"
        static let unofficalError = "An error occurred. Please try again later!"
        static let locationError = "Can not find your location!"
        static let internetError = "The Internet connection appears to be offline."
    }

    var title: String {
        switch self {
        case .networkError:
            return "networkError"
        case .httpError:
            return "Http Error"
        case .unexpectedError:
            return "unexpectedError"
        case.redirectionError:
            return "Redirection Error"
        case .errorParsing:
            return "errorParsing"
        case .locationError:
            return "Location Error"
        case .internetError:
            return "Internet Error"
        }
    }

    public var errorMessage: String? {
        switch self {
        case .networkError:
            return Errors.networkError
        case .httpError(let code):
            return getHttpErrorMessage(httpCode: code)
        case .redirectionError:
            return Errors.redirectionError
        case .errorParsing(let error):
            let movieDecodingError = UđacityDecodingError(error: error)
            return movieDecodingError.debugDescription
        case .locationError:
            return Errors.locationError
        case .internetError:
            return Errors.internetError
        default:
            return Errors.unexpectedError
        }
    }

    private func getHttpErrorMessage(httpCode: Int) -> String? {
        switch HTTPStatusCode(rawValue: httpCode)?.responseType {
        case .redirection?:
            return Errors.redirectionError
        case .clientError?:
            return Errors.clientError
        case .serverError?:
            return Errors.serverError
        default:
            return Errors.unofficalError
        }
    }
}
