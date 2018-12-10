//
//  Box.swift
//  GravityTest
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import Foundation

class Box<T : Any> {
    
    typealias Listener = (T) -> Void
    
    var listener : Listener?
    
    var value : T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value : T) {
        self.value = value
    }
    
    func bind(listener : Listener?){
        self.listener = listener
    }
    
    func bindAndFire(listener : Listener?){
        self.listener = listener
        listener?(value)
    }
    
}
