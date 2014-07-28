<%@ Page Title="" Language="C#" MasterPageFile="~/View/merchant.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Backstage.View.Active.List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div class="widget-box">
        <div class="widget-title">
            <span class="icon">
                <i class="icon-gift"></i>
            </span>
            <h5>活动列表</h5>
            <div class="buttons">
                <a href="#" class="btn btn-primary btn-mini" id="j-btn-selectAll"><i class="icon-check icon-white"></i>全选</a>
                <a href="#" class="btn btn-danger btn-mini" id="j-btn-delSelected"><i class="icon-remove icon-white"></i>删除</a>
            </div>
        </div>
        <div class="widget-content">
            <div class="list-2col">
                <ul class="list-in" id="j-activity-list">
                </ul>
            </div>
        </div>

        <div class="widget-footer">
            <div class="pagination alternate" id="j-activity-pagination">
                <ul class="page-main">
                    <li class="disabled"><a href="#">首页</a></li>
                    <li class="disabled"><a href="#">上一页</a></li>
                    <li class="active">
                        <a href="#">1</a>
                    </li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">下一页</a></li>
                    <li><a href="#">末页</a></li>
                    <li class="page-info"><b class="text-info">1</b>/8页 共<b class="text-info">18</b>条记录</li>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Footer" runat="server">
    <script type="text/javascript">
        var sellerid = '<%=sellerid%>' ;
    </script>
    <!--活动列表模版-->
    <script type="text/jquery-tmpl-x" id="j-tmpl-activity-listitem">
        	{{each(i, v) list}}
	        	<li class="item" data-id="1">
					<div class="item-in">
						<div class="article-thumb">
							<img alt="User" src="http://placehold.it/128x128" />
						</div>
						<div class="article-post">
							<span class="post-title">${title}</span>
							<p class="post-desc">
								${description}
							</p>
							<p class="post-meta">
								<span class="pull-left">浏览：<span class="text-error">${views}</span> 
								评论：<span class="text-error">${commentnum}</span>条</span> 
								发布时间：<span class="text-error">${createtime.Format("yyyy-MM-dd HH:mm:ss")}</span> 
							</p>
							<div class="post-action">
								<div class="checker"><span><input type="checkbox" name="radios"></span></div>
								<span class="label label-warning pull-left">电子券</span>
								<a href="activity_edit.html?id=1" class="btn btn-primary btn-mini"><i class="icon-pencil icon-white"></i> 编辑</a>
								<a href="#" class="btn btn-danger btn-mini j-btn-del"><i class="icon-remove icon-white"></i> 删除</a>
							</div>
						</div>
					</div>
				</li>
			{{/each}}
        </script>
    <script type="text/javascript" src="../../script/view/active/list.js"></script>
</asp:Content>
