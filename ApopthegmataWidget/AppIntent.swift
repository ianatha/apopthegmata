import WidgetKit
import AppIntents

enum RefreshInterval: String, AppEnum {
    case minutes5, hourly, daily, weekly
    
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Refresh Interval"
    static var caseDisplayRepresentations: [RefreshInterval : DisplayRepresentation] = [
        .minutes5: "Every 30 minutes",
        .hourly: "Every hour",
        .daily: "Every day",
        .weekly: "Every week",
    ]
}

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource =  "Ancient Greek sayings with beautiful typography"
    static var description = IntentDescription("Ancient Greek sayings with beautiful typography, updated at a time interval of your choosing.")
    
    @Parameter(title: "Refresh", default: .daily)
    var interval: RefreshInterval
}
