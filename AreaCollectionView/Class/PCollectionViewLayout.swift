//
//  PCollectionViewLayout.swift
//  AreaCollectionView
//
//  Created by os on 2019/11/11.
//  Copyright © 2019 os. All rights reserved.
//

import UIKit

let HCellNumberOfOneRow = 3
let HCellRow = 4
let HScreenW = 279

class PCollectionViewLayout: UICollectionViewFlowLayout {
    // 保存所有item
    fileprivate var attributesArr: [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        super.prepare()
        //设置itemSize
        itemSize = CGSize(width: 72, height: 32)
        minimumLineSpacing = 12
        minimumInteritemSpacing = 12
        scrollDirection = .horizontal
        
        // 设置collectionView属性
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = true
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        var page = 0
        let itemsCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        for itemIndex in 0..<itemsCount {
            let indexPath = IndexPath(item: itemIndex, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            page = itemIndex / (HCellNumberOfOneRow * HCellRow)
            // 通过一系列计算, 得到x, y值
            let x = 20 + (12 + itemSize.width) * CGFloat(itemIndex % Int(HCellNumberOfOneRow)) + (CGFloat(page) * CGFloat(HScreenW))
            let h = CGFloat((itemIndex - page * HCellRow * HCellNumberOfOneRow) / HCellNumberOfOneRow)
            let y = 20 + (itemSize.height + 12) * h
            
            attributes.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
            // 把每一个新的属性保存起来
            attributesArr.append(attributes)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var rectAttributes: [UICollectionViewLayoutAttributes] = []
        _ = attributesArr.map({
            if rect.contains($0.frame) {
                rectAttributes.append($0)
            }
        })
        return rectAttributes
    }
    
    override var collectionViewContentSize: CGSize {
        let size: CGSize = super.collectionViewContentSize
        let collectionViewWidth: CGFloat = self.collectionView!.frame.size.width
        let nbOfScreen: Int = Int(ceil(size.width / collectionViewWidth))
        let newSize: CGSize = CGSize(width: collectionViewWidth * CGFloat(nbOfScreen), height: size.height)
        return newSize
    }
}
