//
//  mapScrollView.swift
//  SeoulTraffic
//
//  Created by 강 성민 on 2017. 7. 8..
//  Copyright © 2017년 AppSpace All rights reserved.
//

import UIKit

class MapScrollView: UIScrollView {
    weak var mapImageView: UIImageView?
    weak var roadImageView: UIImageView?
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        let roadImageView = UIImageView()
        addSubview(roadImageView)
        self.roadImageView = roadImageView
        
        let mapImageView = UIImageView()
        addSubview(mapImageView)
        self.mapImageView = mapImageView
        
        mapImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        roadImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(mapImageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func remakeMapConstraints() {
        guard let mapImageView = mapImageView else {
            return
        }
        guard let mapSize = mapImageView.image?.size else {
            return
        }
        let scale = mapSize.width / mapSize.height
        
        mapImageView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(mapImageView.snp.height).multipliedBy(scale)
        }
    }
}
