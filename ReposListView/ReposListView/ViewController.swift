//
//  ViewController.swift
//  ReposListView
//
//  Created by Alexandru Dinu on 25/06/2019.
//  Copyright © 2019 noname. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var repos: [Repos] = []
    var images: [UIImage] = [UIImage(),UIImage(),UIImage(),UIImage(),UIImage(),UIImage(),UIImage(),UIImage(),UIImage(),UIImage()]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AppRequests.init().publicReposRequest { [weak self] (result) in
            switch result {
            case .success(let repos):
                self?.repos = repos
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count > 10 ? 10 : repos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        loadImageFor(cell: cell, at: indexPath)
        cell.textLabel?.text = repos[indexPath.row].name
        cell.imageView?.image = images[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Repos List"
    }

    func loadImageFor(cell: UITableViewCell, at indexPath: IndexPath) {

        let _ = AppRequests.init().downloadImage(imageUrl: repos[indexPath.row].owner.avatar_url, completion: { [weak self] (image) in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                self?.images[indexPath.row] = image
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
        })
    }

}

