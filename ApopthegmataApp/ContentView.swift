import SwiftUI
import CoreFoundation

extension String {
    func removingAccents() -> String {
        let mutableString = NSMutableString(string: self) as CFMutableString
        CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false)
        return String(mutableString)
    }
}

struct QuoteDisplayView: View {
    var author: String?
    var text: String
    var font: String
    var inWidget: Bool = false
    
    var body: some View {
        VStack {
            Text(text)
                .font(.custom(font, size: inWidget ? 32 : 46))
                .multilineTextAlignment(.center)
                .padding()
            if let author = author {
                if inWidget {
                    Text(author.removingAccents()).textCase(.uppercase).foregroundColor(.gray).font(.custom("GFSComplutum-Regular", size: 10)).fontWeight(.bold)
                } else {
                    Text(author.removingAccents()).textCase(.uppercase).foregroundColor(.gray).font(.custom("GFSComplutum-Regular", size: 15))
                        .padding(.top)
                }
            }
        }
    }
}

struct ContentView: View {
    @State var fontSelection: Int = 0
    @State var quoteIndex: Int = randomQuoteIndex()
    @State var settingsShown: Bool = false
    
    var body: some View {
        let q = quotes[withinQuoteIndex(x: quoteIndex)]
        GeometryReader { geometry in
            HStack {
                VStack {
                    Spacer()
                    QuoteDisplayView(author: q.a, text: q.t, font: q.f ?? fonts[withinFontIndex(x: fontSelection)])
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
                    if quotes[withinQuoteIndex(x: quoteIndex)].f == nil {
                        HStack {
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
                        }.padding()
                    }
                }.padding().ignoresSafeArea()
            }
        }
    }
}

#Preview {
    ContentView()
}
