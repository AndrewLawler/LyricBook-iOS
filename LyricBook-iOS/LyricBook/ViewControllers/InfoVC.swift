//
//  InfoVC.swift
//  LyricBook
//
//  Created by Andrew Lawler on 03/01/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import UIKit
import SafariServices

class InfoVC: UIViewController {
    
    // UI Elements
    let bioHeader = LBTitleLabel(textAlignment: .left, fontSize: 20)
    let aboutTextView = LBSongTextView()
    let technologiesHeader = LBTitleLabel(textAlignment: .left, fontSize: 20)
    let techTextView = LBSongTextView()
    let usageHeader = LBTitleLabel(textAlignment: .left, fontSize: 20)
    let usageTextView = LBSongTextView()
    let twitterButton = LBButton(text: "Twitter", Color: .systemBlue)
    let githubButton = LBButton(text: "Github", Color: .systemGreen)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Information"
        setupBioHeader()
        setupAboutTextView()
        setupTechnologiesHeaderLabel()
        setupTechTextView()
        setupUsageHeader()
        setupUsageTextView()
        setupTwitterButton()
        setupGithubButton()
    }
    
    func setupBioHeader() {
        view.addSubview(bioHeader)
        bioHeader.text = "About"
        
        NSLayoutConstraint.activate([
            bioHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            bioHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            bioHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bioHeader.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupAboutTextView() {
        view.addSubview(aboutTextView)
        aboutTextView.text = "This app was created to allow the user to add their favourite songs to a storage medium and access them when they need to. I decided upon this layout while completing an iOS Developer course delivered by Sean Allen. I hope you enjoy the app and the features i've provided."

        NSLayoutConstraint.activate([
            aboutTextView.topAnchor.constraint(equalTo: bioHeader.bottomAnchor, constant: 0),
            aboutTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            aboutTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            aboutTextView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    func setupTechnologiesHeaderLabel() {
        view.addSubview(technologiesHeader)
        technologiesHeader.text = "Technologies"
        
        NSLayoutConstraint.activate([
            technologiesHeader.topAnchor.constraint(equalTo: aboutTextView.bottomAnchor, constant: 0),
            technologiesHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            technologiesHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            technologiesHeader.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func setupTechTextView() {
        view.addSubview(techTextView)
        techTextView.text = "This app uses programmatic UI, Custom Alerts, Core Data, JSON Decoable blocks and also a Lyric API."
        
        NSLayoutConstraint.activate([
            techTextView.topAnchor.constraint(equalTo: technologiesHeader.bottomAnchor, constant: 0),
            techTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            techTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            techTextView.heightAnchor.constraint(equalToConstant: 80)
        ])
      
    }
    
    func setupUsageHeader() {
        view.addSubview(usageHeader)
        usageHeader.text = "How to use"
        
        NSLayoutConstraint.activate([
            usageHeader.topAnchor.constraint(equalTo: techTextView.bottomAnchor, constant: 0),
            usageHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            usageHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usageHeader.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
    
    func setupUsageTextView() {
        view.addSubview(usageTextView)
        usageTextView.text = "To use the app simply enter an artist name and a song name, the app will then take your input and create a custom url in the format (https://api.lyrics.ovh/v1/nameOfband/nameOfSong) this will then ping the Lyric API and get the lyrics for you."
        
        NSLayoutConstraint.activate([
            usageTextView.topAnchor.constraint(equalTo: usageHeader.bottomAnchor, constant: 0),
            usageTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usageTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usageTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setupTwitterButton() {
        view.addSubview(twitterButton)
        twitterButton.addTarget(self, action: #selector(pushTwitterSafariVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            twitterButton.topAnchor.constraint(equalTo: usageTextView.bottomAnchor, constant: 20),
            twitterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            twitterButton.widthAnchor.constraint(equalToConstant: 175),
            twitterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupGithubButton() {
        view.addSubview(githubButton)
        githubButton.addTarget(self, action: #selector(pushGithubSafariVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            githubButton.topAnchor.constraint(equalTo: usageTextView.bottomAnchor, constant: 20),
            githubButton.widthAnchor.constraint(equalToConstant: 175),
            githubButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            githubButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func pushGithubSafariVC() {
        launchGithub()
    }
    
    @objc func pushTwitterSafariVC() {
        launchTwitter()
    }
    

}

extension InfoVC: SFSafariViewControllerDelegate {
    
    func launchGithub() {
        let urlString = "https://github.com/AndrewLawler/LyricBook-iOS"
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    func launchTwitter() {
        let urlString = "https://twitter.com/andrewlawlerdev"
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
}
