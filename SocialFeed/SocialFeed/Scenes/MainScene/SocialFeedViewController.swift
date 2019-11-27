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
    
    private var posts: [Post] = []
    private var currentPage = 1
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(refreshData),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socialFeedTableView.refreshControl = refreshControl
        socialFeedTableView.rowHeight = UITableView.automaticDimension
        socialFeedTableView.estimatedRowHeight = 400
        loadData()
    }

    @objc private func refreshData() {
        currentPage = 1
        posts.removeAll()
        loadData()
    }
    
    private func loadData() {
        DataRequest.loadData(page: currentPage, completion: { posts in
            self.posts.append(contentsOf: posts)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellIdentifier) as? PostTableViewCell,
            posts.count >= indexPath.row else {
            return PostTableViewCell()
        }
        let post = posts[indexPath.row]
        cell.configure(post)
        return cell
    }
}

extension SocialFeedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if currentPage == 1 {
            currentPage += 1
            loadData()
        }
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

