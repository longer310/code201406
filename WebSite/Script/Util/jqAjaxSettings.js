var utility={};
utility.ajax={};
utility.ajax.begin = function()
{
    /// <summary>进度条启动</summary>
    if(document.body)
    {
		var id = "processbar_span";
        var t_span = document.getElementById(id);
        if(!t_span)
        {
            var t_span = document.createElement("span");
	        t_span.id = id;
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
        else
        {
            t_span.style.display = "";
	        t_span.style.top = document.body.scrollTop + 10;
        }
    }
}

utility.ajax.end = function()
{
    /// <summary>进度条关闭</summary>
	var temp = document.getElementById("processbar_span");
    if(temp)
    {
	    temp.style.display="none";
	}
}

/*jq*/
if(jQuery)
{
	 jQuery.ajaxSetup({
	 beforeSend:utility.ajax.begin,
	 complete:utility.ajax.end
	 }); 
}