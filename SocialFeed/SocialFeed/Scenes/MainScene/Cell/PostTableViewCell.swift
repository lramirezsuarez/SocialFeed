//
//  PostTableViewCell.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: PostTableViewCell.self)

    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var accountNameLabel: UILabel!
    @IBOutlet weak private var fullNameLabel: UILabel!
    @IBOutlet weak private var networkImageView: UIImageView!
    @IBOutlet weak private var postTextLabel: UILabel!
    @IBOutlet weak private var postImageView: UIImageView!
    @IBOutlet weak private var postDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ post: Post) {
        guard let pictureLink = post.author?.pictureLink,
            let accountName = post.author?.account,
            let authorName = post.author?.name, let network = post.network else {
            return
        }
        profileImageView.downloaded(from: pictureLink)
        accountNameLabel.text = accountName
        fullNameLabel.text = authorName
        configure(network)
        configureTextLabel(with: post.text)
        configure(post.attachment)
        if #available(iOS 11.0, *) {
            postDateLabel.text = post.date?.iso8601?.description(with: .current)
        } else {
            postDateLabel.text = post.date
        }
    }
    
    private func configure(_ network: NetworkType) {
        networkImageView.image = UIImage(named: network.rawValue)
    }
    
    private func configureTextLabel(with text: Text?) {
        guard let text = text else {
            return
        }
        
        postTextLabel.text = text.plain
        
    }
    
    private func configure(_ attachment: Attachment?) {
        guard let attachment = attachment,
            let width = attachment.width,
            let height = attachment.height else {
                postImageView.isHidden = true
                postImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                return
        }
        
        postImageView.downloaded(from: attachment.pictureLink ?? "placeholder")
        postImageView.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        postImageView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }
    
}
