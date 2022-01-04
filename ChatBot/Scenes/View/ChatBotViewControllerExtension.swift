//
//  ChatBotViewControllerExtension.swift
//  ChatBot
//
//  Created by Mahendra Vishwakarma on 04/01/22.
//

import Foundation
import UIKit


extension ChatBotViewController: ServerDelegate, UITextViewDelegate {
    
    func setupUI() {
        
        viewModel = ChatViewModel()
        viewModel?.delegate = self
        attachmentView.layer.cornerRadius = 20
        attachmentView.layer.masksToBounds = true
        self.attachmentsItemsView.view.frame = CGRect(x: 10, y: self.chatView.frame.maxY, width: self.view.frame.width-20, height: 30)
        self.view.addSubview(attachmentsItemsView.view)
        attachmentsItemsView.view.isHidden = true
        attachmentsItemsView.view.layer.cornerRadius = 20
        attachmentsItemsView.view.layer.masksToBounds = true
        attachmentsItemsView.view.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        chatView.layer.shadowColor =  UIColor.gray.cgColor
        chatView.layer.shadowOpacity = 1
        chatView.layer.shadowOffset = CGSize(width:0, height:0)
        chatView.layer.shadowRadius = 1
        chatView.backgroundColor = .clear
        btnSend.isEnabled = false
        txtMessage.delegate = self
        
        chatTableView.register(UINib(nibName: String(describing: LoginUserTableViewCell.self), bundle: .main), forCellReuseIdentifier: "LoginUserTableViewCell")
        chatTableView.register(UINib(nibName: String(describing: RemoteUserTableViewCell.self), bundle: .main), forCellReuseIdentifier: "RemoteUserTableViewCell")
        chatTableView.dataSource = self
        
    }
    
    func attachmentViewToggle(isOpen:Bool) {
        if isOpen {
            self.attachmentsItemsView.view.isHidden = false
            viewModel?.toogleAttachment = false
            UIView.animate(withDuration: 0.4) {
                self.attachmentsItemsView.view.frame = CGRect(x: 10, y: self.chatView.frame.origin.y-300-10, width: self.view.frame.width-20, height: 300)
            }
        }else {
            self.attachmentsItemsView.view.frame = CGRect(x: 10, y: self.chatView.frame.maxY, width: self.view.frame.width-20, height: 30)
            self.attachmentsItemsView.view.isHidden = true
        }
    }
    
    func update(status: Status) {
        DispatchQueue.main.async {
            self.chatTableView.reloadData()
            self.chatTableView.scrollToBottom()
            self.btnSend.isEnabled = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            let updatedText = text.trimmingCharacters(in: .whitespaces)
            if updatedText.count > 0 {
                btnSend.isEnabled = true
            }else{
                btnSend.isEnabled = false
            }
        }else{
            btnSend.isEnabled = false
        }
    }
    
}

extension ChatBotViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.totalChatMessage?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel?.totalChatMessage?[indexPath.row]
        if message?.chatBotID == 6 {
            //mine message
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoginUserTableViewCell", for: indexPath) as? LoginUserTableViewCell else {
                fatalError()
            }
            cell.bindData(msg: message)
            return cell
        } else {
            //remote user message
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RemoteUserTableViewCell", for: indexPath) as? RemoteUserTableViewCell else {
                fatalError()
            }
            
            cell.bindData(msg: message)
            return cell
        }
        
    }
}
