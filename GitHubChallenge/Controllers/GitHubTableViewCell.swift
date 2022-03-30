//
//  GitHubTableViewCell.swift
//  GitHubChallenge
//
//  Created by Kaique Alves on 02/04/20.
//  Copyright © 2020 Kaique Alves. All rights reserved.
//

import UIKit

class GitHubTableViewCell: UITableViewCell {

    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var totalStarsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //styleSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //I used this method for cell not unset the position's cell
    override func prepareForReuse() {
        super.prepareForReuse()
        authorImageView.image = nil
    }
    
    func prepare(with item: GitHub.Item){
        authorNameLabel.text = item.name
        repositoryNameLabel.text = item.fullName
        totalStarsLabel.text = String(item.totalStars)
        authorImageView.loadImage(from: item.owner.avatarURL)
    }
}

extension UIImageView {
    
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension GitHubTableViewCell {
    func styleSetup() {
        authorImageView?.layer.borderWidth = 0.5
        authorImageView?.layer.borderColor = UIColor.lightGray.cgColor
    }
}
