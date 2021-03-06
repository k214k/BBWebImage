//
//  MainMenuVC.swift
//  CompareImageLib
//
//  Created by Kaibo Lu on 3/4/19.
//  Copyright © 2019 Kaibo Lu. All rights reserved.
//

import UIKit
import BBWebImage
import SDWebImage
import YYWebImage
import Kingfisher

typealias NoParamterBlock = () -> Void

class MainMenuVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var list: [(String, NoParamterBlock)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testBB = { [weak self] in
            if let self = self { self.navigationController?.pushViewController(ImageWallVC(type: .BBWebImage), animated: true) }
        }
        let testSD = { [weak self] in
            if let self = self { self.navigationController?.pushViewController(ImageWallVC(type: .SDWebImage), animated: true) }
        }
        let testYY = { [weak self] in
            if let self = self { self.navigationController?.pushViewController(ImageWallVC(type: .YYWebImage), animated: true) }
        }
        let testKi = { [weak self] in
            if let self = self { self.navigationController?.pushViewController(ImageWallVC(type: .Kingfisher), animated: true) }
        }
        let testGifBB = { [weak self] in
            if let self = self { self.navigationController?.pushViewController(BBAnimatedImageWallVC(), animated: true) }
        }
        let testGifSD = { [weak self] in
            if let self = self { self.navigationController?.pushViewController(SDAnimatedImageWallVC(), animated: true) }
        }
        let testGifYY = { [weak self] in
            if let self = self { self.navigationController?.pushViewController(YYAnimatedImageWallVC(), animated: true) }
        }
        let testGifKi = { [weak self] in
            if let self = self { self.navigationController?.pushViewController(KiAnimatedImageWallVC(), animated: true) }
        }
        let testCache = { [weak self] in
            if let self = self { self.navigationController?.pushViewController(TestCacheVC(), animated: true) }
        }
        let clear = { [weak self] in
            guard self != nil else { return }
            BBWebImageManager.shared.imageCache.clear(.all, completion: nil)
            
            SDWebImageManager.shared().imageCache?.clearMemory()
            SDWebImageManager.shared().imageCache?.clearDisk(onCompletion: nil)
            
            YYWebImageManager.shared().cache?.memoryCache.removeAllObjects()
            YYWebImageManager.shared().cache?.diskCache.removeAllObjects()
            
            KingfisherManager.shared.cache.clearMemoryCache()
            KingfisherManager.shared.cache.clearDiskCache()
        }
        list = [("BBWebImage image wall", testBB),
                ("SDWebImage image wall", testSD),
                ("YYWebImage image wall", testYY),
                ("Kingfisher image wall", testKi),
                ("BBWebImage GIF wall", testGifBB),
                ("SDWebImage GIF wall", testGifSD),
                ("YYWebImage GIF wall", testGifYY),
                ("Kingfisher GIF wall", testGifKi),
                ("Test cache", testCache),
                ("Clear", clear)]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MainMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.textLabel?.text = list[indexPath.row].0
        return cell
    }
}

extension MainMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        list[indexPath.row].1()
    }
}
