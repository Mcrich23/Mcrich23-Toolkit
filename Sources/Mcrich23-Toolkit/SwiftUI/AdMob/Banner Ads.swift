//
//  Banner Ads.swift
//  
//
//  Created by Morris Richman on 8/20/22.
//

import Foundation
import SwiftUI
import GoogleMobileAds
import Shimmer

public final class BannerViewController: UIViewControllerRepresentable {
    
    var adUnitID: String = ""
    var areAdsDisabled: Bool = false
    
    override init(adUnitID: String, areAdsDisabled: Bool) {
        super.init()
        self.adUnitID = adUnitID
        self.areAdsDisabled = areAdsDisabled
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(bannerViewController: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        let viewController = UIViewController()
        banner.delegate = context.coordinator
        banner.adUnitID = adUnitID
        banner.rootViewController = viewController
        banner.load(GADRequest())
        
        if !Utilities.isFastlaneRunning && !areAdsDisabled {
            viewController.view.addSubview(banner)
            viewController.view.backgroundColor = .clear
            viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)
        }
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    class Coordinator: NSObject, GADBannerViewDelegate {
        
        var bannerViewController: BannerViewController
        
        init(bannerViewController: BannerViewController) {
            self.bannerViewController = bannerViewController
        }
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            print("banner failed to show! Error: \(String(describing: error))")
        }
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            
        }
    }
}

public struct BannerAds: View {
    @State var adUnitID: String
    public var body: some View {
        if !Utilities.isFastlaneRunning || Utilities.areAdsDisabled {
            ZStack {
                Rectangle()
                    .background(.white)
                    .shimmering(active: true, duration: 0.75, bounce: false)
                    .frame(width: 320, height: 50)
                BannerViewController(adUnitID: adUnitID)
                    .frame(width: 320, height: 50)
            }
        }
    }
}
