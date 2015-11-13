

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInButtonTapped(sender: UIButton) {
        let userEmail = userEmailTextField.text
        let userPass = userPasswordTextField.text
        
        if userEmail!.isEmpty || userPass!.isEmpty {
            return
        }
        
        PFUser.logInWithUsernameInBackground(userEmail!, password: userPass!) { (user:PFUser?, error:NSError?) -> Void in
            var userMessage = "登录成功"
            if user != nil {
                
                let userName = user?.username
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let main:MainViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
                let mainNav = UINavigationController(rootViewController: main)
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window?.rootViewController = mainNav
                
            } else {
                userMessage = error!.localizedDescription
                let myAlert = UIAlertController(title: "提示", message: userMessage, preferredStyle: .Alert )
                let okAction = UIAlertAction(title: "好的", style: .Default, handler: nil)
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)

            }
            
        }
                
    }

}

