using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Backstage.Core
{
    public class CryptHelper
    {
        #region 密钥
        /// <summary>
        /// 密钥
        /// </summary>
        public static string Key
        {
            get
            {
                //des 支持8位加密
                return "Sh%d7#;w";
            }
        }
        #endregion

        #region  MD5加密
        /// <summary>
        /// 标准MD5加密
        /// </summary>
        /// <param Name="source">待加密字符串</param>
        /// <param Name="addKey">附加字符串</param>
        /// <param Name="encoding">编码方式</param>
        /// <returns></returns>
        public static string MD5_Encrypt(string source, string addKey, Encoding encoding)
        {
            if (addKey.Length > 0)
            {
                source = source + addKey;
            }

            MD5 MD5 = new MD5CryptoServiceProvider();
            byte[] datSource = encoding.GetBytes(source);
            byte[] newSource = MD5.ComputeHash(datSource);
            string byte2String = null;
            for (int i = 0; i < newSource.Length; i++)
            {
                string thisByte = newSource[i].ToString("x");
                if (thisByte.Length == 1) thisByte = "0" + thisByte;
                byte2String += thisByte;
            }
            return byte2String;
        }

        /// <summary>
        /// 标准MD5加密
        /// </summary>
        /// <param Name="source">待加密字符串</param>
        /// <param Name="encoding">编码方式</param>
        /// <returns></returns>
        public static string MD5_Encrypt(string source, string encoding)
        {
            return MD5_Encrypt(source, string.Empty, Encoding.GetEncoding(encoding));
        }
        /// <summary>
        /// 标准MD5加密
        /// </summary>
        /// <param Name="source">被加密的字符串</param>
        /// <returns></returns>
        public static string MD5_Encrypt(string source)
        {
            return MD5_Encrypt(source, string.Empty, Encoding.UTF8);
        }
        public static byte[] MD5_Encrypt(byte[] source)
        {
            MD5 MD5 = new MD5CryptoServiceProvider();
            byte[] datSource = source;
            return MD5.ComputeHash(datSource);
        }

        #endregion

        #region  DES 加解密

        public static string DES_Encrypt(string source)
        {
            return DES_Encrypt(source, Key);
        }

        /// <summary>
        /// Desc加密
        /// </summary>
        /// <param Name="source">待加密字符</param>
        /// <param Name="queuekey">密钥</param>
        /// <returns>string</returns>
        public static string DES_Encrypt(string source, string key)
        {
            return DES_Encrypt(source, key, Encoding.UTF8);
        }

        /// <summary>
        /// Desc加密
        /// </summary>
        /// <param Name="source">待加密字符</param>
        /// <param Name="queuekey">密钥</param>
        /// <returns>string</returns>
        public static string DES_Encrypt(string source, string key, Encoding encoding)
        {
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();

            //把字符串放到byte数组中  
            byte[] inputByteArray = Encoding.Default.GetBytes(source);

            //建立加密对象的密钥和偏移量  
            //原文使用ASCIIEncoding.ASCII方法的GetBytes方法  
            //使得输入密码必须输入英文文本  
            des.Key = encoding.GetBytes(key);
            des.IV = encoding.GetBytes(key);

            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write);

            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();

            StringBuilder ret = new StringBuilder();
            foreach (byte b in ms.ToArray())
            {
                ret.AppendFormat("{0:X2}", b);
            }

            ret.ToString();
            return ret.ToString();
        }

        /// <summary>
        /// Desc解密
        /// </summary>
        /// <param Name="source">待解密的字符串</param>
        /// <returns>解密后的字符串</returns>
        public static string DES_Decrypt(string source)
        {
            return DES_Decrypt(source, Key);
        }

        public static string DES_Decrypt(string source, string key)
        {
            return DES_Decrypt(source, key, Encoding.Default);
        }
        /// <summary>
        /// Desc解密
        /// </summary>
        /// <param Name="source">待解密的字符串</param>
        /// <returns>解密后的字符串</returns>
        public static string DES_Decrypt(string source, string key, Encoding encoding)
        {
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();

            //将字符串转为字节数组  
            byte[] inputByteArray = new byte[source.Length / 2];
            for (int x = 0; x < source.Length / 2; x++)
            {
                int i = (Convert.ToInt32(source.Substring(x * 2, 2), 16));
                inputByteArray[x] = (byte)i;
            }

            //建立加密对象的密钥和偏移量，此值重要，不能修改  
            des.Key = encoding.GetBytes(key);
            des.IV = encoding.GetBytes(key);

            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);
            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();

            //建立StringBuild对象，CreateDecrypt使用的是流对象，必须把解密后的文本变成流对象  
            StringBuilder ret = new StringBuilder();

            return System.Text.Encoding.Default.GetString(ms.ToArray());
        }
        #endregion

        #region SHA1加密

        /// <summary>
        /// SHA1加密，等效于 PHP 的 SHA1() 代码
        /// </summary>
        /// <param Name="source">被加密的字符串</param>
        /// <returns>加密后的字符串</returns>
        public static string SHA1_Encrypt(string source)
        {
            byte[] temp1 = Encoding.UTF8.GetBytes(source);

            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();
            byte[] temp2 = sha.ComputeHash(temp1);
            sha.Clear();

            //注意，不能用这个
            //string output = Convert.ToBase64String(temp2); 

            string output = BitConverter.ToString(temp2);
            output = output.Replace("-", "");
            output = output.ToLower();
            return output;
        }
        #endregion
    }
}