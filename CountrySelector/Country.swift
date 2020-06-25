//
//  Country.swift
//  CountrySelector
//
//  Created by Sagun Raj Lage on 6/24/20.
//

import Foundation

struct Country: Codable, Identifiable {
    let name: String
    let flag: String
    let continent: String
    var id: String { name }
}
