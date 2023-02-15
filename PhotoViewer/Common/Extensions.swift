//
//  Extensions.swift
//  PhotoViewer
//
//  Created by iMAC on 15/02/23.
//

import Foundation
import SwiftUI

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard let url = URL(string: "\(value)") else {
            fatalError("Invalid URL string literal: \(value)")
        }
        self = url
    }
}

extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let jsonData = try? JSONEncoder().encode(self) else { return nil }
        guard let jsonDict = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else { return nil }
        return jsonDict
    }
}

extension Optional where Wrapped == String {
    
    var stringValue: String {
        guard let self = self else { return .empty }
        return self
    }
}

extension String {
    static let empty = ""
}

extension Binding {
    public func defaultValue<T>(_ value: T) -> Binding<T> where Value == Optional<T> {
        Binding<T> {
            wrappedValue ?? value
        } set: {
            wrappedValue = $0
        }
    }
}
