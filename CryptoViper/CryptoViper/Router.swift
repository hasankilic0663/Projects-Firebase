//
//  Router.swift
//  CryptoViper
//
//  Created by Hasan Hüseyin Kılıç on 23.10.2024.
//

import Foundation



//Class , Protocol
//EntryPoint


protocol AnyRouter {
    static func startExecution() -> AnyRouter
}

class CryptoRouter: AnyRouter {
    static func startExecution() -> any AnyRouter {
        let router = CryptoRouter()
        
        
        
        return router
    }
    
    
}





