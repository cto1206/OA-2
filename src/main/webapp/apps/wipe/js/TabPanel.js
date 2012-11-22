TabPanel = function(_) {
	this.renderTo = _.renderTo || $(document.body);
	this.width = _.width || "750px";
	this.height = _.height || "700px";
	this.border = _.border;
	this.items = _.items;
	this.active = _.active || 0;
	this.tabs = new Array();
	this.render = typeof this.renderTo == "string"
			? $("#" + this.renderTo)
			: this.renderTo;
	this.scrolled = false;
	this.tabWidth = 100 + 4;
	this.fixNum = 6;
	this.scrollFinish = true;
	this.maxLength = _.maxLength || -1;
	this.init()
};
TabPanel.prototype = {
	init : function() {
		var A = this;
		this.tabpanel = $(document.createElement("DIV"));
		this.tabpanel.appendTo(this.render);
		this.tabpanel_tab_content = $(document.createElement("DIV"));
		this.tabpanel_tab_content.addClass("tabpanel_tab_content");
		this.tabpanel_tab_content.appendTo(this.tabpanel);
		this.tabpanel_left_scroll = $(document.createElement("DIV"));
		this.tabpanel_left_scroll.bind("click", function() {
					A.moveLeft()
				});
		this.tabpanel_left_scroll.addClass("tabpanel_left_scroll");
		this.tabpanel_left_scroll.addClass("display_none");
		this.tabpanel_left_scroll.bind("mouseover", function() {
					var _ = $(this);
					_.addClass("tabpanel_scroll_over");
					_.bind("mouseout", function() {
								_.unbind("mouseout");
								_.removeClass("tabpanel_scroll_over")
							})
				});
		this.tabpanel_left_scroll.appendTo(this.tabpanel_tab_content);
		this.tabpanel_right_scroll = $(document.createElement("DIV"));
		this.tabpanel_right_scroll.bind("click", function() {
					A.moveRight()
				});
		this.tabpanel_right_scroll.addClass("tabpanel_right_scroll");
		this.tabpanel_right_scroll.addClass("display_none");
		this.tabpanel_right_scroll.bind("mouseover", function() {
					var _ = $(this);
					_.addClass("tabpanel_scroll_over");
					_.bind("mouseout", function() {
								_.unbind("mouseout");
								_.removeClass("tabpanel_scroll_over")
							})
				});
		this.tabpanel_right_scroll.appendTo(this.tabpanel_tab_content);
		this.tabpanel_move_content = $(document.createElement("DIV"));
		this.tabpanel_move_content.addClass("tabpanel_move_content");
		this.tabpanel_move_content.appendTo(this.tabpanel_tab_content);
		this.tabpanel_mover = $(document.createElement("UL"));
		this.tabpanel_mover.addClass("tabpanel_mover");
		this.tabpanel_mover.appendTo(this.tabpanel_move_content);
		this.tabpanel_tab_spacer = $(document.createElement("DIV"));
		this.tabpanel_tab_spacer.addClass("tabpanel_tab_spacer");
		this.tabpanel_tab_spacer.appendTo(this.tabpanel_tab_content);
		this.tabpanel_content = $(document.createElement("DIV"));
		this.tabpanel_content.addClass("tabpanel_content");
		this.tabpanel_content.appendTo(this.tabpanel);
		this.tabpanel_content.css("height", this.height);
		if (this.render.is("body"))
			this.tabpanel.css("width", this.width);
		else
			this.render.css("width", this.width);
		if (this.border == "none") {
			this.tabpanel_tab_content.css("border-top", "none");
			this.tabpanel_tab_content.css("border-left", "none");
			this.tabpanel_tab_content.css("border-right", "none");
			this.tabpanel_content.css("border-left", "none");
			this.tabpanel_content.css("border-right", "none");
			this.tabpanel_content.css("border-bottom", "none");
			this.tabpanel_tab_content.css("width", (this.tabpanel_tab_content
							.get(0).offsetWidth)
							+ "px");
			this.tabpanel_content.css("width", (this.tabpanel_tab_content
							.get(0).offsetWidth)
							+ "px")
		} else {
			this.tabpanel_tab_content.css("width", (this.tabpanel_tab_content
							.get(0).offsetWidth - 4)
							+ "px");
			this.tabpanel_content.css("width", (this.tabpanel_tab_content
							.get(0).offsetWidth - 2)
							+ "px")
		}
		this.update();
		for (var _ = 0; _ < this.items.length; _++)
			this.addTab(this.items[_]);
		this.show(this.active)
	},
	moveLeft : function() {
		if (this.scrollFinish) {
			this.disableScroll();
			this.scrollFinish = false;
			Fader.apply(this, new Array({
								element : this.tabpanel_mover,
								style : "marginLeft",
								num : 100,
								maxMove : this.maxMove,
								interval : 1,
								onFinish : this.useableScroll
							}));
			this.run()
		}
	},
	moveRight : function() {
		if (this.scrollFinish) {
			this.disableScroll();
			this.scrollFinish = false;
			Fader.apply(this, new Array({
								element : this.tabpanel_mover,
								style : "marginLeft",
								num : -100,
								maxMove : this.maxMove,
								interval : 1,
								onFinish : this.useableScroll
							}));
			this.run()
		}
	},
	moveToLeft : function() {
		if (!this.scrolled && this.scrollFinish) {
			this.disableScroll();
			this.scrollFinish = false;
			var $ = parseInt(this.tabpanel_mover.css("marginLeft")) * -1;
			Fader.apply(this, new Array({
								element : this.tabpanel_mover,
								style : "marginLeft",
								num : $,
								maxMove : this.maxMove,
								interval : 1,
								onFinish : this.useableScroll
							}));
			this.run()
		}
	},
	moveToRight : function() {
		if (this.scrolled && this.scrollFinish) {
			this.disableScroll();
			this.scrollFinish = false;
			var A = parseInt(this.tabpanel_mover.css("marginLeft")) * -1, _ = this.tabpanel_mover
					.children().length
					* this.tabWidth, B = this.tabpanel_move_content.width(), $ = (_
					- B - A + this.fixNum)
					* -1;
			Fader.apply(this, new Array({
								element : this.tabpanel_mover,
								style : "marginLeft",
								num : $,
								maxMove : this.maxMove,
								interval : 1,
								onFinish : this.useableScroll
							}));
			this.run()
		}
	},
	moveToSee : function(_) {
		if (this.scrolled) {
			var B = this.tabWidth * _, A = parseInt(this.tabpanel_mover
					.css("marginLeft")), $;
			if (A <= 0) {
				$ = (A + B) * -1;
				if ((($ + A) * -1) >= this.maxMove)
					this.moveToRight();
				else {
					this.disableScroll();
					this.scrollFinish = false;
					Fader.apply(this, new Array({
										element : this.tabpanel_mover,
										style : "marginLeft",
										num : $,
										maxMove : this.maxMove,
										interval : 1,
										onFinish : this.useableScroll
									}));
					this.run()
				}
			} else {
				$ = (B - A) * -1;
				if (($ * -1) >= this.maxMove)
					this.moveToRight();
				else {
					this.disableScroll();
					this.scrollFinish = false;
					Fader.apply(this, new Array({
										element : this.tabpanel_mover,
										style : "marginLeft",
										num : $,
										maxMove : this.maxMove,
										interval : 1,
										onFinish : this.useableScroll
									}));
					this.run()
				}
			}
		}
	},
	disableScroll : function() {
		this.tabpanel_left_scroll.addClass("tabpanel_left_scroll_disabled");
		this.tabpanel_left_scroll.attr("disabled", true);
		this.tabpanel_right_scroll.addClass("tabpanel_right_scroll_disabled");
		this.tabpanel_right_scroll.attr("disabled", true)
	},
	useableScroll : function() {
		var $ = this;
		if (this.scrolled)
			if (parseInt($.tabpanel_mover.css("marginLeft")) == 0) {
				$.tabpanel_left_scroll
						.addClass("tabpanel_left_scroll_disabled");
				$.tabpanel_left_scroll.attr("disabled", true);
				$.tabpanel_right_scroll
						.removeClass("tabpanel_right_scroll_disabled");
				$.tabpanel_right_scroll.removeAttr("disabled")
			} else if (parseInt($.tabpanel_mover.css("marginLeft")) * -1 == $.maxMove) {
				$.tabpanel_left_scroll
						.removeClass("tabpanel_left_scroll_disabled");
				$.tabpanel_left_scroll.removeAttr("disabled", true);
				$.tabpanel_right_scroll
						.addClass("tabpanel_right_scroll_disabled");
				$.tabpanel_right_scroll.attr("disabled")
			} else {
				$.tabpanel_left_scroll
						.removeClass("tabpanel_left_scroll_disabled");
				$.tabpanel_left_scroll.removeAttr("disabled", true);
				$.tabpanel_right_scroll
						.removeClass("tabpanel_right_scroll_disabled");
				$.tabpanel_right_scroll.removeAttr("disabled")
			}
		$.scrollFinish = true
	},
	update : function() {
		var $ = this.tabpanel_tab_content.width();
		if (this.scrolled)
			$ -= (this.tabpanel_left_scroll.width() + this.tabpanel_right_scroll
					.width());
		this.tabpanel_move_content.css("width", $ + "px");
		this.maxMove = (this.tabpanel_mover.children().length * this.tabWidth)
				- $ + this.fixNum
	},
	showScroll : function() {
		var $ = this.tabpanel_mover.children().length * this.tabWidth, _ = this.tabpanel_tab_content
				.width();
		if ($ > _ && !this.scrolled) {
			this.tabpanel_move_content.addClass("tabpanel_move_content_scroll");
			this.tabpanel_left_scroll.removeClass("display_none");
			this.tabpanel_right_scroll.removeClass("display_none");
			this.scrolled = true
		} else if ($ < _ && this.scrolled) {
			this.tabpanel_move_content
					.removeClass("tabpanel_move_content_scroll");
			this.tabpanel_left_scroll.addClass("display_none");
			this.tabpanel_right_scroll.addClass("display_none");
			this.scrolled = false;
			this.moveToLeft()
		}
	},
	addTab : function(D) {
		if (this.maxLength != -1 && this.maxLength <= this.tabs.length) {
			alert("\u8d85\u8fc7\u4e86\u6700\u5927\u9009\u9879\u5361\u6570\u91cf\uff0c\u8bf7\u5173\u95ed\u4e0d\u7528\u7684\u9009\u9879\u5361");
			return false
		}
		D.id = D.id || Math.uuid();
		if ($("#" + D.id).length > 0)
			this.show(D.id);
		else if (this.scrollFinish) {
			var C = this, F = $(document.createElement("LI"));
			F.attr("id", D.id);
			F.appendTo(this.tabpanel_mover);
			var B = $(document.createElement("DIV"));
			B.addClass("title");
			B.text(D.title);
			B.appendTo(F);
			var A = $(document.createElement("DIV"));
			//A.addClass("closer");
			A.appendTo(F);
			var E = $(document.createElement("DIV"));
			E.addClass("html_content");
			E.html(D.html);
			E.appendTo(this.tabpanel_content);
			E.css("z-index", this.getMaxZindex() + 1);
			var G = E.find("iframe"), _ = this.tabpanel_mover.children()
					.index(this.tabpanel_mover.find(".active")[0]);
			if (_ < 0)
				_ = 0;
			if (this.tabs.length > _)
				D.preTabId = this.tabs[_].id;
			else
				D.preTabId = "";
			D.tab = F;
			D.title = B;
			D.closer = A;
			D.content = E;
			D.disable = D.disable == undefined ? false : D.disable;
			D.closable = D.closable == undefined ? true : D.closable;
			if (D.closable == false)
				A.addClass("display_none");
			this.tabs.push(D);
			F.bind("click", function($) {
						return function() {
							C.show($, true)
						}
					}(this.tabs.length - 1));
			A.bind("click", function($) {
						return function() {
							C.kill($)
						}
					}(this.tabs.length - 1));
			if (D.closable)
				F.bind("dblclick", function($) {
							return function() {
								C.kill($)
							}
						}(this.tabs.length - 1));
			this.show(this.tabs.length - 1, true);
			this.showScroll();
			this.update();
			this.moveToRight()
		}
	},
	getTabPosision : function(_) {
		if (typeof _ == "string")
			for (var $ = 0; $ < this.tabs.length; $++)
				if (_ == this.tabs[$].id) {
					_ = $;
					break
				}
		return _
	},
	flush : function($) {
		$ = this.getTabPosision($);
		if (typeof $ == "string")
			return false;
		else {
			var A = this.tabs[$].content.find("iframe");
			if (A.length > 0) {
				var _ = this.tabs[$].id + "Frame";
				this.iterateFlush(window.frames[_])
			}
		}
	},
	iterateFlush : function(_) {
		if (_.window.frames.length > 0) {
			for (var $ = 0; $ < _.window.frames.length; $++)
				this.iterateFlush(_.window.frames[$])
		} else if (_.document.forms.length > 0) {
			for ($ = 0; $ < _.document.forms.length; $++) {
				try {
					_.document.forms[$].submit()
				} catch (A) {
					_.location.reload()
				}
			}
		} else
			_.location.reload()
	},
	show : function($, _) {
		$ = this.getTabPosision($);
		if (typeof $ == "string")
			$ = 0;
		if (this.tabs.length < 1)
			return false;
		if (this.scrollFinish) {
			if ($ >= this.tabs.length)
				$ = 0;
			if (this.tabs[$].tab.hasClass("active")) {
				if (!_)
					this.moveToSee($)
			} else {
				this.tabpanel_mover.find(".active").removeClass("active");
				this.tabs[$].tab.addClass("active");
				this.tabs[$].content.css("z-index", this.getMaxZindex() + 1);
				if (!_)
					this.moveToSee($)
			}
		}
	},
	kill : function(A) {
		var _ = this;
		A = this.getTabPosision(A);
		var B = this.tabs[A].preTabId;
		this.tabs[A].closer.remove();
		this.tabs[A].title.remove();
		this.tabs[A].tab.remove();
		this.tabs[A].content.remove();
		this.tabs.splice(A, 1);
		for (var $ = 0; $ < this.tabs.length; $++) {
			this.tabs[$].tab.unbind("click");
			this.tabs[$].tab.bind("click", function($) {
						return function() {
							_.show($)
						}
					}($));
			this.tabs[$].closer.unbind("click");
			this.tabs[$].closer.bind("click", function($) {
						return function() {
							_.kill($)
						}
					}($));
			if (this.tabs[$].closable) {
				this.tabs[$].tab.unbind("dblclick");
				this.tabs[$].tab.bind("dblclick", function($) {
							return function() {
								_.kill($)
							}
						}($))
			}
		}
		if (this.getActiveTab() == null)
			this.show(B);
		else
			this.moveToSee(A);
		this.update();
		this.showScroll()
	},
	getTabsCount : function() {
		return this.tabs.length
	},
	setTitle : function(_, $) {
		if (_ < this.tabs.length)
			this.tabs[_].title.text($)
	},
	getTitle : function($) {
		return this.tabs[$].title.text()
	},
	setContent : function($, _) {
		if ($ < this.tabs.length)
			this.tabs[$].content.html(_)
	},
	getContent : function($) {
		return this.tabs[$].content.html()
	},
	setDisable : function($, _) {
		if ($ < this.tabs.length) {
			this.tabs[$].disable = _;
			if (_) {
				this.tabs[$].tab.attr("disabled", true);
				this.tabs[$].title.addClass(".disabled")
			} else {
				this.tabs[$].tab.removeAttr("disabled");
				this.tabs[$].title.removeClass(".disabled")
			}
		}
	},
	getDisable : function($) {
		return this.tabs[$].disable
	},
	setClosable : function(_, $) {
		if (_ < this.tabs.length) {
			this.tabs[_].closable = $;
			if ($)
				this.tabs[_].closer.addClass("display_none");
			else {
				this.tabs[_].closer.addClass("closer");
				this.tabs[_].closer.removeClass("display_none")
			}
		}
	},
	getClosable : function($) {
		return this.tabs[$].closable
	},
	getActiveTab : function() {
		var $ = this.tabpanel_mover.children().index(this.tabpanel_mover
				.find(".active")[0]);
		if (this.tabs.length > $ && $ > 0)
			return this.tabs[$];
		else
			return null
	},
	getMaxZindex : function() {
		var _ = 1;
		this.tabpanel_content.find(".html_content").each(function(A) {
					var B = parseInt($(this).css("z-index"));
					if (B > _)
						_ = B
				});
		return _
	}
}