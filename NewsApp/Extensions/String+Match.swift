//
//  String+Match.swift
//  NewsApp
//
//  Created by Ken Mueller //-> https://stackoverflow.com/questions/27880650/swift-extract-regex-matches
//

import Foundation

extension String {
    func match(_ regex: String) -> [[String]] {
        let nsString = self as NSString
        return (try? NSRegularExpression(pattern: regex))?.matches(in: self, range: NSMakeRange(0, count)).map { match in
            (0..<match.numberOfRanges).map { match.range(at: $0).location == NSNotFound ? "" : nsString.substring(with: match.range(at: $0)) }
        } ?? []
    }
}
