//
//  PageCell.swift
//  Audible
//
//  Created by Genius on 17/4/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

import UIKit
import SnapKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            
            guard let page = page else {
                return
            }
            
            var imageName = page.imageName
            
            if UIDevice.current.orientation.isLandscape {
                imageName += "_landscape"
            }
            
            imageView.image = UIImage(named: imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page.title,
                                                        attributes: [
                                                                    NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium),
                                                                    NSForegroundColorAttributeName: color
                                                                    ])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)",
                                                attributes: [
                                                    NSFontAttributeName: UIFont.systemFont(ofSize: 14),
                                                    NSForegroundColorAttributeName: color
                                                ]
            ))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.characters.count
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            
            textView.attributedText = attributedText
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .yellow
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "page1")
        iv.clipsToBounds = true
        return iv
    }()
    
    let blackSeperatorView: UIView = {
        let bsv = UIView()
        bsv.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
        return bsv
    }()

    
    let textView: UITextView = {
        let tx = UITextView()
        tx.text = "Sample Text for now"
        tx.isEditable = false
        tx.contentInset = UIEdgeInsetsMake(24, 0, 0, 0)
        return tx
    }()
    
    
    func setupViews() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(textView)
        contentView.addSubview(blackSeperatorView)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(textView.snp.top)
        }
        
        textView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(16)
            make.bottom.equalToSuperview()
            make.right.equalTo(contentView.snp.right).offset(-16)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.3)
        }
        
        blackSeperatorView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(textView.snp.top)
            make.height.equalTo(1)
        }
    }
    
    
}













