//
//  viewCell.swift
//  audiable
//
//  Created by Hoang Anh Tuan on 4/25/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

class pageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            DispatchQueue.main.async {
                self.imageview.image = UIImage(named: unwrappedPage.imageName)
            }
            setupTextview(with: unwrappedPage)
        }
    }
    
    fileprivate func setupTextview(with page: Page) {
        let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
        attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(white: 0.2, alpha: 1)]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let length = attributedText.string.characters.count
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
        
        DispatchQueue.main.async {
            self.statusTextview.attributedText = attributedText
        }
    }
    
    let imageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "page1")
        iv.clipsToBounds = true
        return iv
    }()
    
    let statusTextview: UITextView = {
        let tv = UITextView()
        tv.text = "Some text"
        tv.textContainerInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.6, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageview)
        addSubview(statusTextview)
        addSubview(separateLine)
        
        statusTextview.anchor(top: nil, paddingtop: 0, left: leftAnchor, paddingleft: 15, right: rightAnchor, paddingright: -15, bot: safeAreaLayoutGuide.bottomAnchor, botpadding: 0, height: frame.height * 0.3, width: 0)
        imageview.anchor(top: topAnchor, paddingtop: 0, left: leftAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: statusTextview.topAnchor, botpadding: 0, height: 0, width: 0)
        separateLine.anchor(top: imageview.bottomAnchor, paddingtop: 0, left: leftAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 1, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
