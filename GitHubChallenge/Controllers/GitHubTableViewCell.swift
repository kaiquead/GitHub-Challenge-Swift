//
//  GitHubTableViewCell.swift
//  GitHubChallenge
//
//  Created by Kaique Alves on 02/04/20.
//  Copyright © 2020 Kaique Alves. All rights reserved.
//

import UIKit

class GitHubTableViewCell: UITableViewCell {

    @IBOutlet weak var ivAutor: UIImageView!
    @IBOutlet weak var lbAutorName: UILabel!
    @IBOutlet weak var lbRepositoryName: UILabel!
    @IBOutlet weak var lbStarsQtd: UILabel!
    //var imagePath: String = ""
    
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
        ivAutor.image = nil
    }
    
    func prepare(with git: Github.Item){
        guard let imagePath = git.owner?.avatar_url else {return}
        lbAutorName.text = "\(git.name!)"
        lbRepositoryName.text = "\(git.full_name!)"
        lbStarsQtd.text = "\(git.stargazers_count!)"
        if let imageUrl = URL(string: imagePath){
            ivAutor.loadImge(url: imageUrl)
        } else {
            ivAutor.image = UIImage(named: "globe.png")
        }
    }
}

extension UIImageView {
    func loadImge(url: URL) {
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
        ivAutor.layer.borderWidth = 0.5
        ivAutor.layer.borderColor = UIColor.lightGray.cgColor
    }
}
