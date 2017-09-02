//
//  MapViewController.swift
//  SeoulTraffic
//
//  Created by 강 성민 on 2017. 7. 7..
//  Copyright © 2017년 AppSpace All rights reserved.
//

import UIKit
import SnapKit

class MapViewController: UIViewController {
    weak var mapView: MapScrollView?
    weak var infoButton: UIButton?
    weak var refreshButton: UIButton?
    
    var mapDetails: MapDetails = MapDetails(mapUri: "", roadUri: "")
    var initialLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        refreshMapImage()
        refreshRoadImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (initialLoad) {
            scrollToMid(scrollView: mapView)
            initialLoad = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Public Methods
    internal func refreshMapImage() {
        guard let mapUrl = URL(string: mapDetails.mapUrl()) else {
            return
        }
        guard let mapData = try? Data(contentsOf: mapUrl) else {
            return
        }
        
        mapView?.mapImageView?.image = UIImage(data: mapData)
        mapView?.remakeMapConstraints()
    }
    
    internal func refreshRoadImage() {
        guard let roadUrl = URL(string: mapDetails.roadUrl()) else {
            return
        }
        guard let roadData = try? Data(contentsOf: roadUrl) else {
            return
        }
        
        mapView?.roadImageView?.image = UIImage(data: roadData)
    }
    
    // MARK: - Action Methods
    @objc private func refreshButtonTouched(_ sender: UIButton?) {
        refreshRoadImage()
    }
    
    @objc private func infoButtonTouched(_ sender: UIButton?) {
        
    }
    
    // MARK: - View Methods
    private func setupViews() {
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        let mapView = MapScrollView()
        view.addSubview(mapView)
        self.mapView = mapView
        
        let refreshButton = UIButton()
        refreshButton.layer.cornerRadius = 4
        refreshButton.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        refreshButton.setImage(UIImage(named: "icRefresh"), for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshButtonTouched(_:)), for: .touchUpInside)
        view.addSubview(refreshButton)
        self.refreshButton = refreshButton
        
        let infoButton = UIButton()
        infoButton.layer.cornerRadius = 4
        infoButton.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        infoButton.setImage(UIImage(named: "icInfo"), for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTouched(_:)), for: .touchUpInside)
        //view.addSubview(infoButton)
        self.refreshButton = infoButton
        
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let statusHeight = UIApplication.shared.statusBarFrame.height
        let margin = 10.0
        refreshButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(statusHeight + CGFloat(margin))
            make.right.equalToSuperview().inset(margin)
        }
        
        //infoButton.snp.makeConstraints { (make) in
        //    make.bottom.equalToSuperview().inset(margin)
        //    make.right.equalToSuperview().inset(margin)
        //}
    }
    
    // MARK: Private Methods
    private func scrollToMid(scrollView: UIScrollView?) {
        guard let scrollView = scrollView else {
            return
        }
        
        scrollView.contentOffset = CGPoint(x: scrollView.contentSize.width/2 - scrollView.frame.width/2, y: scrollView.contentOffset.y)
    }
}
