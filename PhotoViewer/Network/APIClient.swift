//
//  APIClient.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import Foundation

protocol APIRequestable {
    associatedtype ResponseType: Decodable
    var baseURL: URL { get }
    var path: String? { get }
    var queryParameters: [String: Any]? { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Data? { get }
}

enum HTTPMethod: String {
    case delete, get, patch, post, put
}

extension APIRequestable {
    
    var baseURL: URL { "https://jsonplaceholder.typicode.com" }
    
    var path: String? { nil }
    
    var queryParameters: [String: Any]? { nil }
    
    var httpMethod: HTTPMethod { .get }
    
    var httpBody: Data? { nil }
    
    var asURL: URL? {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { return nil }
        if let path { components.path = baseURL.path.appending(path) }
        if let queryParameters {
            components.queryItems = queryParameters.map {
                .init(name: $0, value: "\($1)")
            }
        }
        return components.url
    }
    
    var asURLRequest: URLRequest? {
        guard let url = asURL else { return nil }
        var request: URLRequest = .init(url: url)
        request.httpMethod = httpMethod.rawValue
        if let httpBody { request.httpBody = httpBody }
        return request
    }
}



enum APIClientError: Error {
    case invalidRequest
    case noData
    case decodingError(Error)
    case networkError(Error)
    case unknownError(Error)
}

enum APIResult<T: APIRequestable> {
    case success(T.ResponseType)
    case failure(APIClientError)
}

extension APIResult {
    
    var value: T.ResponseType? {
        if case .success(let result) = self { return result }
        else { return nil }
    }
    
    var error: APIClientError? {
        if case .failure(let error) = self { return error }
        else { return nil }
    }
}

class APIClient {
    
    static func fetch<T: APIRequestable>(request: T) async -> APIResult<T> {
        guard let urlRequest = request.asURLRequest else {
            return .failure(.invalidRequest)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let model = try JSONDecoder().decode(T.ResponseType.self, from: data)
            return .success(model)
        } catch let decodingError as DecodingError {
            return .failure(.decodingError(decodingError))
        } catch let urlError as URLError {
            return .failure(.networkError(urlError))
        } catch {
            return .failure(.unknownError(error))
        }
    }
}
