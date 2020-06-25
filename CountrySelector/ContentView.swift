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
        guard let _ = try? JSONDecoder().decode(Country.self,
                                                          from: selectedCountry) else {
            storeData(with: countries[0])
            return
        }
    }
    
    var body: some View {
            HStack {
                ForEach(countries) { country in
                    CountryView(country: country)
                        .onTapGesture {
                            self.selectCountry(country)
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
