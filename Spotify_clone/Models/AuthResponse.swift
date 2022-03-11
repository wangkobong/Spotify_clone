//
//  AuthResponse.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/11.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}
