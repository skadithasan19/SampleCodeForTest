//
//  Pull.swift
//  SampleCodeForTest
//
//  Created by iOSVenture LLC on 3/5/21.
//

import Foundation

struct Pull: Codable {
    var id: Int
    var node_id: String
    var state: AppState?
    var title: String
    var user: User?
    var body: String
    var created_at: Date
    
    enum CodingKeys: CodingKey {
        case id
        case node_id
        case state
        case title
        case user
        case body
        case created_at
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        node_id = try values.decodeIfPresent(String.self, forKey: .node_id) ?? ""
        let stateData = try values.decodeIfPresent(String.self, forKey: .state) ?? ""
        state = AppState(rawValue: stateData)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        user = try values.decodeIfPresent(User.self, forKey: .user)
        body = try values.decodeIfPresent(String.self, forKey: .body) ?? ""
        let dataSring = try values.decodeIfPresent(String.self, forKey: .created_at) ?? ""
        created_at = Date()
    }
}

struct User: Codable, Identifiable {
    var id: Int
    var login: String
    var avatar_url: String
}


enum AppState: String, Codable {
    case open, close, all
    init(rawValue: String) {
        switch rawValue {
            case "open": self = .open
            case "close": self = .close
            default: self = .all
        }
    }
}
