//
//  ListItemCell.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 10/08/2022.
//

import UIKit
import Nuke
import SkeletonView

class ListItemCell: UITableViewCell {

    static let cellId = "ListItemCell"

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemSubTitleLabel: UILabel!
    @IBOutlet weak var itemDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        roundCorners(to: 4)
        makeViewsSkeletonable()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with vm: ItemViewModel?) {
        if let vm = vm {
            itemTitleLabel.text = vm.title
            itemSubTitleLabel.text = vm.subtitle
            itemDateLabel.text = vm.dateForDisplay
            loadImage(with: vm.imageUrl)
        } else {
            itemTitleLabel.text = nil
            itemSubTitleLabel.text = nil
            itemImageView.image = UIImage(assetIdentifier: .placeholder)
        }
    }

    private func loadImage(with url: URL) {
        let options = ImageLoadingOptions(
            placeholder: UIImage(assetIdentifier: .placeholder),
            transition: .fadeIn(duration: 0.33)
        )
        Nuke.loadImage(with: url, options: options, into: self.itemImageView)
    }
}

extension ListItemCell {
    private func roundCorners(to radius: CGFloat) {
        self.itemImageView.layer.cornerRadius = radius
        self.itemImageView.clipsToBounds = true
    }

    private func makeViewsSkeletonable() {
        itemImageView.isSkeletonable = true
        itemTitleLabel.isSkeletonable = true
        itemSubTitleLabel.isSkeletonable = true
        itemDateLabel.isSkeletonable = true
    }

    func showLoadingAnimation() {
        itemTitleLabel.numberOfLines = 2
        itemSubTitleLabel.numberOfLines = 1
        itemImageView.showAnimatedSkeleton()
        itemTitleLabel.showAnimatedSkeleton()
        itemSubTitleLabel.showAnimatedSkeleton()
        itemDateLabel.showAnimatedSkeleton()
    }

    func hideLoadingAnimation() {
        itemTitleLabel.numberOfLines = 2
        itemSubTitleLabel.numberOfLines = 3
        itemImageView.hideSkeleton()
        itemTitleLabel.hideSkeleton()
        itemSubTitleLabel.hideSkeleton()
        itemDateLabel.hideSkeleton()
    }
}
