//
//  XFWKWebView.swift
//  wkWebView
//
//  Created by XiaoFeng on 2016/12/26.
//  Copyright © 2016年 XiaoFeng. All rights reserved.
//  github链接:https://github.com/XFIOSXiaoFeng/WKWebView

import UIKit
import WebKit
import DeviceKit
import RxCocoa
import RxSwift
import Moya
import RTRootNavigationController

//网页加载类型
enum WkWebLoadType{
    case loadWebURLString
    case loadWebHTMLString
    case POSTWebURLString
}

enum OLWebLoadHandlerType: Int {
    /// 协议
    case protocols      = 1
}

class WKWebViewController: cowCloudUnionController, ScrollingNavigationControllerDelegate {
    
    let disposeBag = DisposeBag()
    
    fileprivate var webView: WKWebView!
    fileprivate var progressView: UIProgressView!
    
    //保存的网址链接
    fileprivate var urltring: String!
    //保存POST请求体
    fileprivate var postData: String!
    //是否是第一次加载
    fileprivate var needLoadJSPOST:Bool?
    //保存请求链接
    fileprivate var snapShotsArray:Array<Any>?
    //加载类型
    fileprivate var loadWebType: WkWebLoadType?
    
    /// 充值金额和内购项目id
    var fadeType: XNControllerFadeType = .pop
    var commitValue: [String: Any] = [String: Any]()
    
    var isNavHidden = false
    //var javascriptBridge: WKWebViewJavascriptBridge!
    var handlerType: OLWebLoadHandlerType = .protocols
    
    init(_ handlerType: OLWebLoadHandlerType, fadeType: XNControllerFadeType) {
        super.init(nibName: nil, bundle: nil)
        self.handlerType = handlerType
        self.fadeType = fadeType
    }
    
    required init?(coder aDecoder: NSCoder) {
        /// fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    /// 设置基本属性
    override func loadView() {
        super.loadView()
        
    }
    
    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            if let tabBarController = tabBarController {
                navigationController.followScrollView(self.webView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
            } else {
                navigationController.followScrollView(self.webView, delay: 0.0, scrollSpeedFactor: 2)
            }
            navigationController.scrollingNavbarDelegate = self
            navigationController.expandOnActive = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 添加WkWebView
        addWkWebView()

        /// 添加ProgressView
        addProgressView()
        
        /// 加载网页类型
        loadType()
        
        switch self.handlerType {
            case .protocols:
                self.initLeftItem(self.fadeType)

                /// 原生跟H5进行交互，需要在H5中定义相应的事件，完成交互。如下：H5中方法名：feedback
                /*self.javascriptBridge.register(handlerName: "feedback") { (paramters, callback) in
             
                }        */
                    
            
        }
        
    }

    //MARK:- 懒加载控件
    //关闭按钮
    fileprivate lazy var closeButtonItem:UIBarButtonItem = {
        
        let closeButtonItem = UIBarButtonItem.init(title: "关闭", style: UIBarButtonItem.Style.plain, target: self, action: #selector(closeItemClicked))
        closeButtonItem.tintColor = .black
        return closeButtonItem
        
    }()
    
    //返回按钮
    fileprivate lazy var customBackBarItem:UIBarButtonItem = {[unowned self] in
        
        let backItemImage = UIImage.init(named: "backItemImage")
        let backItemHlImage = UIImage.init(named: "backItemImage-hl")
        let backButton = UIButton.init(type: .system)
        backButton .setTitle("返回", for: .normal)
        backButton .setTitleColor(UIColor.black, for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backButton.tintColor = UIColor.black
        backButton .setImage(backItemImage, for: .normal)
        backButton .setImage(backItemHlImage, for: .highlighted)
        backButton.sizeToFit()
        backButton.addTarget(self, action: #selector(customBackItemClicked), for: .touchUpInside)
        let customBackBarItem = UIBarButtonItem.init(customView: backButton)
        return customBackBarItem
    }()

    //相当于OC中的deallo
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}


// MARK: - Other Action
extension WKWebViewController {
    
    /// 普通URL加载方式
    /// Parameter urlString: 需要加载的url字符串
    func loadUrlSting(string:String!) {
        urltring = string;
        loadWebType = .loadWebURLString
    }
    
    /// 加载本地HTML
    /// Parameter urlString: 需要加载的本地文件名
    func loadHTMLSting(string:String!) {
        urltring = string
        loadWebType = .loadWebHTMLString
        loadHost(urlString: string)
    }

    /// POST方式请求加载
    /// urlString: post请求的url字符串
    /// postString: post参数体 详情请搜索swift/oc转义字符（注意格式："\"username\":\"aaa\",\"password\":\"123\""）
    func loadPOSTUrlSting(string:String!,postString:String!) {
        
        loadWebType = .POSTWebURLString
        urltring = string
        postData = postString
    }
    
    
    fileprivate func loadHost(urlString:String) {
        /*
        let path = Bundle.main.path(forResource: string, ofType: "html")
        // 获得html内容
        do {
            let html = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            // 加载js
            webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
        } catch { }     */
        
        urltring = urlString
        let bundlePath = Bundle.main.bundlePath
        let path = "file://\(bundlePath)/OLNetworkHtmlMoudle/\(urlString).html"
        guard let url = URL(string: path) else {
            return
        }
        
        if webView == nil {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }

    
    fileprivate func loadType() {
        
        switch loadWebType!{
            
        case .loadWebURLString :
            let urlstr = URL.init(string: urltring!)
            //let request = URLRequest.init(url: urlstr!)
            /**  如果平台内存在Html5与原生进行交互，而且发起request时，需要OAuth2进行认证时，需要添加如下代码
            var request = URLRequest.init(url: urlstr!)
            let bearerValue: String  = UserDefaults.standard.string(forKey: kOLAccessToken) ?? "5ab927f3-f181-47ff-9501-d03141a52c55"
            log.info("bearerValue = \(bearerValue)")
            request.setValue("Bearer \(bearerValue)", forHTTPHeaderField: "Authorization")
            **/
            
            var request = URLRequest.init(url: urlstr!)
            //            let url: String = request.url!.absoluteString
            //            if url.contains("weixin://") {
            //            }
            request.setValue("weixin.wujiwangluo.com://", forHTTPHeaderField: "Referer")
            webView.load(request)
            
        case .loadWebHTMLString:
            loadHost(urlString: urltring!)
            
        case .POSTWebURLString:
            needLoadJSPOST = true
            loadHost(urlString: "WKJSPOST")
        }
    }

    // 调用JS发送POST请求
    fileprivate func postRequestWithJS() {
        // 拼装成调用JavaScript的字符串 urltring请求的页面地址 postData发送POST的参数
        let jscript = "post('\(urltring!)', {\(postData!)});"
        // 调用JS代码
        webView.evaluateJavaScript(jscript) { (object, error) in
        }
    }
    
    //添加wkWebView
    fileprivate func addWkWebView() {
        // 创建webveiew
        // 创建一个webiview的配置项
        let configuretion = WKWebViewConfiguration()
        
        // Webview的偏好设置
        configuretion.preferences = WKPreferences()
        configuretion.preferences.minimumFontSize = 10
        configuretion.preferences.javaScriptEnabled = true
        
        // 默认是不能通过JS自动打开窗口的，必须通过用户交互才能打开
        configuretion.preferences.javaScriptCanOpenWindowsAutomatically = false
        
        // 通过js与webview内容交互配置
        configuretion.userContentController = WKUserContentController()
        
        // 添加一个名称，就可以在JS通过这个名称发送消息：
        // window.webkit.messageHandlers.AppModel.postMessage({body: 'xxx'})
        configuretion.userContentController.add(self, name: "closeWindow")
        
        var topMargin: CGFloat = 20
        let device = Device.current
        if device.isOneOf([.iPhoneXS, .iPhoneX, .iPhoneXR, .iPhoneXSMax, .iPhone11, .iPhone11Pro, .iPhone11ProMax]) {
            topMargin = 40
        } else if device.isOneOf([.simulator(.iPhoneXS), .simulator(.iPhoneX), .simulator(.iPhoneXR), .simulator(.iPhoneXSMax), .simulator(.iPhone11), .simulator(.iPhone11Pro), .simulator(.iPhone11ProMax)]) {
            topMargin = 40
        }

        webView = WKWebView(frame:CGRect.init(x: 0, y: 0, width: UIScreen.ol_width, height: UIScreen.ol_height - topMargin), configuration: configuretion)
        
        //开启手势交互
        webView.allowsBackForwardNavigationGestures = true

        webView?.navigationDelegate = self
        
        webView?.uiDelegate = self
        
        // 监听支持KVO的属性
        webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        //内容自适应
        webView.sizeToFit();
        
        view.addSubview(webView!);
        
        /// 添加交互的桥接文件
        //self.javascriptBridge = WKWebViewJavascriptBridge(webView: webView)
        
    }
    //添加进度条
    fileprivate func addProgressView() {
        
        progressView = UIProgressView(progressViewStyle: .default)
        if isNavHidden == true{
            progressView?.frame = CGRect(x: 0, y: 20, width: view.bounds.size.width, height: 3)
        }else{
            progressView?.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 1)
        }
        progressView?.trackTintColor = UIColor.clear
        progressView?.progressTintColor = UIColor.init(hex: "#007AFF")
        
        view.addSubview(progressView!)
    }
    
    //视图即将消失的时候调用该方法
    override func viewDidDisappear(_ animated: Bool) {
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "AppModel")
        webView.navigationDelegate = nil;
        webView.uiDelegate = nil;
    }
    
    //自定义左边按钮
    @objc fileprivate func customBackItemClicked() {
        if (webView.goBack() != nil) {
            webView.goBack()
        }else{
            _ = navigationController?.popViewController(animated: true)
        }
    }
    //关闭按钮
    @objc fileprivate func closeItemClicked() {
        _ = navigationController?.popViewController(animated: true)
    }

    //KVO监听进度条变化
     override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress"{
            
            progressView.alpha = 1.0
            let animated = Float(webView.estimatedProgress) > progressView.progress;
    
            progressView .setProgress(Float(webView.estimatedProgress), animated: animated)
            
            print(webView.estimatedProgress)
            self.progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            
            if Float(webView.estimatedProgress) >= 1.0{
                
                //设置动画效果，动画时间长度 1 秒。
                UIView.animate(withDuration: 1, delay:0.01,options:UIView.AnimationOptions.curveEaseOut, animations:{()-> Void in

                    self.progressView.alpha = 0.0
                    
                },completion:{(finished:Bool) -> Void in
                    
                    self.progressView .setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    //请求链接处理
    fileprivate func pushCurrentSnapshotView(_ request: NSURLRequest) -> Void {
        
        guard let urlStr = snapShotsArray?.last else {
            return
        }
        
        let url = URL(string: urlStr as! String)
        let lastRequest = NSMutableURLRequest.init(url: url!)
        
        /*** 如果平台内存在Html5与原生进行交互，而且发起request时，需要OAuth2进行认证时，需要添加如下代码
        let bearerValue: String  = UserDefaults.standard.string(forKey: kOLAccessToken) ?? "5ab927f3-f181-47ff-9501-d03141a52c55"
        lastRequest.setValue("Bearer \(bearerValue)", forHTTPHeaderField: "Authorization")
        **/
        //如果url是很奇怪的就不push
        if request.url?.absoluteString == "about:blank"{
            return;
        }

        //如果url一样就不进行push
        if (lastRequest.url?.absoluteString == request.url?.absoluteString) {
            return;
        }
        
        let currentSnapShotView = webView.snapshotView(afterScreenUpdates: true);
        
        //向数组添加字典
        snapShotsArray = [["request":request,"snapShotView":currentSnapShotView]]

    }
    
    fileprivate func updateNavigationItems(){
    
        if webView.canGoBack {
            let spaceButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
            spaceButtonItem.width = -6
            
            navigationItem .setLeftBarButtonItems([customBackBarItem,closeButtonItem], animated: false)
            
        }else{
            
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
            self.initLeftItem(.pop)
//            navigationItem .setLeftBarButtonItems([customBackBarItem],animated: false)
        }
    }
}


// MARK: - WKScriptMessageHandler
extension WKWebViewController: WKScriptMessageHandler{

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if (message.name == "closeWindow") {
            _ = navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - WKNavigationDelegate
extension WKWebViewController: WKNavigationDelegate{
    
    //服务器开始请求的时候调用
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        switch navigationAction.navigationType {
        case WKNavigationType.linkActivated:
            pushCurrentSnapshotView(navigationAction.request as NSURLRequest)
            break
        case WKNavigationType.formSubmitted:
            pushCurrentSnapshotView(navigationAction.request as NSURLRequest)
            break
        case WKNavigationType.backForward:
            break
        case WKNavigationType.reload:
            break
        case WKNavigationType.formResubmitted:
            break
        case WKNavigationType.other:
            pushCurrentSnapshotView(navigationAction.request as NSURLRequest)
            break
        @unknown default:
            fatalError()
        }
        
        switch self.handlerType {
        case .protocols:
            /// 更新左边返回按钮
            updateNavigationItems()
        }
        
        
        decisionHandler(.allow);
    }
    
    /// 进度条代理事件
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        //print(#function)
    }
    
    /// 内容返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //print(#function)
    }
    
    /// 这个是网页加载完成，导航的变化
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
        /// 判断是否需要加载（仅在第一次加载）
        if needLoadJSPOST == true {
            /// 调用使用JS发送POST请求的方法
            postRequestWithJS()
            /// 将Flag置为NO（后面就不需要加载了）
            needLoadJSPOST = false
        }
        switch self.handlerType {
            
            case .protocols:
                /// 更新左边返回按钮
                updateNavigationItems()
        }
        if webView.title != nil {
            title = webView.title
        }
    }
    
    /// 开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //print(#function)
        progressView.isHidden = false;
    }
    
    /// 跳转失败的时候调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //print(#function)
    }
    
    /// 服务器请求跳转的时候调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        //print(#function)
    }
    
    /// 内容加载失败时候调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //print(#function)
    }
    
    /// https://www.jianshu.com/p/7648f10613fa
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod ==  NSURLAuthenticationMethodServerTrust {
            let card: URLCredential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, card)
        }
    }
}

/// MARK: - WKUIDelegate 不实现该代理方法 网页内调用弹窗时会抛出异常,导致程序崩溃
extension WKWebViewController: WKUIDelegate{
    
    /// 获取js 里面的提示
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            completionHandler()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) -> Void in
            completionHandler()
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // js 信息的交流
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) -> Void in
            completionHandler(false)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // 交互。可输入的文本。
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        let alert = UIAlertController(title: prompt, message: defaultText, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) -> Void in
            textField.textColor = UIColor.red
        }
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            completionHandler(alert.textFields![0].text!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
