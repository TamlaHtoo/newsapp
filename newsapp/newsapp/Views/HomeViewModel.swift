//
//  HomeViewModel.swift
//  newsapp
//
//  Created by Saw James Bright Son on 06/06/2022.
//

import Foundation
import SwiftyJSON

class HomeViewModel: ObservableObject{
    
    @Published var datas = [ articleModel]()
    
    init () {
        let source = "https://newsapi.org/v2/top-headlines?country=us&apiKey=309b179dd4434eb6bbbca856f117128d"
        
        let url = URL(string: source)!
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, _, err in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            
            for i in json["articles"]{
                let title = i.1["title"].stringValue
                let description = i.1["description"].stringValue
                let url = i.1["url"].stringValue
                let image = i.1["urlToImage"].stringValue
                let id = i.1["publishedAt"].stringValue
                
                
                DispatchQueue.main.async {
                    self.datas.append(articleModel(id: id, title: title, description: description, url: url, image: image))
                }
                
            }
        }.resume()
        
    }
}
