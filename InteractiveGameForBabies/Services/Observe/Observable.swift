//
//  Observable.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import UIKit

public class Observable<Type> {
    
     class Callback {
        
         weak var observer: AnyObject?
         let options: [ObservableOptions]
         let closure: (Type, ObservableOptions) -> Void
        
         init (observer: AnyObject,
                          options: [ObservableOptions],
                          closure: @escaping (Type, ObservableOptions) -> Void) {
            
            self.observer = observer
            self.options = options
            self.closure = closure
        }
    }
    
    public var value: Type {
        didSet {
            removeNilObserverCallbacks()
            notifyCallbacks(value: oldValue, option: .old)
            notifyCallbacks(value: value, option: .new)
        }
    }
    
    public init(_ value: Type) {
        self.value = value
    }
    
    private var callbacks: [Callback] = []
    
    
    public func addObserver(_ observer: AnyObject,
                            removeIfExists: Bool = true,
                            options: [ObservableOptions] = [.new],
                            closure: @escaping (Type, ObservableOptions) -> Void) {
        if removeIfExists {
            removeObserver(observer)
        }
        
        let callback = Callback(observer: observer, options: options, closure: closure)
        callbacks.append(callback)
        
        if options.contains(.initial) {
            closure(value, .initial)
        }
    }
    
    public func removeObserver(_ observer: AnyObject) {
        callbacks = callbacks.filter { $0.observer !== observer }
    }
    
    private func removeNilObserverCallbacks() {
        callbacks = callbacks.filter { $0.observer != nil }
    }
    
    private func notifyCallbacks(value: Type,
                                 option: ObservableOptions) {
        let callbacksToNotify = callbacks.filter { $0.options.contains(option)}
        
        callbacksToNotify.forEach {
            $0.closure(value,option)
        }
    }
}
