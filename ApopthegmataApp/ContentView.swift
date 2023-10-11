import SwiftUI

struct GlassCard<ContentView: View>: View {
    var content: ContentView
    
    var body: some View {
        VStack {
            content
        }
    }
}

struct QuoteDisplayView: View {
    var text: String
    var font: String
    
    var body: some View {
        if text.contains("\n") {
            Text(text)
                .font(.custom(font, size: 46))
                .padding()
        } else {
            Text(text)
                .font(.custom(font, size: 46))
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
struct ContentView: View {
    @AppStorage("selectedFont") var fontSelection: Int = 0
    @State var quoteIndex: Int = randomQuoteIndex()
    @State var settingsShown: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack {
                    Spacer()
                    QuoteDisplayView(text: quotes[withinQuoteIndex(x: quoteIndex)], font: fonts[withinFontIndex(x: fontSelection)])
                    Spacer()
                }.frame(
                    minWidth: geometry.size.width,
                    maxWidth:.infinity,
                    minHeight: geometry.size.height,
                    maxHeight: .infinity)
            }
            .frame(
                minWidth: geometry.size.width,
                maxWidth: .infinity,
                minHeight:geometry.size.height,
                maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                HStack {
                    Button(action: {
                        withAnimation {
                            quoteIndex = withinQuoteIndex(x: randomQuoteIndex())
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }.padding(.horizontal)
                    Stepper(
                        value: $fontSelection,
                        in: 0...fonts.count-1
                    ) {
                        Text("")
                    }.padding(.horizontal)
                }.padding().ignoresSafeArea()
            }
        }
    }
}

#Preview {
    ContentView()
}
