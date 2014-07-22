﻿/**
 * @description    : 静态分页组件 ue.pager
 * @author         : chenxizhong@4399.net
 * @change details : 2012-12-27 created by czonechan
 * @parameter      : 
 * @details        : api http://t2.s.img4399.com/base/js/plugins/ue.pager/ hostip 192.168.51.203
 */
 (function(){
	/*简易模版函数*/
	function template(tmpl,json){
		if (typeof tmpl !== "string" || typeof json !== "object") return "";
		return tmpl.replace(/\@{([a-zA-Z_0-9\-]*)\}/g, function (all, key) {
			return typeof json[key] !== "undefined" ? json[key] : ""
		});
	}
	
	function ctor(options){
		var defaults = {
			//target : $(),//放置分页的元素
			pagerTarget : $(),
			formTarget : $(),
			first : '<a href="#" class="pager_first pager_item">首页</a>',
			firstDisabled : '<span class="pager_first pager_item">首页</span>',
			last : '<a href="#" class="pager_last pager_item">末页</a>',
			lastDisabled : '<span class="pager_last pager_item">末页</span>',
			
			firstNum : '<a href="#" class="pager_firstnum pager_item">1</a>',
			firstNumDisabled : '<span class="pager_firstnum pager_item">1</span>',
			lastNum : '<a href="#" class="pager_lastnum pager_item">@{pageCount}</a>',
			lastNumDisabled : '<span class="pager_lastnum pager_item">@{pageCount}</span>',
			
			prevMore : '<a href="#" class="pager_prevmore pager_item">...</a>',
			prevMoreDisabled : '<span class="pager_prevmore pager_item">...</span>',
			nextMore : '<a href="#" class="pager_nextmore pager_item">...</a>',
			nextMoreDisabled : '<span class="pager_nextmore pager_item">...</span>',
			prev : '<a href="#" class="pager_prev pager_item">上一页</a>',
			prevDisabled : '<span class="pager_prev pager_item">上一页</span>',
			next : '<a href="#" class="pager_next pager_item">下一页</a>',
			nextDisabled : '<span class="pager_next pager_item">下一页</span>',
			current : '<span class="pager_page pager_item pager_current">@{page}</span>',
			page : '<a href="#" class="pager_page pager_item">@{page}</a>',
			tip : '<span class="pager_item pager_tip">@{nowPage}/@{pageCount}</span>',
			goto : '<form><input class="pager_input"/><input type="submit" value="go" class="pager_goto"/></form>',
			gotobtn : ".pager_goto",
			input : ".pager_input",
			now : 1,//当前页
			maxPage : 5,//显示的最多页数
			per : 5,//每页显示的记录
			count : 0,//记录总计
			more : 5,
			showMore : false,
			showFirstAndLastNum : false,
			onchange : function(){}//切换页数回调函数}
		}
		
		
		this.options = options = $.extend(defaults, options);
		options.total = Math.ceil(options.count / options.per);
		this.init();
	}
	
	ctor.prototype = {
		init : function(){
			var _this = this,
				options = this.options,
				//target = options.target,
				pagerTarget = options.pagerTarget,
				formTarget = options.formTarget,
				now = options.now,
				total = options.total,
				maxPage = options.maxPage,
				end,start,
				$first = $(options.first),
				$firstDisabled = $(options.firstDisabled),
				$last = $(options.last),
				$lastDisabled = $(options.lastDisabled),
				$prev = $(options.prev),
				$prevDisabled = $(options.prevDisabled),
				$next = $(options.next),
				$nextDisabled = $(options.nextDisabled),
				$page = $(options.page),
				$current = $(options.current),
				$goto = $(options.goto),
				$prevMore = $(options.prevMore),
				$prevMoreDisabled = $(options.prevMoreDisabled),
				$nextMore = $(options.nextMore),
				$nextMoreDisabled = $(options.nextMoreDisabled),
				$firstNum = $(options.firstNum),
				$firstNumDisabled = $(options.firstNumDisabled),
				$lastNum = $(options.lastNum),
				$lastNumDisabled = $(options.lastNumDisabled),
				$temp;
			
			formTarget.html("");
			pagerTarget.html("");
			if(total <= 1) {
				return false;
			}
			
			if (now >= (maxPage -1)){
				end = now + 2;
			} else {
				end = maxPage;
			}
			
			if (end > total){
				end = total;
			}
			
			start = end - (maxPage -1);
			
			if (start < 1){
				start = 1;
			}
			
			if (options.showFirstAndLastNum){
				
				if(now == 1){
					pagerTarget.append($prevDisabled.clone());
				}else{
					pagerTarget.append($prev.clone().attr("data-page", now - 1));
				}
				
				if (start == 1){
					pagerTarget.append($firstNumDisabled.clone());
				} else {
					pagerTarget.append($firstNum.clone().attr("data-page", 1));
				}
				
			} else {
				if(now == 1){
					pagerTarget.append($firstDisabled.clone());
					pagerTarget.append($prevDisabled.clone());
				}else{
					pagerTarget.append($first.clone().attr("data-page", 1));
					pagerTarget.append($prev.clone().attr("data-page", now - 1));
				}
			}
			
			if (options.showMore){
				if (start - 1 >= 1){ 
					$temp = $prevMore.clone().attr("data-page", start - 1);
					pagerTarget.append($temp);
				} else {
					pagerTarget.append($prevMoreDisabled.clone());
				}
			}
			
			for(var i = start; i <= end; i++){
				if(now == i){
					$temp = $current.clone();
					$temp.html(template($temp.html(), {page : i}));
					pagerTarget.append($temp);
				}else{
					$temp = $page.clone().attr("data-page", i);
					$temp.html(template($temp.html(), {page : i}));
					pagerTarget.append($temp);
				}
			}
			
			if (options.showMore){
				if (end + 1 <= total){
					$temp = $nextMore.clone().attr("data-page", end + 1);
					pagerTarget.append($temp);
				} else {
					pagerTarget.append($nextMoreDisabled.clone());
				}
			}
			
			if (options.showFirstAndLastNum){
				
				if (end < total){
					$temp = $lastNum.clone();
					$temp.html(template($temp.html(), {pageCount : total})).attr("data-page", total);
					pagerTarget.append($temp);
				} else {
					$temp = $lastNumDisabled.clone();
					$temp.html(template($temp.html(), {pageCount : total})).attr("data-page", total);
					pagerTarget.append($temp);
				}
				
				if(now < total){
					pagerTarget.append($next.clone().attr("data-page", now + 1));
				}else{
					pagerTarget.append($nextDisabled.clone());
				}
				
			} else {
				
				if(now == total){
					$temp = $lastDisabled.clone();
					$temp.html(template($temp.html(), {pageCount : total})).attr("data-page", total);

					pagerTarget.append($nextDisabled.clone());
					pagerTarget.append($temp);
				}else{
					$temp = $last.clone();
					$temp.html(template($temp.html(), {pageCount : total})).attr("data-page", total);

					pagerTarget.append($next.clone().attr("data-page", now + 1));
					pagerTarget.append($temp);
				}
			}
			
			pagerTarget.append(template(options.tip, {nowPage : now, pageCount : total, count : options.count}));
			formTarget.append($goto);
			
			pagerTarget.find("a").bind("click", function(){
				var p = parseInt($(this).attr("data-page"));
				if (isNaN(p)){
					p = parseInt($(this).parents("[data-page]").attr("data-page"));
				}
				options.onchange.call(_this, p);
				return false;
			})
			
			formTarget.find("form").submit = function(){alert(1);return false};
			formTarget.find(options.gotobtn).bind("click", function(){
				alert(2);
				var p = parseInt(formTarget.find(options.input).val());
				if (p < 1 || p > total || isNaN(p)){return false};
				options.onchange.call(_this, p);
				return false;
			})
		}
	}
	
	
	window.ue = window.ue || {};

	ue.pager = function(options){
		return new ctor(options);
	}
})();