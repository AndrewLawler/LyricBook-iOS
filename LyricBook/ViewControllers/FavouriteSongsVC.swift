//
//  FavouriteSongsVC.swift
//  LyricBook
//
//  Created by Andrew Lawler on 03/01/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit
import CoreData

class FavouriteSongsVC: UIViewController {
    
    let tableView = UITableView()
    
    var safeArea: UILayoutGuide!
    
    var songName: [String] = []
    var songArtist: [String] = []
    var songs: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavAndView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearArrays()
        coreReload()
    }
    
    func clearArrays() {
        songs = []
        songName = []
        songArtist = []
    }
        
    func coreReload(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Song")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                songArtist.append(data.value(forKey: "artist") as! String)
                songName.append(data.value(forKey: "name") as! String)
                songs.append(data)
          }
        } catch {
            print("Failed")
        }
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func setupNavAndView() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
}

extension FavouriteSongsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.isUserInteractionEnabled = true
        
        let normalAttribute = [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 15)]
        let boldAttributes = [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 15)]
        
        let artistText = "\(songArtist[indexPath.row]) "
        let hyphenText = "-"
        let songText = " \(songName[indexPath.row])"
        
        let attributedString = NSMutableAttributedString(string: artistText, attributes: boldAttributes as [NSAttributedString.Key : Any])
        let hyphenString = NSMutableAttributedString(string: hyphenText, attributes: normalAttribute as [NSAttributedString.Key : Any])
        let songString = NSMutableAttributedString(string: songText, attributes: normalAttribute as [NSAttributedString.Key : Any])
        
        attributedString.append(hyphenString)
        attributedString.append(songString)
        
        cell.textLabel!.attributedText = attributedString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("working")
        let showfavouritesongvc = ShowFavouriteSongVC()
        showfavouritesongvc.songName = songName[indexPath.row]
        showfavouritesongvc.artistName = songArtist[indexPath.row]
        showfavouritesongvc.currentCell = indexPath.row
        navigationController?.pushViewController(showfavouritesongvc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            tableView.beginUpdates()
            if songName.count > 0 || songArtist.count > 0 {
                songName.remove(at: indexPath.row)
                songArtist.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            if songName.count==0 {
                tableView.isHidden = true
            }
            tableView.reloadData()
            context.delete(songs[indexPath.row])
            do
            {
            try context.save()
            } catch {
                print("changes failed")
            }
        }
    }
    
}
    
