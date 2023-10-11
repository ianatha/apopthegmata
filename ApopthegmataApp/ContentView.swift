import SwiftUI

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
    @State var fontSelection: Int = 0
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
                    Spacer()
                    Button(action: {
                        if fontSelection > 0 {
                            fontSelection = fontSelection - 1
                        }
                    }) {
                        Image(systemName: "backward")
                    }
                    Button(action: {
                        if fontSelection < fonts.count-1 {
                            fontSelection = fontSelection + 1
                        }
                    }) {
                        Image(systemName: "forward")
                    }
                }.padding().ignoresSafeArea()
            }
        }
    }
}

#Preview {
    ContentView()
}
