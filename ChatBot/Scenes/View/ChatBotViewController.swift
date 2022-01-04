//
//  ChatBotViewController.swift
//  ChatBot
//
//  Created by Mahendra Vishwakarma on 03/01/22.
//

import UIKit

class ChatBotViewController: UIViewController {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var bottom_constraight: NSLayoutConstraint!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var attachmentView: UIView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtMessage: GrowingTextView!
    var attachmentsItemsView = MenuItemView()
    var viewModel: ChatViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(show: true, notification: notification)
        //self.refreshData()
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(show: false, notification: notification)
        // self.refreshData()
    }
    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        
        guard let userInfo = (notification as Notification).userInfo, let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        var newHeight: CGFloat
        if #available(iOS 11.0, *) {
            newHeight = value.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            newHeight = value.cgRectValue.height
            
        }
        
        
        let animationDurarion = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let changeInHeight = (newHeight) * (show ? 1 : 0) + 10
        
        self.attachmentViewToggle(isOpen: false)
        viewModel?.toogleAttachment = false
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            self.bottom_constraight.constant = changeInHeight
            self.view.layoutIfNeeded()
        })
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    @IBAction func tappedOnView(_ sender: Any)
    {
        self.view.endEditing(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }
    
    @IBAction func showAssests(_ sender: UIButton) {
        if (viewModel?.toogleAttachment ?? false){
            self.attachmentViewToggle(isOpen: false)
        }else{
            self.attachmentViewToggle(isOpen: true)
            
        }
        viewModel?.toogleAttachment = !(viewModel?.toogleAttachment ?? false)
        
    }
    
   
    @IBAction func btnSend(_ sender: Any) {
        if let msg = txtMessage.text {
            btnSend.isEnabled = false
            txtMessage.text = ""
            self.viewModel?.sendMessage(messgae: msg)
            self.attachmentViewToggle(isOpen: false)
        }
       
    }
    
}
