//
//  PostTableViewCell.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import UIKit
import Kingfisher

final class PostTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: PostTableViewCell.self)

    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var accountNameLabel: UILabel!
    @IBOutlet weak private var verifiedCheckmark: UIImageView!
    @IBOutlet weak private var fullNameLabel: UILabel!
    @IBOutlet weak private var networkImageView: UIImageView!
    @IBOutlet weak private var postTextView: UITextView!
    @IBOutlet weak private var postImageView: UIImageView!
    @IBOutlet weak private var postDateLabel: UILabel!
    @IBOutlet weak private var postImageHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ post: Post) {
        profileImageView.kf.indicatorType = .activity
        profileImageView.kf.setImage(with: URL(string: post.author?.pictureLink ?? ""))
        accountNameLabel.text = post.author?.account ?? "Missing account"
        verifiedCheckmark.isHidden = !(post.author?.isVerified ?? false)
        fullNameLabel.text = post.author?.name ?? "No author name"
        configure(post.network ?? .unknown)
        configureTextLabel(with: post.text)
        configure(post.attachment)
        guard let dateString = post.date,
            let date = DateFormatter.getFormatter(.iso8601).date(from: dateString) else {
                postDateLabel.text = ""
            return
        }
        postDateLabel.text = DateFormatter.getFormatter(.postFormat).string(from: date)
    }
    
    private func configure(_ network: NetworkType) {
        networkImageView.image = UIImage(named: network.rawValue)
    }
    
    private func configureTextLabel(with text: Text?) {
        guard let text = text, let textString = text.plain else {
            return
        }
        let attributedString = NSMutableAttributedString(string: textString)
        text.markup?.forEach({ markup in
            if let location = markup.location, let lenght = markup.length, let link = markup.link {
                attributedString.addAttribute(.link, value: link, range: NSRange(location: location, length: lenght))
            }
        })
        postTextView.attributedText = attributedString
        
    }
    
    private func configure(_ attachment: Attachment?) {
        guard let attachment = attachment,
            let width = attachment.width,
            let height = attachment.height,
            let link = attachment.pictureLink,
            let url = URL(string: link) else {
                postImageView.isHidden = true
                postImageHeightConstraint.constant = 0
                return
        }
        let ratio = Double(width / height)
        let newHeight = postImageView.frame.width / CGFloat(ratio > 0 ? ratio : 1.5)
        postImageHeightConstraint.constant = newHeight > 200 ? 200 : newHeight
        
        postImageView.isHidden = false
        postImageView.kf.indicatorType = .activity
        postImageView.kf.setImage(with: url)
        postImageView.layoutIfNeeded()
        
    }
    
}
