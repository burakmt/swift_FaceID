//
//  ViewController.swift
//  FaceRecognitionApp
//
//  Created by Bera on 22.11.2019.
//  Copyright © 2019 Bera. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        let authContext = LAContext()
        var err: NSError?
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &err){
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { (success, error) in
                if success {
                    //Bu şekilde yapıldığı takdirde segue olayını veya herhangi bir olayı arka planda çalıştırmaya çalıştığından program hata veriyor. Bu değişiklikleri başka bir thread içerisinde yapmak gerekiyor.
                    //------>> self.performSegue(withIdentifier: "singInVC", sender: nil)
                    
                    //Uyguladığımız fonksiyonu DisPatchQueue sınıfını kullanarak istediğimiz yerde async şekilde çalışıtırabiliyoruz.
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "signInVC", sender: nil)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error : \(String(describing: error))"
                    }
                    
                }
            }
        }
    }
    
}

