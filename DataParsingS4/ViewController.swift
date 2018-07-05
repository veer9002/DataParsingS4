//
//  ViewController.swift
//  DataParsingS4
//
//  Created by Syon on 16/05/18.
//  Copyright © 2018 Syon. All rights reserved.
//

import UIKit

struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
}

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    
    
    
//    // constructor
//    init(json: [String: Any]) {
//        id = json["id"] as? Int ?? -1
//        name = json["name"] as? String ?? ""
//        link = json["link"] as? String ?? ""
//        imageUrl = json["imageUrl"] as? String ?? ""
//    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // single array
//        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/course"
        
//        // multiple array values
//        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        
        // website decription
//        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        
        // missing fields in response
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        
        
        guard let url = URL(string: jsonUrlString) else { return }
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
//            let dataAsString = String(data: data, encoding: .utf8)
//            print(dataAsString)

            do {
//                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
//                print(websiteDescription.name)
//                print(websiteDescription.description)
//                print(websiteDescription.courses)
                
                let course = try JSONDecoder().decode([Course].self, from: data)
                print(course)
                
                
//                // swift 2,3,obj C
//
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
//                print(json)
//
//                let course = Course(json: json)
//                print(course.name)
            } catch let jsonErr {
                print("Error in json serialization", jsonErr)
            }
            
        }.resume()
    }
}

