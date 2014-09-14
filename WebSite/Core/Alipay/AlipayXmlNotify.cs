using System.Web;
using System.Text;
using System.IO;
using System.Net;
using System.Xml;
using System;
using System.Collections.Generic;
using log4net;

namespace Com.Alipay
{
    /// <summary>
    /// 类名：Notify
    /// 功能：支付宝通知处理类
    /// 详细：处理支付宝各接口通知返回
    /// 版本：3.3
    /// 修改日期：2011-07-05
    /// '说明：
    /// 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
    /// 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
    /// 
    /// //////////////////////注意/////////////////////////////
    /// 调试通知返回时，可查看或改写log日志的写入TXT里的数据，来检查通知返回是否正常 
    /// </summary>
    public class AlipayXmlNotify
    {
        private static ILog logger = LogManager.GetLogger("AlipayXmlNotify");
        #region 字段
        private string _partner = "2088511724484349";               //合作身份者ID
        private string _key = "okkcs8za7xeuemhmbpmks2kd7agiqu8e";                   //支付宝MD5私钥
        private string _private_key = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMcFZaiksNQh/q0+90/FDt/kymRTRInODDoL4DzLb7Au21w0gYY+gFZaE8pt6F5bfBimYnB9lTBe0+M/ViyfRYYOvb6sSygcZriv8wmWo8G2WFmfP/m0cnQjyQ57UxCUVjAaJRFaqATK6NI3muuqszfJKKq+WOW8Lr1PQfMEqyBPAgMBAAECgYAk/zzZr9vrY3JrlFP3MUPFnUt+gPgxwesF82U5B/x4PQ2sQ1p8sSu8YbxiGjJjMBCOqIeOL9pHBqnPCdwkKWuL3wLL7oNqMiqBrUdEkcEhON2AocIuirBI1E3dMDtbpKLDBOkz+djbo3vnwxf0m9Vh7wsp5m+OayvieQHLASm+AQJBAPWlm0F9VqIUz6BSq2yDOsq38RC30WjH05JZLmjb1KzOUm0dfau+PnfQuyHO6OPcMaSy0uxVA8s302Fj9iN2T08CQQDPaLlWb2nZ3y7u89rwSO9wSWeVrh8S2e/2pDqiuo/Z3SS6MzO3YoaLFP8BIEy/G30mhH1+kDsQCUP4vwkcMd8BAkAQOtLZLtjMeKeHJi8hSkJWJnUM77gsPheicbX5Q5z3leIoR2yILleePvI+N5d3hpLZGN+KsctAX/3dT2dxzF1NAkEAsadq8O1XhmXTpps7Ugu3A7/sONo/BX+lOearzszsAFmaZt8Kki6TPbhLQGSxOBRMm1xqvai+3lqBXSQMopjZAQJASAjwID3PBvk58khEQLIBYrY72eN2yaQMInsr8zEXzcn9R85GuPgxDb0AHNZU/83XpSaEX7xb9ijlXTFvy8w7ZQ==";           //商户的私钥
        private string _public_key = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC7pe69qNZ9it2T9Ix80u330SEv37L/4u2PzLMmipt/ugl17T9G6rLmbwGAu6kOjclEDC6+S1A/nBhVvLPUCdYZcqYk5thLYCNE2sg83BhO/v2ICKT0FqVINNTIq8dSFg5o8DIUY5JGGBnEOGmR/OWURb6SRGtqlEJIoKfjomE9aQIDAQAB";            //支付宝的公钥
        private string _input_charset = "utf-8";         //编码格式
        private string _sign_type = "0001";             //签名方式

        //支付宝消息验证地址
        private string Https_veryfy_url = "https://mapi.alipay.com/gateway.do?service=notify_verify&";
        #endregion


        /// <summary>
        /// 构造函数
        /// 从配置文件中初始化变量
        /// </summary>
        /// <param name="inputPara">通知返回参数数组</param>
        /// <param name="notify_id">通知验证ID</param>
        public AlipayXmlNotify()
        {
            //初始化基础配置信息
            //_partner = Config.Partner.Trim();
            //_key = Config.Key.Trim();
            //_private_key = Config.Private_key.Trim();
            //_public_key = Config.Public_key.Trim();
            //_input_charset = Config.Input_charset.Trim().ToLower();
            //_sign_type = Config.Sign_type.Trim().ToUpper();
        }

        /// <summary>
        ///  验证消息是否是支付宝发出的合法消息，验证callback
        /// </summary>
        /// <param name="inputPara">通知返回参数数组</param>
        /// <param name="sign">支付宝生成的签名结果</param>
        /// <returns>验证结果</returns>
        public bool VerifyReturn(Dictionary<string, string> inputPara, string sign)
        {
            //获取返回时的签名验证结果
            bool isSign = GetSignVeryfy(inputPara, sign, true);

            //写日志记录（若要调试，请取消下面两行注释）
            //string sWord = "isSign=" + isSign.ToString() + "\n 返回回来的参数：" + GetPreSignStr(inputPara) + "\n ";
            //Core.LogResult(sWord);

            //判断isSign是否为true
            //isSign不是true，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
            if (isSign)//验证成功
            {
                return true;
            }
            else//验证失败
            {
                return false;
            }
        }

        /// <summary>
        ///  验证消息是否是支付宝发出的合法消息，验证服务器异步通知
        /// </summary>
        /// <param name="inputPara">通知返回参数数组</param>
        /// <param name="sign">支付宝生成的签名结果</param>
        /// <returns>验证结果</returns>
        public bool VerifyNotify(Dictionary<string, string> inputPara, string sign)
        {
            //logger.InfoFormat("_sign_type:{0}", _sign_type);
            //解密
            if (_sign_type == "0001")
            {
                inputPara = Decrypt(inputPara);
            }

            //获取是否是支付宝服务器发来的请求的验证结果
            string responseTxt = "true";
            try
            {
                //XML解析notify_data数据，获取notify_id
                string notify_id = "";
                XmlDocument xmlDoc = new XmlDocument();
                var notify_data = inputPara["notify_data"];
                //logger.InfoFormat("notify_data:{0}", notify_data);
                xmlDoc.LoadXml(notify_data);
                notify_id = xmlDoc.SelectSingleNode("/notify/notify_id").InnerText;

                if (notify_id != "") { responseTxt = GetResponseTxt(notify_id); }
                logger.InfoFormat("responseTxt：{0}，notify_id：{1})", responseTxt, notify_id);
            }
            catch (Exception exc)
            {
                logger.ErrorFormat("异常：{0})", exc.Message);
                responseTxt = exc.ToString();
            }


            //写日志记录（若要调试，请取消下面两行注释）
            //string sWord = "responseTxt=" + responseTxt + "\n isSign=" + isSign.ToString() + "\n 返回回来的参数：" + GetPreSignStr(inputPara) + "\n ";
            //Core.LogResult(sWord);
            //获取返回时的签名验证结果
            bool isSign = GetSignVeryfy(inputPara, sign, false);
            logger.InfoFormat("isSign：{0})", isSign);

            //判断responsetTxt是否为true，isSign是否为true
            //responsetTxt的结果不是true，与服务器设置问题、合作身份者ID、notify_id一分钟失效有关
            //isSign不是true，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
            if (responseTxt == "true" && isSign)//验证成功
            {
                return true;
            }
            else//验证失败
            {
                return false;
            }
        }

        /// <summary>
        /// 获取待签名字符串（调试用）
        /// </summary>
        /// <param name="inputPara">通知返回参数数组</param>
        /// <returns>待签名字符串</returns>
        public string GetPreSignStr(Dictionary<string, string> inputPara)
        {
            Dictionary<string, string> sPara = new Dictionary<string, string>();

            //过滤空值、sign与sign_type参数
            sPara = Core.FilterPara(inputPara);

            //根据字母a到z的顺序把参数排序
            sPara = Core.SortPara(sPara);

            //获取待签名字符串
            string preSignStr = Core.CreateLinkString(sPara);

            return preSignStr;
        }

        /// <summary>
        /// 解密
        /// </summary>
        /// <param name="inputPara">要解密数据</param>
        /// <returns>解密后结果</returns>
        public Dictionary<string, string> Decrypt(Dictionary<string, string> inputPara)
        {
            try
            {
                var dd = inputPara["notify_data"];
                logger.InfoFormat("Decrypt,之前：{0}", dd);
                var dr = RSAFromPkcs8.decryptData(dd, _private_key, _input_charset);
                logger.InfoFormat("Decrypt,之后：{0}",  dr);
                inputPara["notify_data"] = dr;
            }
            catch (Exception exc)
            {
                logger.InfoFormat("DecryptException:{0}", exc.Message);
                throw;
            }

            return inputPara;
        }

        /// <summary>
        /// 异步通知时，对参数做固定排序
        /// </summary>
        /// <param name="dicArrayPre">排序前的参数组</param>
        /// <returns>排序后的参数组</returns>
        private Dictionary<string, string> SortNotifyPara(Dictionary<string, string> dicArrayPre)
        {
            Dictionary<string, string> sPara = new Dictionary<string, string>();
            sPara.Add("service", dicArrayPre["service"]);
            sPara.Add("v", dicArrayPre["v"]);
            sPara.Add("sec_id", dicArrayPre["sec_id"]);
            sPara.Add("notify_data", dicArrayPre["notify_data"]);

            return sPara;
        }

        /// <summary>
        /// 获取返回时的签名验证结果
        /// </summary>
        /// <param name="inputPara">通知返回参数数组</param>
        /// <param name="sign">对比的签名结果</param>
        /// <param name="isSort">是否对待签名数组排序</param>
        /// <returns>签名验证结果</returns>
        private bool GetSignVeryfy(Dictionary<string, string> inputPara, string sign, bool isSort)
        {
            try
            {
                Dictionary<string, string> sPara = new Dictionary<string, string>();

                //过滤空值、sign与sign_type参数
                sPara = Core.FilterPara(inputPara);

                if (isSort)
                {
                    //根据字母a到z的顺序把参数排序
                    sPara = Core.SortPara(sPara);
                }
                else
                {
                    sPara = SortNotifyPara(sPara);
                }

                //获取待签名字符串
                string preSignStr = Core.CreateLinkString(sPara);
                //logger.InfoFormat("preSignStr:{0}", preSignStr);
                //获得签名验证结果
                bool isSgin = false;
                if (!string.IsNullOrEmpty(sign))
                {
                    switch (_sign_type)
                    {
                        case "MD5":
                            isSgin = AlipayMD5.Verify(preSignStr, sign, _key, _input_charset);
                            break;
                        case "RSA":
                            isSgin = RSAFromPkcs8.verify(preSignStr, sign, _public_key, _input_charset);
                            break;
                        case "0001":
                            isSgin = RSAFromPkcs8.verify(preSignStr, sign, _public_key, _input_charset);
                            break;
                        default:
                            break;
                    }
                }

                return isSgin;
            }
            catch (Exception exc)
            {
                logger.ErrorFormat("异常：{0})", exc.Message);
                return false;
                throw;
            }

        }

        /// <summary>
        /// 获取是否是支付宝服务器发来的请求的验证结果
        /// </summary>
        /// <param name="notify_id">通知验证ID</param>
        /// <returns>验证结果</returns>
        private string GetResponseTxt(string notify_id)
        {
            //logger.InfoFormat("partner:{0},notify_id:{1}", _partner, notify_id);
            string veryfy_url = Https_veryfy_url + "partner=" + _partner + "&notify_id=" + notify_id;

            //获取远程服务器ATN结果，验证是否是支付宝服务器发来的请求
            string responseTxt = Get_Http(veryfy_url, 120000);

            return responseTxt;
        }

        /// <summary>
        /// 获取远程服务器ATN结果
        /// </summary>
        /// <param name="strUrl">指定URL路径地址</param>
        /// <param name="timeout">超时时间设置</param>
        /// <returns>服务器ATN结果</returns>
        private string Get_Http(string strUrl, int timeout)
        {
            string strResult;
            try
            {
                HttpWebRequest myReq = (HttpWebRequest)HttpWebRequest.Create(strUrl);
                myReq.Timeout = timeout;
                HttpWebResponse HttpWResp = (HttpWebResponse)myReq.GetResponse();
                Stream myStream = HttpWResp.GetResponseStream();
                StreamReader sr = new StreamReader(myStream, Encoding.Default);
                StringBuilder strBuilder = new StringBuilder();
                while (-1 != sr.Peek())
                {
                    strBuilder.Append(sr.ReadLine());
                }

                strResult = strBuilder.ToString();
            }
            catch (Exception exp)
            {
                strResult = "错误：" + exp.Message;
            }

            return strResult;
        }
    }
}