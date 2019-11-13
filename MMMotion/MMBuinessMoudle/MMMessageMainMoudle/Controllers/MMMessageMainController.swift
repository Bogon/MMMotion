//
//  MMMessageMainController.swift
//  MMPocket
//
//  Created by 张奇 on 2019/10/27.
//  Copyright © 2019 Bogon. All rights reserved.
//

import UIKit

class MMMessageMainController: MSGMessengerViewController {
    
    let steve = User(displayName: "我", avatar: #imageLiteral(resourceName: "steve228uk"), avatarUrl: nil, isSender: true, isFunction: true)
    
    let tim = User(displayName: "小袋", avatar: #imageLiteral(resourceName: "timi"), avatarUrl: nil, isSender: false, isFunction: true)
    
    var id = 100
    
    override var style: MSGMessengerStyle {
        let style = MessengerKit.Styles.travamigos
        return style
    }
    
    
    lazy var messages: [[MSGMessage]] = {
        return [
            [
                 MSGMessage(id: 2, body: .text("你好很高兴见到你~"), user: tim, sentAt: Date())
                ],
            [
                MSGMessage(id: 2, body: .text("输入你想了解的运行常识，我来帮你答疑解惑~"), user: tim, sentAt: Date())
            ],
            [
                MSGMessage(id: 5, body: .text("让我想一想…"), user: steve, sentAt: Date()),
            ]
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "运动助手"
        dataSource = self
        delegate = self

        self.initLeftItem()
     }
    
    
    func initLeftItem() {
            let spaceItem: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
            spaceItem.width = -6
            if #available(iOS 11.0, *) {
                spaceItem.width = -16
            }
        let closeItem:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "barbutton_back"), style: .plain, target: self, action:
            #selector(pop))
        closeItem.tintColor = .black
        navigationItem.leftBarButtonItem = closeItem
    }
    
    @objc func pop() {
        if self.presentingViewController != nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.scrollToBottom(animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.setUsersTyping([self.tim])
        }
        
    }
    
    override func inputViewPrimaryActionTriggered(inputView: MSGInputView) {
        id += 1
        
        let body: MSGMessageBody = (inputView.message.containsOnlyEmoji && inputView.message.count < 5) ? .emoji(inputView.message) : .text(inputView.message)
        
        let message = MSGMessage(id: id, body: body, user: steve, sentAt: Date())
        insert(message)
        
        id += 1
        MMTalkInfoAPIViewModel.shared.getTalkingInfo(WithParameters: ["spoken": inputView.message], isCache: false).done { [weak self] (response)  in
            let body: MSGMessageBody = .text(response.talkValue ?? "")
            let message = MSGMessage(id: self!.id, body: body, user: self!.tim, sentAt: Date())
            self!.insert(message)
        } .catch {  [weak self] (error) in
            let body: MSGMessageBody = .text("不知道你在说什么…… 哼哼")
            let message = MSGMessage(id: self!.id, body: body, user: self!.tim, sentAt: Date())
            self!.insert(message)
        }
        
    }
    
    override func insert(_ message: MSGMessage) {
        
        collectionView.performBatchUpdates({
            if let lastSection = self.messages.last, let lastMessage = lastSection.last, lastMessage.user.displayName == message.user.displayName {
                self.messages[self.messages.count - 1].append(message)
                
                let sectionIndex = self.messages.count - 1
                let itemIndex = self.messages[sectionIndex].count - 1
                self.collectionView.insertItems(at: [IndexPath(item: itemIndex, section: sectionIndex)])
                
            } else {
                self.messages.append([message])
                let sectionIndex = self.messages.count - 1
                self.collectionView.insertSections([sectionIndex])
            }
        }, completion: { (_) in
            self.collectionView.scrollToBottom(animated: true)
            self.collectionView.layoutTypingLabelIfNeeded()
        })
        
    }
    
    override func insert(_ messages: [MSGMessage], callback: (() -> Void)? = nil) {
        
        collectionView.performBatchUpdates({
            for message in messages {
                if let lastSection = self.messages.last, let lastMessage = lastSection.last, lastMessage.user.displayName == message.user.displayName {
                    self.messages[self.messages.count - 1].append(message)
                    
                    let sectionIndex = self.messages.count - 1
                    let itemIndex = self.messages[sectionIndex].count - 1
                    self.collectionView.insertItems(at: [IndexPath(item: itemIndex, section: sectionIndex)])
                    
                } else {
                    self.messages.append([message])
                    let sectionIndex = self.messages.count - 1
                    self.collectionView.insertSections([sectionIndex])
                }
            }
        }, completion: { (_) in
            self.collectionView.scrollToBottom(animated: false)
            self.collectionView.layoutTypingLabelIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                callback?()
            }
        })
        
    }
    
}

// MARK: - MSGDataSource

extension MMMessageMainController: MSGDataSource {
    
    func numberOfSections() -> Int {
        return messages.count
    }
    
    func numberOfMessages(in section: Int) -> Int {
        return messages[section].count
    }
    
    func message(for indexPath: IndexPath) -> MSGMessage {
        return messages[indexPath.section][indexPath.item]
    }
    
    func footerTitle(for section: Int) -> String? {
        return "Just now"
    }
    
    func headerTitle(for section: Int) -> String? {
        return messages[section].first?.user.displayName
    }
    
}

// MARK: - MSGDelegate
extension MMMessageMainController: MSGDelegate {
    
    func linkTapped(url: URL) {
        print("Link tapped:", url)
    }
    
    func avatarTapped(for user: MSGUser) {
        print("Avatar tapped:", user)
    }
    
    func tapReceived(for message: MSGMessage) {
        print("Tapped: ", message)
    }
    
    func longPressReceieved(for message: MSGMessage) {
        print("Long press:", message)
    }
    
    func shouldDisplaySafari(for url: URL) -> Bool {
        return true
    }
    
    func shouldOpen(url: URL) -> Bool {
        return true
    }
    
}

