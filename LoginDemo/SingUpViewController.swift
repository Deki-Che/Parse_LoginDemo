//
//  SingUpViewController.swift
//  LoginDemo
//
//  Created by Deki on 15/11/13.
//  Copyright © 2015年 Deki. All rights reserved.
//

import UIKit

class SingUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var profilePhotosImageView: UIImageView!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userPassword2TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTap(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func selectProfilePhotosButton(sender: UIButton) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //  选择照片完成以后就会调用该方法
        profilePhotosImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(sender: UIButton) {
        let userName = userEmailTextField.text
        let userPass = userPasswordTextField.text
        let userPassRepeat = userPassword2TextField.text
        let userFirstName = userFirstNameTextField.text
        let userLastName = userLastNameTextField.text
        
        if (userName!.isEmpty || userPass!.isEmpty || userPassRepeat!.isEmpty || userFirstName!.isEmpty || userLastName!.isEmpty )  {
            let myAlert = UIAlertController(title: "警告", message: "请填写完整信息", preferredStyle: .Alert )
            let okAction = UIAlertAction(title: "好的", style: .Default, handler: nil)
            myAlert.addAction(okAction)
            presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        if userPass != userPassRepeat {
            let myAlert = UIAlertController(title: "警告", message: "两次输入的密码不同", preferredStyle: .Alert )
            let okAction = UIAlertAction(title: "好的", style: .Default, handler: nil)
            myAlert.addAction(okAction)
            presentViewController(myAlert, animated: true, completion: nil)
            
            return

        }
        
        let myUser = PFUser()
        myUser.username = userName
        myUser.password = userPass
        myUser.email = userName
        myUser.setObject(userFirstName!, forKey: "user_firstname")
        myUser.setObject(userLastName!, forKey: "user_lastname")
        
        let profileImageData = UIImageJPEGRepresentation((profilePhotosImageView.image)!, 1)
        if profileImageData != nil {
            let profileImageFile = PFFile(data: profileImageData!)
            myUser.setObject(profileImageFile!, forKey: "profile_picture")
        }
        
        myUser.signUpInBackgroundWithBlock { (succsess:Bool, error:NSError?) -> Void in
            var userMessage = "注册成功"
            
            if !succsess {
                userMessage = error!.localizedDescription
            }
            
            let myAlert = UIAlertController(title: "提示", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            let myAlertAction = UIAlertAction(title: "好的", style: .Default, handler: { _ in
                if succsess {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
            
            myAlert.addAction(myAlertAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
