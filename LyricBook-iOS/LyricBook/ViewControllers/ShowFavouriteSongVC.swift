//
//  ShowFavouriteSongVC.swift
//  LyricBook
//
//  Created by Andrew Lawler on 03/01/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit
import CoreData

class ShowFavouriteSongVC: UIViewController {
    
    let songText = LBSongTextView()
    
    var songs: [NSManagedObject] = []

    var songName: String!
    var artistName: String!
    var currentCell: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreReload()
        setup()
        setupSongTextView()
        networkCall()
    }
    
    func coreReload(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Song")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                songs.append(data)
          }
        } catch {
            print("Failed")
        }
    }
    
    func setup() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "\(songName ?? "")"
        
        let infoButton = UIButton(type: .close)
        infoButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func closeButtonTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.delete(songs[currentCell])
        do
        {
        try context.save()
        } catch {
            print("changes failed")
        }
        navigationController?.popViewController(animated: true)
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
                let song = try decoder.decode(JSONSong.self, from: jsonData)
                DispatchQueue.main.async {
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
