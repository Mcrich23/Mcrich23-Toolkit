//
//  Interstitial Ads.swift
//  
//
//  Created by Morris Richman on 8/20/22.
//

import Foundation
import SwiftUI
import GoogleMobileAds
import Shimmer

public final class Interstitial: NSObject, GADFullScreenContentDelegate {
  static let shared = Interstitial()
    var interstitialID = "" {
        didSet {
            LoadInterstitial(false)
        }
    }
    var interstitial: GADInterstitialAd?
  var sheet: (() -> Void)? // this closure will be executed after dismissing the ad

    override init(adUnitID: String, areAdsDisabled: Bool) {
        super.init()
        LoadInterstitial(getNew: true, adUnitID: adUnitID, areAdsDisabled: areAdsDisabled)
  }

    func LoadInterstitial(_ getNew: Bool, adUnitID: String, areAdsDisabled: Bool) {
        let req = GADRequest()
        if !UserDefaults.standard.bool(forKey: "FASTLANE_SNAPSHOT") && !areAdsDisabled {
            if getNew {
                GADInterstitialAd.load(withAdUnitID: adUnitID, request: req) { ad, error in
                    if error != nil {
                        print("GADInterstitialAd Error: \(String(describing: error))")
                    } else {
                        self.interstitial = ad
                        self.interstitial?.fullScreenContentDelegate = self
                        self.interstitialID = adUnitID
                    }
                }
            } else {
                GADInterstitialAd.load(withAdUnitID: interstitialID, request: req) { ad, error in
                    if error != nil {
                        print("GADInterstitialAd Error: \(String(describing: error))")
                    } else {
                        self.interstitial = ad
                        self.interstitial?.fullScreenContentDelegate = self
                    }
                }
            }
        }
    }

    func showAd(then sheet:(() -> Void)?) {
        if !UserDefaults.standard.bool(forKey: "FASTLANE_SNAPSHOT") {
            // runtime check that we are in snapshot mode
            if self.interstitial != nil {
                guard var topVC = UIApplication.shared.windows.first?.rootViewController else {
                    return
                }
                // iterate til we find the topmost presented view controller
                // if you don't you'll get an error since you can't present 2 vcs from the same level
                while let presentedVC = topVC.presentedViewController {
                    topVC = presentedVC
                }
                self.interstitial!.present(fromRootViewController: topVC)
                self.sheet = sheet
            } else {
                print("Not Ready")
                sheet!()
            }
        } else {
            sheet!()
        }
  }
    /// Tells the delegate that the ad failed to present full screen content.
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
        LoadInterstitial(false)
        if let presentSheet = sheet {
            presentSheet()
        }
    }
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        LoadInterstitial(false)
        if let presentSheet = sheet {
            presentSheet()
        }
    }
}
