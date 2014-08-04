
var Utility = {
/// <summary>JS公共类</summary>
};

Utility.StringBuffer = function () {
    /// <summary>
    /// StringBuffer类
    /// </summary>
    /// <returns>StringBuffer对象</returns>
    this._string = new Array();
    if (arguments.length > 0) {
        Array.prototype.push.apply(this._string, arguments);
    }
}

Utility.StringBuffer.prototype.Append = function () {
    /// <summary>
    /// StringBuffer类Append方法，支持多个添加
    /// </summary>
    if (arguments.length > 0) {
        Array.prototype.push.apply(this._string, arguments);
    }
}

Utility.StringBuffer.prototype.AppendFormat = function () {
    /// <summary>
    /// StringBuffer类AppendFormat方法
    /// </summary>
    var str = arguments[0];
    var reg = /\{\d+\}/g;
    var strReg = str.match(reg);
    var index;
    for (var i = 0; i < strReg.length; i++) {
        index = parseInt(strReg[i].substring(1, strReg[i].length - 1));
        str = str.replace(strReg[i], arguments[index + 1]);
    }
    this._string.push(str);
}

Utility.StringBuffer.prototype.ToString = function () {
    ///<summary>StringBuffer类ToString方法</summary>
    return this._string.join("");
}
Utility.StringBuffer.prototype.toString = function () {
    return this.ToString();
}

Utility.Process = {};
Utility.Process.Begin = function () {
    /// <summary>进度条启动</summary>
    if (document.body) {
        var t_span = document.getElementById("processbar_div");
        if (!t_span) {
            var t_span = document.createElement("span");
            t_span.id = "processbar_div";
            t_span.style.position = "absolute";
            t_span.style.backgroundColor = "#ffffba";
            t_span.style.border = "solid 1px #9db3c5";
            t_span.style.right = "25px";
            t_span.style.top = "10px";
            t_span.style.zIndex = 1000;
            t_span.style.fontSize = "12px";
            t_span.style.padding = "2px";
            t_span.innerHTML = "&nbsp;数据加载中...&nbsp;&nbsp;";
            document.body.appendChild(t_span);
        }
        else {
            t_span.style.display = "";
            t_span.style.top = document.body.scrollTop + 10;
        }
    }
}

Utility.Process.End = function () {
    /// <summary>进度条关闭</summary>
    if (document.getElementById("processbar_div")) {
        document.getElementById("processbar_div").style.display = "none";
    }
}

Utility.QueryString = function (key) {
    /// <summary>获取URL中GET参数值</summary>
    //    var search = location.search;
    //    if(search.indexOf("?") == 0)
    //    {
    //        search = search.substring(1);
    //    }
    //    var split = search.split("&");
    //    var reg;
    //    for(var i = 0; i < split.length; i++)
    //    {
    //        if(split[i].indexOf(key + "=") == 0)
    //        {
    //            return unescape(split[i].substring(key.length + 1));
    //        }
    //    }
    //    
    //    return "";
    var svalue = location.search.match(new RegExp("[\?\&]" + key + "=([^\&]*)(\&?)", "i"));
    return svalue ? svalue[1] : "";
}

///String原型
String.prototype.NoHarmCode = function () {
    /// <summary>过滤&号和+号</summary>
    return this.replace(/&/g, "%26").replace(/\+/g, "%2b");
}

String.prototype.Trim = function () {
    /// <summary>删除字符串首尾空格</summary>
    return this.replace(/^\s*|\s*$/g, "");
}

//by yzy 删除前后指定的字符串
String.prototype.Trim = function (charlist) {
    var charlist = charlist || '';
    if (charlist == '') {
        return this.replace(/(^\s*)|(\s*$)/g, "");
    } else {
        var reg = '/(^\\' + charlist + '*)|(\\' + charlist + '*$)/g';
        return this.replace(eval(reg), "");
    }
} 

String.prototype.Format = function () {
    /// <summary>Format方法</summary>
    var str = this;
    var reg = /\{\d+\}/g;
    var strReg = str.match(reg);
    var index;
    for (var i = 0; i < strReg.length; i++) {
        index = parseInt(strReg[i].substring(1, strReg[i].length - 1));
        str = str.replace(strReg[i], arguments[index]);
    }

    return str;
}
String.prototype.HTMLEncode = function () {
    /// <summary></summary>
    return this.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}
String.prototype.HTMLEncode = function () {
    /// <summary></summary>
    return this.replace(/&amp;/g, "&").replace(/&quot;/g, "\"").replace(/&lt;/g, "<").replace(/&gt;/g, ">");
}
Number.prototype.ToString = function (len) {
    //将数字转换成字符串，如果指定len且转换后长度不满，则在字符串前面补0
    var tmp = this.toString();
    if (len == undefined || isNaN(len)) {
        return tmp;
    }

    if (typeof (len) != "number") {
        len = parseInt(len);
    }

    while (tmp.length < len) {
        tmp = "0" + tmp;
    }

    return tmp;
}
String.prototype.ToDate = function () {
    var date = new Date(parseInt(this.replace("/Date(", "").replace(")/", ""), 10));
    return date;
}

Date.prototype.Format = function (format) {
    /*
    * eg:format="YYYY-MM-dd hh:mm:ss";
    */
    var o = {
        "M+": this.getMonth() + 1,  //month
        "d+": this.getDate(),     //day
        "h+": this.getHours(),    //hour
        "m+": this.getMinutes(),  //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter
        "S": this.getMilliseconds() //millisecond
    }

    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }

    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}