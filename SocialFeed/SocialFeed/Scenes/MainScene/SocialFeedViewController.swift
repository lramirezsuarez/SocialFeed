//
//  SocialFeedViewController.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import UIKit
import SafariServices

class SocialFeedViewController: UIViewController {

    @IBOutlet weak var socialFeedTableView: UITableView!
    
    private var posts: [Post] = [Post()]
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(loadData),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socialFeedTableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData(page: 1)
    }

    @objc private func loadData(page: Int = 1) {
        DataRequest.loadData(page: page, completion: { posts in
            self.posts = posts
            self.socialFeedTableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
}

extension SocialFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellIdentifier) as? PostTableViewCell else {
            return PostTableViewCell()
        }
        let post = posts[indexPath.row]
        cell.configure(post)
        return cell
    }
    
}

extension SocialFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let post = posts[indexPath.row]
        guard let postLink = post.link,
            let postUrl = URL(string: postLink) else {
            return
        }
        
        let safariViewController = SFSafariViewController(url: postUrl)
        present(safariViewController, animated: true, completion: nil)
    }
}

