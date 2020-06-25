//
//  CountryView.swift
//  CountrySelector
//
//  Created by Sagun Raj Lage on 6/24/20.
//

import SwiftUI

struct CountryView: View {
    
    let country: Country
    
    var body: some View {
        Text(country.flag)
            .font(.largeTitle)
            .background(Color.gray)
            .clipShape(Circle())
    }
}
