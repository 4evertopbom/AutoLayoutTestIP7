//
//  ViewController.swift
//  audiable
//
//  Created by Hoang Anh Tuan on 4/25/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import UIKit

protocol LoginControllerDelegate: class {
    func didLoggedIn()
}

class LoginController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, LoginControllerDelegate {

    let cellID = "cellId"
    let registerCellID = "registerCellID"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 4
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        return pc
    }()
    
    let nextButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        bt.setTitle("Next", for: .normal)
        bt.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        bt.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        return bt
    }()
    
    @objc func handleNextPage() {
        
       let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        pageControl.currentPage = indexPath.item
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        if pageControl.currentPage == pages.count {
            moveControlButtons()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)

        }
    }
    
    lazy var skipButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Skip", for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        bt.addTarget(self, action: #selector(handleSkipPage), for: .touchUpInside)
        bt.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        return bt
    }()
    
    @objc func handleSkipPage() {
        pageControl.currentPage = pages.count - 1
        handleNextPage()
    }
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDismiss), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        
        pageControl.anchor(top: nil, paddingtop: 0, left: view.leftAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 30, width: 0)
        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        pageControlBottomAnchor?.isActive = true
        
        nextButton.anchor(top: nil, paddingtop: 0, left: view.safeAreaLayoutGuide.leftAnchor, paddingleft: 12, right: nil, paddingright: 0, bot: nil, botpadding: 0, height: 30, width: 50)
        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        nextButtonTopAnchor?.isActive = true
        
        skipButton.anchor(top: nil, paddingtop: 0, left: nil, paddingleft: 0, right: view.safeAreaLayoutGuide.rightAnchor, paddingright: -12, bot: nil, botpadding: 0, height: 30, width: 60)
        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        skipButtonTopAnchor?.isActive = true
    }
    
    @objc func handleKeyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let temp: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
            self.view.frame = CGRect(x: 0, y: temp, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    @objc func handleKeyboardDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    fileprivate func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, paddingtop: 0, left: view.leftAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: view.bottomAnchor, botpadding: 0, height: 0, width: 0)
        collectionView.register(pageCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(loginCell.self, forCellWithReuseIdentifier: registerCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = currentPage
        if currentPage == pages.count {
            moveControlButtons()
        } else {
            pageControlBottomAnchor?.constant = -10
            nextButtonTopAnchor?.constant = 20
            skipButtonTopAnchor?.constant = 20
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func moveControlButtons() {
        pageControlBottomAnchor?.constant = 30
        nextButtonTopAnchor?.constant = -90
        skipButtonTopAnchor?.constant = -90
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    var pages: [Page] = {
        let page1 = Page(title: "Share a great listen", message: "It's free to send your books to the people in your. Every recipient 's first book is on us", imageName: "page1")
        let page2 = Page(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this Book\"", imageName: "page2")
        let page3 = Page(title: "Send from the player", message: "Tap the More menu in the upper corner. Choose \"Send this Book\"", imageName: "page3")
        return [page1, page2, page3]
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == pages.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: registerCellID, for: indexPath) as! loginCell
            cell.delegate = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! pageCell
        cell.page = pages[indexPath.item]
        return cell
    }
    
    func didLoggedIn() {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        guard let mainController = rootVC as? MainController else { return }
        
        mainController.viewControllers = [HomeController()]
        UserDefaults.standard.changeLoggedIn(value: true)
        self.dismiss(animated: true, completion: nil)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
         collectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
}

