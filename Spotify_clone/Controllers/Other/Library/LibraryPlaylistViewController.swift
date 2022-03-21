//
//  LibraryPlaylistViewController.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/19.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {
    
    var playlists = [Playlist]()
    
    private let noPlaylistsView = ActionLabelView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setUpNoPlaylistView()

        fetchData()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
    }
    
    private func setUpNoPlaylistView() {
        
        view.addSubview(noPlaylistsView)
        noPlaylistsView.delegate = self
        noPlaylistsView.configure(with: ActionLabelViewViewModel(text: "you dont have any playlists yet.", actionTitle: "Create"))
    }
    
    private func fetchData() {
        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            // show Label
            noPlaylistsView.isHidden = false
        } else {
            // show Table
        }
    }


}

extension LibraryPlaylistViewController: ActionLabelViewDelegate {
    func ActionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        //Show Creation UI
        let alert = UIAlertController(title: "New Playlists", message: "Enter playlist name", preferredStyle: .alert)
        alert.addTextField { textfield in
            textfield.placeholder = "Playlist..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                      return
                  }
            APICaller.shared.createPlaylist(with: text) { success in
                if success {
                    // Refresh list of playlists
                } else {
                    print("Failed to create playlist")
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
}
