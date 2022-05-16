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
 
 - parameter steps: The label [Text].
 - parameter indicationTypes: The indicating type.
 - parameter lineOptions: All the options for a StepperView.
 - returns: View in format of a StepperView for OnboardingView
 
 See [badrinathvm/StepperView](https://github.com/badrinathvm/StepperView) for more info on the Steps function.
 
 # Example #
 ```
 let steps = [ Text(NSLocalizedString("welcome title 1", comment: "")).font(.body),
               Text(NSLocalizedString("welcome title 2", comment: "")).font(.body),
               Text(NSLocalizedString("welcome title 3", comment: "")).font(.body),
               Text(NSLocalizedString("welcome title 4", comment: "")).font(.body)]

 let indicationTypes = [
     StepperIndicationType
         .custom(CircledIconView(image: Image(systemName: "plus"), width: 50)),
         .custom(CircledIconView(image: Image(systemName: "hand.draw"), width: 50)),
         .custom(CircledIconView(image: Image(systemName: "hand.tap"), width: 50)),
         .custom(CircledIconView(image: Image(systemName: "eye"), width: 50))
 ]
 
 
 StepperViewOnboarding(
    steps: steps,
    indicationTypews: indicationTypes,
    lineOptions: .custom(1, Colors.blue(.teal).rawValue)
 )
 ```
 
 */

public struct StepperViewOnboarding<Content: View>: View {
    @State var steps: [Text]
    @State var indicationTypes: [StepperIndicationType<Content>]
    @State var indicationTypesCIV: [StepperIndicationType<CircledIconView>]
    @State var indicationTypesNCV: [StepperIndicationType<NumberedCircleView>]
    @State var lineOptions: StepperLineOptions
    public init(steps: [Text], indicationTypes: [StepperIndicationType<Content>], lineOptions: StepperLineOptions) {
        self.steps = steps
        self.indicationTypes = indicationTypes
        self.indicationTypesCIV = []
        self.indicationTypesNCV = []
        self.lineOptions = lineOptions
    }
    var stepper: some View {
        StepperView()
            .addSteps(steps)
            .stepIndicatorMode(StepperMode.vertical)
            .spacing(30)
            .lineOptions(lineOptions)
    }
    public var body: some View {
        if !indicationTypesCIV.isEmpty {
            stepper
                .indicators(indicationTypesCIV)
        } else if !indicationTypesNCV.isEmpty {
            stepper
                .indicators(indicationTypesNCV)
        } else {
            stepper
                .indicators(indicationTypesNCV)
        }
    }
    public init(steps: [Text], indicationTypes: [StepperIndicationType<CircledIconView>], lineOptions: StepperLineOptions) {
        self.steps = steps
        self.indicationTypes = []
        self.indicationTypesCIV = indicationTypes
        self.indicationTypesNCV = []
        self.lineOptions = lineOptions
    }
    public init(steps: [Text], indicationTypes: [StepperIndicationType<NumberedCircleView>], lineOptions: StepperLineOptions) {
        self.steps = steps
        self.indicationTypes = []
        self.indicationTypesCIV = []
        self.indicationTypesNCV = indicationTypes
        self.lineOptions = lineOptions
    }
}
