import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(configuration: ConfigurationAppIntent(), date: Date(), quoteIndex: 0, fontIndex: 0)
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(configuration: configuration, date: Date(), quoteIndex: 0, fontIndex: 0)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< quotes.count {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(configuration: configuration, date: entryDate, quoteIndex: 0, fontIndex: hourOffset)
            entries.append(entry)
        }
        
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let configuration: ConfigurationAppIntent
    let date: Date
    let quoteIndex: Int
    let fontIndex: Int
}

struct ApopthegmataWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        let q = quotes[withinQuoteIndex(x: entry.quoteIndex)]
        VStack {
            QuoteDisplayView(author: q.a, text: q.t, font: q.f ?? fonts[withinFontIndex(x: entry.fontIndex)], inWidget: true)
        }
    }
}

struct ApopthegmataWidget: Widget {
    static let TITLE = "Ancient Greek sayings with beautiful typography"
    static let DESCRIPTION = "Ancient Greek sayings with beautiful typography, updated at a time interval of your choosing."
    
    let kind: String = "widget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
                ApopthegmataWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            }
            .configurationDisplayName(ApopthegmataWidget.TITLE)
            .description(ApopthegmataWidget.DESCRIPTION)
            .supportedFamilies([.systemMedium])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        return intent
    }
}
