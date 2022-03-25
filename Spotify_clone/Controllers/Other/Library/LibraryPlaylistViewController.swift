//
//  LibraryPlaylistViewController.swift
//  Spotify_clone
//
//  Created by sungyeon kim on 2022/03/19.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {
    
    var playlists = [Playlist]()
    
    public var selectionHandler: ((Playlist) -> Void)?
    
    private let noPlaylistsView = ActionLabelView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setUpNoPlaylistView()

        fetchData()
        
        if selectionHandler != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
        tableView.frame = view.bounds
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
            tableView.isHidden = true
        } else {
            // show Table
            tableView.reloadData()
            noPlaylistsView.isHidden = true
            tableView.isHidden = false
        }
    }

    public func showCreatePlaylistAlert() {
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
            APICaller.shared.createPlaylist(with: text) { [weak self] success in
                if success {
                    // Refresh list of playlists
                    self?.fetchData()
                } else {
                    print("Failed to create playlist")
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LibraryPlaylistViewController: ActionLabelViewDelegate {
    func ActionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        //Show Creation UI
        showCreatePlaylistAlert()
    }
    
}

extension LibraryPlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let playlist = playlists[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(title: playlist.name, subtitle: playlist.owner.display_name, imageURL: URL(string: playlist.images.first?.url ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let playlist = self.playlists[indexPath.row]
        guard selectionHandler == nil else {
            selectionHandler?(playlist)
            dismiss(animated: true, completion: nil)
            return
        }
 
        let vc = PlaylistViewController(playlist: playlist)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.isOwner = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
