//
//  RoratingViewsController.swift
//  SimpleRotatingPoligons
//
//  Created by Yurii Boiko on 5/19/19.
//  Copyright © 2019 yurssoft. All rights reserved.
//

import UIKit

class RoratingViewsController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    
    private let sectionInsets = UIEdgeInsets(top: 0,
                                             left: 0,
                                             bottom: 0,
                                             right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout = createBasicFlowLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func createBasicFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let viewWidth = collectionView.frame.width
        let itemsPerRow: CGFloat = 10
        let widthPerItem = viewWidth/itemsPerRow
        let itemHeight = widthPerItem
        let itemSize = CGSize(width: widthPerItem, height: itemHeight)
        layout.itemSize = itemSize
        layout.sectionInset = sectionInsets
        layout.minimumLineSpacing = sectionInsets.left
        layout.headerReferenceSize = itemSize
        return layout
    }
}

extension RoratingViewsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return flowLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}

extension RoratingViewsController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: RotatingCell.self), for: indexPath) as? RotatingCell {
            cell.setupPolygon()
            cell.delegate = self
            cell.cellIndexPath = indexPath
            return cell
        }
        return UICollectionViewCell()
    }
    
    private func applyRotation(layer: CALayer) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.byValue = Float.pi * 2
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = 1
        rotation.timingFunction = CAMediaTimingFunction(name: .linear)
        layer.add(rotation, forKey: "lineRotation")
    }
    
    private func applyRotation(for indexPath: IndexPath) {
        let cells = collectionView.visibleCells.compactMap({ $0 as? RotatingCell })
        if let cell = cells.first(where: { $0.cellIndexPath == indexPath}) {
            applyRotation(layer: cell.contentView.layer)
        }
    }
}

extension RoratingViewsController: RotatingCellDelegate {
    func didTapRotateButton(layer: CALayer, indexPath: IndexPath) {
        applyRotation(layer: layer)
        let leftIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        applyRotation(for: leftIndexPath)
        let rightIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        applyRotation(for: rightIndexPath)
        let topIndexPath = IndexPath(row: indexPath.row, section: indexPath.section + 1)
        applyRotation(for: topIndexPath)
        let bottomIndexPath = IndexPath(row: indexPath.row, section: indexPath.section - 1)
        applyRotation(for: bottomIndexPath)
    }
}
