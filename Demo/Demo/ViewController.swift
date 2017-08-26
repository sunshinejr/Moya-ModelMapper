//
//  ViewController.swift
//  Demo
//
//  Created by Lukasz Mroz on 08.02.2016.
//  Copyright © 2016 Sunshinejr. All rights reserved.
//

import Alamofire
import UIKit
import Moya
import Moya_ModelMapper
import Mapper

class ViewController: UIViewController {

    var provider: MoyaProvider<GitHub>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    /// Function to setup Moya Provider & request in the beginning 
    /// of the VC lifecycle. For testing purposes it fires up 
    /// instantly.
    func setup() {
        provider = MoyaProvider<GitHub>()
        
        // Example of mapping array of objects
        provider.request(GitHub.repos("mjacko")) { (result) in
            if case .success(let response) = result {
                do {
                    let repos = try response.map(to: [Repository].self)
                    print(repos)
                } catch let error {
                    print("There was something wrong with the request! Error: \(error)")
                }
            }
        }
        
        // Example of using keyPath
        provider.request(GitHub.repo("moya/moya")) { result in
            if case .success(let response) = result {
                do {
                    let user = try response.map(to: User.self, keyPath: "owner")
                    print(user)
                } catch {
                    print("There was something wrong with the request!")
                }
            }
        }
    }
}

