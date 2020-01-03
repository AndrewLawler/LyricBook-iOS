//
//  ShowSongVC.swift
//  LyricBook
//
//  Created by Andrew Lawler on 03/01/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit
import CoreData

struct LyricSong: Decodable {
    var lyrics: String?
}

class ShowSongVC: UIViewController {
    
    let songText = LBSongTextView()

    var songName: String!
    var artistName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSongTextView()
        networkCall()
    }
    
    func setup() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "\(songName ?? "")"
        
        let infoButton = UIButton(type: .contactAdd)
        infoButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func addButtonTapped() {
        coreSave()
        presentLBAlertOnMainThread(title: "Song added to favourites", message: "You have added \(songName!) by \(artistName!) to your favourites", buttonTitle: "Ok")
    }
    
    func coreSave(){
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let context = appDelegate.persistentContainer.viewContext
           let entity = NSEntityDescription.entity(forEntityName: "Song", in: context)
           let newSong = NSManagedObject(entity: entity!, insertInto: context)
           newSong.setValue(artistName, forKey: "artist")
           newSong.setValue(songName, forKey: "name")
           do {
              try context.save()
             } catch {
              print("Failed saving")
           }
       }
    
    func setupSongTextView() {
        view.addSubview(songText)
        
        NSLayoutConstraint.activate([
            songText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            songText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            songText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
    }
    
    func networkCall() {
        
        let nameOfband = artistName.replacingOccurrences(of: " ", with: "_")
        let nameOfSong = songName.replacingOccurrences(of: " ", with: "_")
        
        if let url = URL(string: "https://api.lyrics.ovh/v1/\(nameOfband)/\(nameOfSong)") {
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, err) in
            guard let jsonData = data else { return }
            do {
                // decode the JSON and populate an array
                let decoder = JSONDecoder()
                let song = try decoder.decode(LyricSong.self, from: jsonData)
                DispatchQueue.main.async {
                    print(song.lyrics)
                    if song.lyrics == nil {
                        self.songText.text = "There are no lyrics for this song / This song does not exist"
                    }
                    else {
                        self.songText.text = song.lyrics
                    }
                }
            } catch let jsonErr {
                print("Error decoding JSON", jsonErr)
            }
            }.resume()
        }
    }
    
    
    

}
