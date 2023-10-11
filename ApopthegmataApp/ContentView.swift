import SwiftUI
import CoreFoundation
import WidgetKit

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

struct GlassCard: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .padding()
                .frame(height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(14)
        } else {
            // Fallback on earlier versions
            content
                .padding()
                .frame(height: 50)
                .cornerRadius(14)
        }
    }
}

struct ContentView: View {
    @State var fontSelection: Int = 0
    @State var quoteIndex: Int = 0
    @State var settingsShown: Bool = false
    @AppStorage("dismissedWidgetAlert_10") var dismissedWidgetAlert: Bool = false
    @State var isWidgetInstalled: Bool?
    
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
            .onAppear {
                WidgetCenter.shared.getCurrentConfigurations { res in
                    switch res {
                    case .success(let widgets):
                        self.isWidgetInstalled = widgets.count != 0
                    case .failure:
                        self.isWidgetInstalled = false
                    }
                }
            }
            .overlay(alignment: .center) {
                if isWidgetInstalled == false && !dismissedWidgetAlert {
                    VStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        HStack {
                            Text("Check out the Home Screen widget!")
                        }.modifier(GlassCard())
                            .overlay(alignment: .topTrailing, content: {
                                Button(action: {
                                 dismissedWidgetAlert = true
                                }, label: {
                                    ZStack {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                                    }
                                }).offset(x: 8, y: -8)
                            })
                        Spacer()
                    }
                }
            }
            .overlay(alignment: .bottom) {
                HStack {
                    Button(action: {
                        withAnimation {
                            quoteIndex = withinQuoteIndex(x: randomQuoteIndex())
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                    .padding(.horizontal)
                    .contentShape(Rectangle())
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
