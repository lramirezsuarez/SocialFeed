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
    @IBOutlet weak private var verifiedCheckmark: UIImageView!
    @IBOutlet weak private var fullNameLabel: UILabel!
    @IBOutlet weak private var networkImageView: UIImageView!
    @IBOutlet weak private var postTextView: UITextView!
    @IBOutlet weak private var postImageView: UIImageView!
    @IBOutlet weak private var postDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ post: Post) {
        profileImageView.downloaded(from: post.author?.pictureLink ?? "placeholder")
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
            let height = attachment.height else {
                postImageView.isHidden = true
                postImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                return
        }
        postImageView.isHidden = false
        postImageView.downloaded(from: attachment.pictureLink ?? "placeholder")
        postImageView.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        postImageView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }
    
}
