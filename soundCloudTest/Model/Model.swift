//
//  Model.swift
//  soundCloudTest
//
//  Created by kennyS on 4/25/20.
//  Copyright © 2020 kennyS. All rights reserved.
//

import Foundation

struct PlayList: Codable {
    var duration: Double?
    var releaseDay: Double?
    var permalinkURL: String?
    var genre: String?
    var permalink: String?
    var purchaseURL: String?
    var releaseMonth: Double?
    var welcomeDescription: String?
    var uri: String?
    var labelName: String?
    var tagList: String?
    var releaseYear: Double?
    var trackCount: Double?
    var userID: Double?
    var lastModified: String?
    var license: String?
    var tracks: [Track]?
    var playlistType: String?
    var id: Double?
    var downloadable: Bool?
    var sharing: String?
    var createdAt: String?
    var release: String?
    var kind: String?
    var title: String?
    var type: String?
    var purchaseTitle: String?
    var artworkURL: String?
    var ean: String?
    var streamable: Bool?
    var user: User?
    var embeddableBy: String?
    var labelID: Double?

    enum CodingKeys: String, CodingKey {
        case duration
        case releaseDay = "release_day"
        case permalinkURL = "permalink_url"
        case genre, permalink
        case purchaseURL = "purchase_url"
        case releaseMonth = "release_month"
        case welcomeDescription = "description"
        case uri
        case labelName = "label_name"
        case tagList = "tag_list"
        case releaseYear = "release_year"
        case trackCount = "track_count"
        case userID = "user_id"
        case lastModified = "last_modified"
        case license, tracks
        case playlistType = "playlist_type"
        case id, downloadable, sharing
        case createdAt = "created_at"
        case release, kind, title, type
        case purchaseTitle = "purchase_title"
        case artworkURL = "artwork_url"
        case ean, streamable, user
        case embeddableBy = "embeddable_by"
        case labelID = "label_id"
    }
}

// MARK: - Track
struct Track: Codable {
    var kind: String?
    var id: Double?
    var createdAt: String?
    var userID: Double?
    var duration: Double?
    var commentable: Bool?
    var state: String?
    var originalContentSize: Double?
    var lastModified: String?
    var sharing: String?
    var tagList, permalink: String?
    var streamable: Bool?
    var embeddableBy: String?
    var downloadable: Bool?
    var purchaseURL: String?
    var labelID: Double?
    var purchaseTitle, genre: String?
    var title: String?
    var trackDescription: String?
    var labelName: String?
    var release: String?
    var trackType: String?
    var keySignature: String?
    var isrc: String?
    var videoURL: String?
    var bpm: Double?
    var releaseYear: Double?
    var releaseMonth: Double?
    var releaseDay: Double?
    var originalFormat: String?
    var license: String?
    var uri: String?
    var user: User?
    var permalinkURL: String?
    var artworkURL: String?
    var waveformURL: String?
    var streamURL: String?
    var playbackCount: Double?
    var downloadCount: Double?
    var favoritingsCount: Double?
    var commentCount: Double?
    var downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case kind, id
        case createdAt = "created_at"
        case userID = "user_id"
        case duration, commentable, state
        case originalContentSize = "original_content_size"
        case lastModified = "last_modified"
        case sharing
        case tagList = "tag_list"
        case permalink, streamable
        case embeddableBy = "embeddable_by"
        case downloadable
        case purchaseURL = "purchase_url"
        case labelID = "label_id"
        case purchaseTitle = "purchase_title"
        case genre, title
        case trackDescription = "description"
        case labelName = "label_name"
        case release
        case trackType = "track_type"
        case keySignature = "key_signature"
        case isrc
        case videoURL = "video_url"
        case bpm
        case releaseYear = "release_year"
        case releaseMonth = "release_month"
        case releaseDay = "release_day"
        case originalFormat = "original_format"
        case license, uri, user
        case permalinkURL = "permalink_url"
        case artworkURL = "artwork_url"
        case waveformURL = "waveform_url"
        case streamURL = "stream_url"
        case playbackCount = "playback_count"
        case downloadCount = "download_count"
        case favoritingsCount = "favoritings_count"
        case commentCount = "comment_count"
        case downloadURL = "download_url"
    }
}

// MARK: - User
struct User: Codable {
    var id: Double?
    var kind: String?
    var permalink: String?
    var username: String?
    var lastModified: String?
    var uri: String?
    var permalinkURL: String?
    var avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case id, kind, permalink, username
        case lastModified = "last_modified"
        case uri
        case permalinkURL = "permalink_url"
        case avatarURL = "avatar_url"
    }
}
