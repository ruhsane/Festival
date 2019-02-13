//
//  ViewController.swift
//  festivals
//
//  Created by Ruhsane Sawut on 2/7/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

struct Participant: Codable {
    let name: String
    let id: String
}

struct City: Codable {
    let name: String
    let id: String
}

enum Type: String, Codable {
    case music
    case food
    case cinema
}

struct Festival: Codable{
    let date: Date
    let name: String
    let city: City
    let type: Type
    let lineup: [Participant]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var festivalArray = [Festival]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        let path = Bundle.main.path(forResource: "festivals", ofType: ".json")
        if let path = path {
            let url = URL(fileURLWithPath: path)
            print(url)
            let contents = try? Data(contentsOf: url, options: .alwaysMapped)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            if let data = contents,
                let festivals = try? decoder.decode([Festival].self, from: data){
                festivalArray = festivals
                for f in festivalArray {
                    for l in f.lineup {
                        print(l.name)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return festivalArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "festivalCell", for: indexPath) as! FestivalTableViewCell
        let fest = festivalArray[indexPath.row]
        
        cell.festivalNameLabel.text = fest.name
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        cell.festivalDateLabel.text = formatter.string(from: fest.date)
        
//        cell.peopleNumberLabel.text = "\(fest.lineup.count)"
        cell.peopleNumberLabel.text = String(fest.lineup.count)

        
        return cell
    }
    
}
