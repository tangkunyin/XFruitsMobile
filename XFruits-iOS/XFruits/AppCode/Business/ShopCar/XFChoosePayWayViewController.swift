//
//  XFChoosePayWayViewController.swift
//  XFruits
//
//  Created by zhaojian on 5/28/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD


fileprivate let payCellIdentifier = "XFPayCellIdentifier"

class XFChoosePayWayViewController: XFBaseSubViewController {

    var payInfo: XFOrderCommit?
    
    lazy var payInfoTable: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        tableView.tableFooterView = UIView()
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.register(XFPayTimerCountDownViewCell.self, forCellReuseIdentifier: payCellIdentifier)
        return tableView
    }()
    
    lazy var submitPayBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("确认支付", for: .normal)
        btn.backgroundColor = XFConstants.Color.green
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds =  true
        btn.addTarget(self, action: #selector(payWithType), for: .touchUpInside)
        return btn
    }()
    
    lazy var request: XFOrderSerivice = {
        let serviceRequest = XFOrderSerivice()
        return serviceRequest
    }()

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 必须手动释放Timer，否则会导致内存泄露
        let cell = payInfoTable.cellForRow(at: IndexPath(row: 0, section: 0)) as? XFPayTimerCountDownViewCell
        if let cell: XFPayTimerCountDownViewCell = cell {
            cell.invalidateTimer()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(payInfoTable)
        self.view.addSubview(submitPayBtn)
        
        payInfoTable.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.view)
            make.height.greaterThanOrEqualTo(400)
        })
        submitPayBtn.snp.makeConstraints({ (make) in
            make.height.equalTo(40)
            make.left.equalTo(self.view.snp.left).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.top.equalTo(self.payInfoTable.snp.bottom).offset(30)
        })

    }

    override func backToParentController() {
        weak var weakSelf = self
        let alertController = UIAlertController.init(title: "提 示", message: "您确定要放弃支付？", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction.init(title: "确定", style: .`default`) { (data) in
            weakSelf?.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    /// https://doc.open.alipay.com/docs/doc.htm?spm=a219a.7629140.0.0.dXCllL&treeId=204&articleId=105295&docType=1
    /// https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=8_5
    @objc private func payWithType(){
        var channelId: Int?
        for item in (payInfo?.payChannels)! {
            if let payChannel: XFPayChannel = item, payChannel.defaultChannel == true  {
                channelId = payChannel.channel
                break
            }
        }
        if let cid = channelId, let payInfo = payInfo, let orderId = payInfo.orderId {
            let payChannel = cid == 1 ? 200 : 100
            weak var weakSelf = self
            let params:[String : Any] = ["payChannel": payChannel, "orderId": orderId]
            request.orderPayCommit(params: params) { (data) in
                switch cid {
                case 1:
                    weakSelf?.orderPayWithAliPay(data as! String)
                case 2:
                    weakSelf?.orderPayWithWeixin(data as! String)
                default:
                    dPrint("pay channel: \(cid), 特么不支持的支付方式，别点了....")
                }
            }
        }
    }
    
}


// MARK: - Payment
extension XFChoosePayWayViewController {
    private func orderPayWithAliPay(_ data: String) {
        weak var weakSelf = self
        AlipaySDK.defaultService().payOrder(data, fromScheme: "XFruits") { (respData) in
            if respData != nil,
                let dict = respData as NSDictionary?,
                let response: XFAlipayResponse = XFAlipayResponse.deserialize(from: dict) {
                
                //MARK: TODO parse empty...
                dPrint(dict)
                dPrint(response)
                
                if response.resultStatus == 8000 || response.resultStatus == 9000 {
                    if let payResponse: XFAlipayTradeResponse = response.result?.alipay_trade_app_pay_response,
                        payResponse.app_id == XFConstants.SDK.Alipay.appId, Int(payResponse.code) == 10000 {
                        weakSelf?.payInfo?.cashFee = payResponse.total_amount
                        weakSelf?.handleThePaymentResult(flag: true, payType: 1)
                        return
                    }
                }
                var errorMsg = ""
                switch response.resultStatus {
                case 5000:
                    errorMsg = response.memo.characters.count != 0 ? response.memo : "重复请求"
                case 6001:
                    errorMsg = response.memo.characters.count != 0 ? response.memo : "用户中途取消"
                case 6002:
                    errorMsg = response.memo.characters.count != 0 ? response.memo : "网络连接出错"
                default:
                    errorMsg = response.memo.characters.count != 0 ? response.memo : "其它支付错误:\(response.resultStatus)"
                }
                weakSelf?.handleThePaymentResult(flag: false, payType: 1, errorMsg: errorMsg)
            }
        }
    }
    
    private func orderPayWithWeixin(_ data: String){
        MBProgressHUD.showError("暂还不支持微信，点支付宝吧~")
    }
    
    private func handleThePaymentResult(flag: Bool, payType: Int, errorMsg: String = "") {
        weak var weakSelf = self
        let payResultVC = XFPayResultViewController()
        payResultVC.isSuccess = flag
        payResultVC.payType = payType
        payResultVC.errorMsg = errorMsg
        payResultVC.totalAmount = payInfo?.cashFee ?? "0.00"
        payResultVC.onPageClosed = {
            weakSelf?.navigationController?.popToRootViewController(animated: true)
        }
        present(payResultVC, animated: true, completion: nil)
    }
}


// MARK: - UITabelViewDelegates
extension XFChoosePayWayViewController: UITableViewDataSource ,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            return 3
        }
        guard let payInfo = payInfo else {
            return 0
        }
        return payInfo.payChannels.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat  {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 180
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        guard let payInfo = payInfo else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        if section == 0  {
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: payCellIdentifier) as! XFPayTimerCountDownViewCell
                weak var weakSelf = self
                cell.onTimerEnd = {
                    dPrint("支付已过期")
                    weakSelf?.submitPayBtn.isEnabled = false
                    weakSelf?.submitPayBtn.backgroundColor = XFConstants.Color.coolGrey
                }
                cell.selectionStyle = .none
                cell.endTime = payInfo.orderExpiration!
                return cell
            } else {
                let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
                cell.selectionStyle = .none
                var attrText:NSMutableAttributedString? = nil
                if row == 1 {
                    attrText = NSMutableAttributedString(string: "订单编号：\(payInfo.orderId ?? "")", attributes: xfAttributes())
                } else if row == 2 {
                    attrText = NSMutableAttributedString(string: "支付金额：", attributes: xfAttributes())
                    attrText?.append(NSAttributedString(string: "\(payInfo.cashFee ?? "error")", attributes: xfAttributes(15, fontColor: XFConstants.Color.salmon)))
                }
                cell.textLabel?.attributedText = attrText
                return cell
            }
        }
        let cell = XFTPayModeableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        cell.data = payInfo.payChannels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.section == 1 {
            for (index, item) in (payInfo?.payChannels.enumerated())! {
                if let channel: XFPayChannel = item {
                    channel.defaultChannel = index == indexPath.row
                }
            }
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
        }
    }
    
}
