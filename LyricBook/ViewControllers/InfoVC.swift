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
    let aboutTextView = LBSongTextView()
    let technologiesHeader = LBTitleLabel(textAlignment: .left, fontSize: 30)
    let techTextView = LBSongTextView()
    let githubButton = LBButton(text: "Github", Color: .systemRed)
    let logo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Information"
        setupAboutTextView()
        setupTechnologiesHeaderLabel()
        setupTechTextView()
        setupLogoImage()
        setupGithubButton()
    }
    
    func setupAboutTextView() {
        view.addSubview(aboutTextView)
        aboutTextView.text = "This app was created to allow the user to add their favourite songs to a storage medium and access them when they need to. I decided upon this layout while completing an iOS Developer course delivered by Sean Allen. I hope you enjoy the app and the features i've provided. If you have any questions please don't hesistate to message me at @AndrewLawlerDev on Twitter."

        NSLayoutConstraint.activate([
            aboutTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            aboutTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            aboutTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            aboutTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupTechnologiesHeaderLabel() {
        view.addSubview(technologiesHeader)
        technologiesHeader.text = "Technologies"
        
        NSLayoutConstraint.activate([
            technologiesHeader.topAnchor.constraint(equalTo: aboutTextView.bottomAnchor, constant: 20),
            technologiesHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            technologiesHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            technologiesHeader.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func setupTechTextView() {
        view.addSubview(techTextView)
        techTextView.text = "This app uses programmatic UI, Custom Alerts, Core Data, JSON Decoable blocks and also a Lyric API."
        
        NSLayoutConstraint.activate([
            techTextView.topAnchor.constraint(equalTo: technologiesHeader.bottomAnchor, constant: 20),
            techTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            techTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            techTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
      
    }
    
    func setupLogoImage() {
        view.addSubview(logo)
        logo.image = UIImage(named: "Logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: techTextView.bottomAnchor, constant: -80),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 200),
            logo.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    func setupGithubButton() {
        view.addSubview(githubButton)
        githubButton.addTarget(self, action: #selector(pushGithubSafariVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            githubButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            githubButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            githubButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            githubButton.heightAnchor.constraint(equalToConstant: 50)
        ])
       
        
    }
    
    @objc func pushGithubSafariVC() {
        launchGithub()
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
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
}
