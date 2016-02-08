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
        provider = MoyaProvider<GitHub>(
            endpointClosure: MoyaProvider.DefaultEndpointMapping,
            requestClosure: MoyaProvider.DefaultRequestMapping,
            stubClosure: MoyaProvider.NeverStub,
            manager: Alamofire.Manager.sharedInstance,
            plugins: []
        )
        
        provider.request(GitHub.Repos("mjacko")) { (result) in
            if case .Success(let response) = result {
                do {
                    let repos = try response.mapArray() as [Repository]
                    print(repos)
                } catch {
                    print("There was something wrong with the request!")
                }
            }
        }
    }

}

