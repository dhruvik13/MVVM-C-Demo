//
//  TargetType.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 20/07/2021.
//

import Foundation

protocol TargetType {

    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: Core.Method { get }
    
    /// overridable if you really want to (i.e. for BodyFormat.jsonData)
    var body: Data? { get }
    
    var headers: [String: String]? { get }
    
    /// flexibility to provide cachepolicy for individual request if required
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension TargetType {
    
    func fetchData(with completion: @escaping (Result<Data, Error>) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: URLRequest(url: url())) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let data = data else {
                    completion(.failure(BreakingBadError.normalizeError(error)))
                    return
                }
                completion(.success(data))
            } else if let httppResponse = response as? HTTPURLResponse, httppResponse.statusCode == 429 {
                completion(.failure(BreakingBadError.limitReached))
            } else {
                completion(.failure(BreakingBadError.normalizeError(error)))
            }
        }
        task.resume()
    }
    
    public func url() -> URL {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.path = path
        guard let url = components?.url else {
            return baseURL
        }
        return url
    }
}

enum BreakingBadError: Swift.Error {
    case limitReached
    case invalidResponse
    case noDataFound
    case normalizeError(Error?)
    
    var errorDescription: String? {
        switch self {
        case .limitReached:
            return "Your API calling limit is reached. Please try again after 24 hhours. Thank You!"
        case .invalidResponse:
            return "Something went worng!"
        case .noDataFound:
            return "No data found in response!"
        case .normalizeError(let error):
            guard let error = error else {
                return "No proper error description found!"
            }
            return "Encountered error: \(error.localizedDescription)"
        
        }
    }
}
