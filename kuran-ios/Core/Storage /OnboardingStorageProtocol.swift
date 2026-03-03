//
//  OnboardingStorageProtocol.swift
//  kuran-ios
//
//  Created by Asim Seferli on 03.03.26.
//


import Foundation


protocol OnboardingStorageProtocol {
    func hasCompletedOnboarding() -> Bool
    func setOnboardingCompleted()
    func resetOnboarding()
}


final class OnboardingStorage: OnboardingStorageProtocol {
    private let userDefaults = UserDefaults.standard
    private let onboardingKey = "has_completed_onboarding"
    
    func hasCompletedOnboarding() -> Bool {
        return userDefaults.bool(forKey: onboardingKey)
    }
    
    func setOnboardingCompleted() {
        userDefaults.set(true, forKey: onboardingKey)
    }
    
    func resetOnboarding() {
        userDefaults.removeObject(forKey: onboardingKey)
    }
}
