//
//  ContentView.swift
//  newsapp
//
//  Created by Saw James Bright Son on 04/06/2022.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit

struct HomeView: View {
    @ObservedObject var list = HomeViewModel()
    
    var body: some View {
        NavigationView{
            List(list.datas){i in
                NavigationLink(destination:
                                articleView(url: i.url).navigationBarTitle("",displayMode: .inline)){
                    HStack(spacing: 10){
                        VStack(alignment: .leading, spacing: 10){
                            Text(i.title).fontWeight(.heavy)
                            Text(i.description).lineLimit(3)
                        }
                        
                        if i.image != ""{
                            WebImage(url: URL(string: i.image)!,options: .highPriority,context: nil).resizable().frame(width: 120,height: 100).cornerRadius(15).aspectRatio(contentMode: .fit)
                        }
                        
                        
                    }.padding(.vertical,15)
                }
                
                
            }.navigationBarTitle("Articles")
        }
    }
}

struct articleView : UIViewRepresentable {
    var url: String
    func makeUIView(context: UIViewRepresentableContext<articleView>) -> WKWebView{
        let view = WKWebView()
        view.load(URLRequest(url: URL(string: url)!))
        return view
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
