using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Xml;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;
using Com.Alipay;
using log4net;

/// <summary>
/// 功能：服务器异步通知页面
/// 版本：3.3
/// 日期：2012-07-10
/// 说明：
/// 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
/// 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
/// 
/// ///////////////////页面功能说明///////////////////
/// 创建该页面文件时，请留心该页面文件中无任何HTML代码及空格。
/// 该页面不能在本机电脑测试，请到服务器上做测试。请确保外部可以访问该页面。
/// 该页面调试工具请使用写文本函数logResult。
/// 如果没有收到该页面返回的 success 信息，支付宝会在24小时内按一定的时间策略重发通知
/// </summary>
public partial class notify_url : System.Web.UI.Page
{
    private static ILog logger = LogManager.GetLogger("notify_url");
    protected void Page_Load(object sender, EventArgs e)
    {
        logger.Info("支付宝充值回调开始notify_url");
        logger.Info("开始解析参数");
        Dictionary<string, string> sPara = GetRequestPost();

        if (sPara.Count > 0)//判断是否有带返回参数
        {
            //logger.Info("判断有带参数");
            Notify aliNotify = new Notify();
            var sign = Request.Form["sign"];
            logger.InfoFormat("验证签名:{0}", sign);
            bool verifyResult = aliNotify.VerifyNotify(sPara, sign);

            if (verifyResult)//验证成功
            {
                logger.Info("签名通过验证");
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //请在这里加上商户的业务逻辑程序代码


                //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                //获取支付宝的通知返回参数，可参考技术文档中服务器异步通知参数列表
                //解密（如果是RSA签名需要解密，如果是MD5签名则下面一行清注释掉）
                //sPara = aliNotify.Decrypt(sPara);

                //XML解析notify_data数据
                try
                {
                    //XmlDocument xmlDoc = new XmlDocument();
                    //string notify_data = sPara["notify_data"];
                    ////logger.InfoFormat("notify_data:{0}", notify_data);
                    //xmlDoc.LoadXml(notify_data);
                    //商户订单号
                    string out_trade_no = sPara["out_trade_no"];//xmlDoc.SelectSingleNode("/notify/out_trade_no").InnerText;
                    //支付宝交易号
                    string trade_no = sPara["trade_no"];//xmlDoc.SelectSingleNode("/notify/trade_no").InnerText;
                    //交易状态
                    string trade_status = sPara["trade_status"];//xmlDoc.SelectSingleNode("/notify/

                    logger.InfoFormat("out_trade_no:{0},trade_no:{1},trade_status:{2}", out_trade_no, trade_no, trade_status);
                    if (trade_status == "TRADE_FINISHED" || trade_status == "TRADE_SUCCESS")
                    {
                        //判断该笔订单是否在商户网站中已经做过处理
                        //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                        //如果有做过处理，不执行商户的业务程序

                        //注意：
                        //该种交易状态只在两种情况下出现
                        //1、开通了普通即时到账，买家付款成功后。
                        //2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。

                        if (Utility.IsNum(out_trade_no))
                        {
                            var id = Convert.ToInt32(out_trade_no);
                            var chargeLog = ChargeLogHelper.GetChargeLog(id);
                            if (chargeLog != null && chargeLog.Status == 0)
                            {
                                //添加
                                var user = AccountHelper.GetUser(chargeLog.UserId);
                                var seller = MerchantHelper.GetMerchant(chargeLog.UserId);
                                if (user == null)
                                {
                                    logger.ErrorFormat("不存在用户Id={0}", chargeLog.UserId);
                                }
                                else
                                {
                                    //交易金额
                                    double total_fee = Convert.ToDouble(sPara["total_fee"]);

                                    ExtcreditLog log = new ExtcreditLog();
                                    log.UserId = chargeLog.UserId;
                                    log.SellerId = chargeLog.SellerId;
                                    log.SourceId = DateTime.Now.GetUnixTime();
                                    log.Extcredit = (int)(chargeLog.Money * 1.0 / ParamHelper.ExtcreditCfgData.Charge);
                                    log.Type = ExtcreditSourceType.Charge;

                                    ExtcreditLogHelper.AddExtcreditLog(log);

                                    user.Integral = log.Extcredit;
                                    var money = user.Money + chargeLog.Money;
                                    logger.InfoFormat("充值之前;Money={0},充值之后:Money:{1}", user.Money, money);
                                    user.Money = money;
                                    user.TotalRecharge += chargeLog.Money;
                                    //保存用户信息
                                    AccountHelper.SaveAccount(user);
                                    seller.Money = user.Money;
                                    MerchantHelper.SaveMerchant(seller);
                                    //更新充值记录
                                    //chargeLog.OrderId = trade_no;   //更新第三方订单id
                                    chargeLog.Status = RechargeStatus.Success;
                                    ChargeLogHelper.UpdateStatus(chargeLog, trade_no);
                                    logger.InfoFormat("充值成功;UserId={1},Money={0},ChargeLogId:{2},total_fee:{3}", chargeLog.Money, chargeLog.UserId, id, total_fee);
                                }
                            }
                            else if (chargeLog == null)
                            {
                                logger.ErrorFormat("不存在充值记录Id={0}", id);
                            }
                            else
                            {
                                logger.Error("该充值记录已处理过");
                            }
                        }
                        else
                        {
                            logger.Error("商户订单号不是int型");
                        }

                        Response.Write("success");  //请不要修改或删除
                    }
                    //else if (trade_status == "TRADE_SUCCESS")
                    //{
                    //    //判断该笔订单是否在商户网站中已经做过处理
                    //    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //    //如果有做过处理，不执行商户的业务程序

                    //    //注意：
                    //    //该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。


                    //    Response.Write("success");  //请不要修改或删除
                    //}
                    else
                    {
                        if (Utility.IsNum(out_trade_no))
                        {
                            var id = Convert.ToInt32(out_trade_no);

                            //更新充值记录
                            var chargeLog = ChargeLogHelper.GetChargeLog(id);
                            if (chargeLog != null)
                            {
                                logger.ErrorFormat("充值失败;UserId={1},Money={0}", chargeLog.Money, chargeLog.UserId);
                            }
                            else
                            {
                                logger.ErrorFormat("充值失败,充值记录未找到Id:{0}", id);
                            }
                            //关闭时才更改状态
                            if (trade_status == "TRADE_Close" && chargeLog != null)
                            {
                                chargeLog.Status = RechargeStatus.Fail;
                                ChargeLogHelper.UpdateStatus(chargeLog, trade_no);
                                trade_status = "success";//返回success
                            }
                        }
                        else
                        {
                            logger.ErrorFormat("充值失败,充值id不是int型;Id={0}", out_trade_no);
                        }
                        Response.Write(trade_status);
                    }
                }
                catch (Exception exc)
                {
                    logger.ErrorFormat("异常：{0})", exc.Message);
                    Response.Write(exc.ToString());
                }
                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }
            else//验证失败
            {
                logger.Info("签名验证失败");
                Response.Write("fail");
            }
        }
        else
        {
            logger.Info("无通知参数");
            Response.Write("无通知参数");
        }
    }

    /// <summary>
    /// 获取支付宝POST过来通知消息，并以“参数名=参数值”的形式组成数组
    /// </summary>
    /// <returns>request回来的信息组成的数组</returns>
    public Dictionary<string, string> GetRequestPost()
    {
        int i = 0;
        Dictionary<string, string> sArray = new Dictionary<string, string>();
        NameValueCollection coll;
        //Load Form variables into NameValueCollection variable.
        coll = Request.Form;

        // Get names of all forms into a string array.
        String[] requestItem = coll.AllKeys;

        for (i = 0; i < requestItem.Length; i++)
        {
            sArray.Add(requestItem[i], Request.Form[requestItem[i]]);
            var key = requestItem[i];
            var value = Request.Form[requestItem[i]];
            //if (key == "notify_data") value = "加密数据不打印出来太多了。。。";
            //logger.InfoFormat("key:{0},value={1}", key, value);
        }

        return sArray;
    }
}
