//
//  ChatBotViewController.swift
//  ChatBot
//
//  Created by Mahendra Vishwakarma on 03/01/22.
//

import UIKit

class ChatBotViewController: UIViewController {
    
    @IBOutlet weak var bottom_constraight: NSLayoutConstraint!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var attachmentView: UIView!
    @IBOutlet weak var txtMessage: GrowingTextView!
    var attachmentsItemsView = MenuItemView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    @IBAction func showAssests(_ sender: UIButton) {
        if sender.isSelected{
            self.attachmentsItemsView.view.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self.attachmentsItemsView.view.frame = CGRect(x: 10, y: self.chatView.frame.origin.y-300-10, width: self.view.frame.width-20, height: 300)
            }
        }else{
            
            self.attachmentsItemsView.view.frame = CGRect(x: 10, y: self.chatView.frame.maxY, width: self.view.frame.width-20, height: 30)
            self.attachmentsItemsView.view.isHidden = true
            
        }
        sender.isSelected = !sender.isSelected
        
        
    }
    private func setupUI() {
        attachmentView.layer.cornerRadius = 20
        attachmentView.layer.masksToBounds = true
        self.attachmentsItemsView.view.frame = CGRect(x: 10, y: self.chatView.frame.maxY, width: self.view.frame.width-20, height: 30)
        self.view.addSubview(attachmentsItemsView.view)
        attachmentsItemsView.view.isHidden = true
        attachmentsItemsView.view.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        chatView.layer.shadowColor =  UIColor.gray.cgColor
        chatView.layer.shadowOpacity = 1
        chatView.layer.shadowOffset = CGSize(width:0, height:0)
        chatView.layer.shadowRadius = 1
        chatView.backgroundColor = .clear
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
        
        
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            self.bottom_constraight.constant = changeInHeight
            self.attachmentsItemsView.view.frame = CGRect(x: 10, y: self.chatView.frame.maxY, width: self.view.frame.width-20, height: 30)
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
    @IBAction func btnAttachment(_ sender: Any) {
    }
    
    @IBAction func btnSend(_ sender: Any) {
    }
    
}
