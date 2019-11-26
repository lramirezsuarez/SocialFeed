//
//  UIImageView+Download.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return
            }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard link != "placeholder", let url = URL(string: link) else {
            self.image = UIImage(named: link)
            return
        }
        downloaded(from: url, contentMode: mode)
    }
}
