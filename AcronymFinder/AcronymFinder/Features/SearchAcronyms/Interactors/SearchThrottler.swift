//
//  SearchThrottler.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation

protocol SearchThrottlable {
    func searchTextChanged(_ text: String?, completion: @escaping () -> Void)
}

/*
 This is a class which can be used to Throttle searches if user types very fast.
 One usecase is to send keyword search API calls only if the user is not typing
 for 1 second and not for every character changed. This will prevent bombing the
 API server with too many requests.

 Usage:- Anytime user types on the searchbar, call searchTextChanged() method
*/
                                                            
final class SearchThrottler: SearchThrottlable {
    
    private var completion: (() -> Void)?
    let throttleDuration: TimeInterval
    private var timer: Timer?
    private var currentText: String?
    private var throttledText: String?
    private var isCurrentTextEmpty: Bool {
        return currentText == nil || currentText?.isEmpty == true
    }
    private var isThrottledTextEmpty: Bool {
        return throttledText == nil || throttledText?.isEmpty == true
    }
    
    init(throttleDuration: TimeInterval) {
        self.throttleDuration = throttleDuration
    }
    
    /// Use this function when the user types in a search bar
    func searchTextChanged(_ text: String?, completion: @escaping  () -> Void) {
        self.completion = completion
        self.throttledText = text
        invalidate()
        scheduleTimer()
    }
}

private extension SearchThrottler {
    func scheduleTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: throttleDuration, repeats: false) { [weak self] _ in
            guard let sSelf = self else { return }
            // Making sure the texts are not empty and has also changed from previous captured text
            guard
                (sSelf.currentText != sSelf.throttledText && !sSelf.isCurrentTextEmpty && !sSelf.isThrottledTextEmpty) ||
                ((sSelf.isCurrentTextEmpty && !sSelf.isThrottledTextEmpty) ||
                (!sSelf.isCurrentTextEmpty && sSelf.isThrottledTextEmpty))
            else {
                return
            }
            sSelf.completion?()
            sSelf.currentText = sSelf.throttledText
        }
    }

   func invalidate() {
       timer?.invalidate()
       timer = nil
   }
}
