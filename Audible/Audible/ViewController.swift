//
//  ViewController.swift
//  Audible
//
//  Created by Genius on 17/4/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - lazy
    lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0;
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    let cellId = "cellId"
    let loginCellId = "loginCellId"
    
    
    let pages: [Page] = {
        
        let firstPage = Page(title: "Share a great listen", message: "It's free to send your books to the people in your life, every recipient's first book is on us", imageName: "page1")
        
        let secondPage = Page(title: "Share a great listen", message: "It's free to send your books to the people in your life, every recipient's first book is on us", imageName: "page2")
        
        let thirdPage = Page(title: "Share a great listen", message: "It's free to send your books to the people in your life, every recipient's first book is on us", imageName: "page3")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()
    
    
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - system func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observerKeyboardNotifications()
        addTapGesture()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        collectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        registerCells()
        
        pageControl.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        skipButton.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(0);
            make.size.equalTo(CGSize(width: 60, height: 50))
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.right.equalTo(0)
            make.size.equalTo(CGSize(width: 60, height: 50))
        }
    }
    

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - private func
    fileprivate func registerCells() {
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
        
    }
    
    fileprivate func addTapGesture() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
        
    }
    
    fileprivate func observerKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardShow() {
    
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let y:CGFloat = UIDevice.current.orientation.isLandscape ? -150 : -50;
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self
            .view.frame.height)
            
        }, completion: nil)
    }
    
    func keyboardHide() -> Void {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    
    func tapAction() -> Void {
        view.endEditing(true)
    }
    
    
    func nextPage() {
        
        if pageControl.currentPage == pages.count {
            return
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        
        if indexPath.item == pages.count {
            moveControlConstraintsScreenAnimation(pageOffset: 40, topButtonOffset: -40)
        }
        
        pageControl.currentPage = indexPath.item
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func skip() -> Void {
        
        pageControl.currentPage = pages.count - 1
        nextPage()
        
    }
    
    
    // MARK: - UICollectionViewDelegate/DataSource/FlowLayout
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath)
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.bounds.size
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // page control
        let pageNum = Int(targetContentOffset.pointee.x / view.bounds.size.width)
        pageControl.currentPage = pageNum
        
        if pageNum == pages.count {
            
            moveControlConstraintsScreenAnimation(pageOffset: 40, topButtonOffset: -40)
            
        }else {
            
            moveControlConstraintsScreenAnimation(pageOffset: 0.0, topButtonOffset: 16)
            
        }
        
    }
    
    
    fileprivate func moveControlConstraintsScreenAnimation(pageOffset: CGFloat, topButtonOffset: CGFloat) -> Void {
        
        // animation
        pageControl.snp.updateConstraints({ (make) in
            make.bottom.equalTo(pageOffset)
        })
        
        skipButton.snp.updateConstraints { (make) in
            make.top.equalTo(topButtonOffset)
        }
        
        nextButton.snp.updateConstraints { (make) in
            make.top.equalTo(topButtonOffset)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)

    }

    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        UIDevice.current.orientation.isLandscape
        
        collectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
        
        
    }
    

}
















