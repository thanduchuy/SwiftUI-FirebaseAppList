//
//  Note.swift
//  FirebasexCombine
//
//  Created by than.duc.huy on 20/07/2021.
//

import Foundation

struct Note: Codable, Hashable, Equatable {
    let content: String
    let timeAdd: Date

    var formatDate: String {
        get {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormat.string(from: timeAdd)
        }
    }

    public static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.content == rhs.content
            && lhs.formatDate == rhs.formatDate
    }
}
