//
//  Constants.swift
//  SecretChat
//
//  Created by Minna on 01/05/21.
//


struct K {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageTableCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let appName = "💞Couple Chat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "messge"
        static let dateField = "date"
    }
}

