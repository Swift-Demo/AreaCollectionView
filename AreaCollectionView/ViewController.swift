//
//  ViewController.swift
//  AreaCollectionView
//
//  Created by os on 2019/11/11.
//  Copyright © 2019 os. All rights reserved.
//

import UIKit

let PCellNumberOfOnePage = 12

class ViewController: UIViewController {

    var selectedArea:String = ""
    var collectionView : UICollectionView?
    var dataArr = ["全部","北京","上海","广东","广西","湖北","湖南","重庆","四川","江苏","河南","河北","北京","上海","广东","广西","湖北","湖南","重庆","四川","江苏","河南","河北"]
    
    lazy var pageControl: UIPageControl = { [unowned self] in
        let pageC = UIPageControl(frame: CGRect(x:self.view.frame.size.width/2 - 279/2, y: 321 - 20, width:279, height: 10))
        pageC.numberOfPages = dataArr.count / PCellNumberOfOnePage + (dataArr.count % PCellNumberOfOnePage == 0 ? 0 : 1)
        pageC.currentPage = 0
        pageC.pageIndicatorTintColor = UIColor.lightGray
        pageC.currentPageIndicatorTintColor = UIColor.gray
        return pageC
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = PCollectionViewLayout()
        collectionView = UICollectionView(frame: CGRect(x:self.view.frame.size.width/2 - 279/2, y:100, width:279, height:221), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor(red: 63/255.0, green: 62/255.0, blue: 112/255.0, alpha: 1.0)
        collectionView!.isPagingEnabled = true
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
        self.view.addSubview(collectionView!)
        self.view.addSubview(pageControl)
        collectionView?.register(AreaCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }


}

extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate,UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AreaCollectionViewCell
        cell.label.text = dataArr[indexPath.row]
        cell.selectedBackgroundView = UIView(frame: cell.frame)
        cell.selectedBackgroundView?.layer.cornerRadius = 2
        cell.selectedBackgroundView?.backgroundColor = UIColor(red: 59/255.0, green: 129/255.0, blue: 241/255.0, alpha: 1.0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath:",indexPath.row,dataArr[indexPath.row])
        self.selectedArea = dataArr[indexPath.row]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.x
        let page = contentOffset / scrollView.frame.size.width + (Int(contentOffset) % Int(scrollView.frame.size.width) == 0 ? 0 : 1)
        pageControl.currentPage = Int(page)
    }
}

