//
//  StepperViewOnboarding.swift
//  
//
//  Created by Morris Richman on 5/15/22.
//

import Foundation
import SwiftUI
import StepperView

/**
 The StepperView for OnboardingScreen.
 
 - parameter steps: The label, consider using [Text].
 - parameter indicationTypes: The indicating type.
 - parameter lineOptions: All the options for StepperViewOnboarding.
 - returns: View in format of a StepperView
 
 # Example #
 ```
 StepperViewOnboarding(
    steps: steps,
    indicationTypews: indicationTypes,
    lineOptions: .custom(1, Colors.blue(.teal).rawValue)
 )
 ```
 
 */

public struct StepperViewOnboarding<Content: View>: View {
    public var steps: [some View]
    public var indicationTypes: [StepperIndicationType<Content>]
    public var lineOptions: StepperLineOptions
    public init(steps: [Text], indicationTypes: [StepperIndicationType<Content>], lineOptions: StepperLineOptions) {
        self.steps = steps
        self.indicationTypes = indicationTypes
        self.lineOptions = lineOptions
    }
    public var body: some View {
        StepperView()
            .addSteps(steps)
            .indicators(indicationTypes)
            .stepIndicatorMode(StepperMode.vertical)
            .spacing(30)
            .lineOptions(lineOptions)
    }
}
