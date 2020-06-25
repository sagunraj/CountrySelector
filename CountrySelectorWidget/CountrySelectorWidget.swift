//
//  CountrySelectorWidget.swift
//  CountrySelectorWidget
//
//  Created by Sagun Raj Lage on 6/25/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    @AppStorage("selectedCountry", store: UserDefaults(suiteName: "group.np.com.sagunrajlage.CountrySelector"))
    var selectedCountry: Data = Data()
    
    public typealias Entry = SimpleEntry
    
    public func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        var entry: SimpleEntry
        if let decodedData = try? JSONDecoder().decode(Country.self, from: selectedCountry) {
            entry = SimpleEntry(date: Date(), country: decodedData)
        } else {
            entry = SimpleEntry(date: Date(), country: Country(name: "Nepal", flag: "🇳🇵", continent: "Asia"))
        }
        completion(entry)
    }
    
    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entry: SimpleEntry
        
        if let decodedData = try? JSONDecoder().decode(Country.self, from: selectedCountry) {
            entry = SimpleEntry(date: Date(), country: decodedData)
        } else {
            entry = SimpleEntry(date: Date(), country: Country(name: "Nepal", flag: "🇳🇵", continent: "Asia"))
        }
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let country: Country
}

struct PlaceholderView : View {
    var body: some View {
        VStack {
            Text("🇳🇵")
                .font(.largeTitle)
            Text("Nepal").font(.title2).multilineTextAlignment(.center)
            Text("Asia").font(.caption)
        }
    }
}

struct CountrySelectorWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            VStack {
                Text(entry.country.flag)
                    .font(.largeTitle)
                Text(entry.country.name).font(.title2).multilineTextAlignment(.center)
                Text(entry.country.continent).font(.caption)
            }
        case .systemMedium:
            VStack {
                Text(entry.country.flag)
                    .font(.largeTitle)
                Text("Your current country is \(entry.country.name), \(entry.country.continent).").font(.title).multilineTextAlignment(.center)
            }
        case .systemLarge:
            VStack {
                Text(entry.country.flag)
                    .font(.largeTitle)
                Text("Your current country is \(entry.country.name).").font(.largeTitle).multilineTextAlignment(.center)
                Text("It lies in \(entry.country.continent).").font(.title3)
            }
        @unknown default:
            fatalError()
        }
    }
}

@main
struct CountrySelectorWidget: Widget {
    private let kind: String = "CountrySelectorWidget"
    
    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            CountrySelectorWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemLarge, .systemMedium, .systemSmall])
        .configurationDisplayName("Country Selector Widget")
        .description("Displays your current country.")
    }
}
