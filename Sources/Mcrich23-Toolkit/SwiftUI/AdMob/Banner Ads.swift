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
    
    public init(adUnitID: String, areAdsDisabled: Bool) {
        self.adUnitID = adUnitID
        self.areAdsDisabled = areAdsDisabled
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(bannerViewController: self)
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        let viewController = UIViewController()
        banner.delegate = context.coordinator
        banner.adUnitID = adUnitID
        banner.rootViewController = viewController
        banner.load(GADRequest())
        
        if !UserDefaults.standard.bool(forKey: "FASTLANE_SNAPSHOT") && !areAdsDisabled {
            viewController.view.addSubview(banner)
            viewController.view.backgroundColor = .clear
            viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)
        }
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    public class Coordinator: NSObject, GADBannerViewDelegate {
        
        var bannerViewController: BannerViewController
        
        init(bannerViewController: BannerViewController) {
            self.bannerViewController = bannerViewController
        }
        public func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            print("banner failed to show! Error: \(String(describing: error))")
        }
        public func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            
        }
    }
}

public struct BannerAds: View {
    @State var adUnitID: String
    @State var areAdsDisabled: Bool
    public init(adUnitID: String, areAdsDisabled: Bool) {
        self.adUnitID = adUnitID
        self.areAdsDisabled = areAdsDisabled
    }
    public var body: some View {
        if !UserDefaults.standard.bool(forKey: "FASTLANE_SNAPSHOT") && !areAdsDisabled {
            ZStack {
                Rectangle()
                    .background(.white)
                    .shimmering(active: true, duration: 0.75, bounce: false)
                    .frame(width: 320, height: 50)
                BannerViewController(adUnitID: adUnitID, areAdsDisabled: areAdsDisabled)
                    .frame(width: 320, height: 50)
            }
        }
    }
}
