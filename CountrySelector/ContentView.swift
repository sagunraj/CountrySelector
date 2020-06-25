//
//  ContentView.swift
//  CountrySelector
//
//  Created by Sagun Raj Lage on 6/24/20.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("selectedCountry", store: UserDefaults(suiteName: "group.np.com.sagunrajlage.CountrySelector"))
    var selectedCountry: Data = Data()
    
    let countries = [
        Country(name: "Nepal", flag: "🇳🇵", continent: "Asia"),
        Country(name: "USA", flag: "🇺🇸", continent: "North America"),
        Country(name: "United Kingdom", flag: "🇬🇧", continent: "Europe"),
        Country(name: "France", flag: "🇫🇷", continent: "Europe"),
        Country(name: "China", flag: "🇨🇳", continent: "Asia"),
        Country(name: "India", flag: "🇮🇳", continent: "Asia"),
        Country(name: "Australia", flag: "🇦🇺", continent: "Australia")
    ]
    
    init() {
        storeData(with: countries[0])
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(countries) { country in
                    CountryView(country: country)
                        .onTapGesture {
                            self.selectCountry(country)
                        }
                }
            }
        }
    }
    
    private func selectCountry(_ country: Country) {
        print(country)
        storeData(with: country)
    }
    
    private func storeData(with country: Country) {
        guard let encodedData = try? JSONEncoder().encode(country) else { return }
        selectedCountry = encodedData
    }
}
