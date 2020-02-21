//
//  SearchSongVC.swift
//  LyricBook
//
//  Created by Andrew Lawler on 03/01/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit
import CoreData

class SearchSongVC: UIViewController {
    
    // Assets
    let logo = UIImageView()
    let songNameField = LBTextFieldSong(placeholder: "Enter a song name")
    let artistNameField = LBTextFieldArtist(placeholder: "Enter an Artist name")
    let getSongButton = LBButton(text: "Get Lyrics", Color: .systemRed)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNav()
        setupLogo()
        setupArtistNameField()
        setupSongNameField()
        setupSongButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func setupNav() {
        title = ""
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(pushInfoVC), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = barButton
        navigationController?.navigationBar.tintColor = .systemRed
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushShowSongVC() {
        
        if songNameField.text != "" && artistNameField.text != "" {
            let showsongvc = ShowSongVC()
            showsongvc.songName = songNameField.text
            showsongvc.artistName = artistNameField.text
            songNameField.text = ""
            artistNameField.text = ""
            navigationController?.pushViewController(showsongvc, animated: true)
        }
        else {
            presentLBAlertOnMainThread(title: "Empty Fields", message: "Please enter a song or an artist to search.", buttonTitle: "Ok")
        }
        
    }
    
    @objc func pushInfoVC() {
        let infovc = InfoVC()
        navigationController?.pushViewController(infovc, animated: true)
    }
    
    func setupLogo() {
        view.addSubview(logo)
        logo.image = UIImage(named: "Logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 300),
            logo.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setupArtistNameField() {
        view.addSubview(artistNameField)
        
        artistNameField.delegate = self
        
        NSLayoutConstraint.activate([
            artistNameField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 55),
            artistNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            artistNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            artistNameField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupSongNameField() {
        view.addSubview(songNameField)
        
        songNameField.delegate = self
        
        NSLayoutConstraint.activate([
            songNameField.topAnchor.constraint(equalTo: artistNameField.bottomAnchor, constant: 20),
            songNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            songNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            songNameField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func setupSongButton() {
        view.addSubview(getSongButton)
        
        getSongButton.addTarget(self, action: #selector(pushShowSongVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getSongButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            getSongButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            getSongButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            getSongButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    

}

extension SearchSongVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // forces keyboard to not be present when you come back to the search screen
        view.endEditing(true)
        // this checks if the user has entered an artist and now wants to go to the song field, if so, open the song field text input
        if artistNameField.text != "" && songNameField.text == "" {
            songNameField.becomeFirstResponder()
        }
        else {
            // finished completely, go and show the song
            pushShowSongVC()
        }
        return true
    }
    
}
