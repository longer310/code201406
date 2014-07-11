/*
Navicat MySQL Data Transfer

Source Server         : yuanc_myweb
Source Server Version : 50096
Source Host           : 182.254.137.180:3306
Source Database       : myweb

Target Server Type    : MYSQL
Target Server Version : 50096
File Encoding         : 65001

Date: 2014-07-11 18:14:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `Id` int(11) NOT NULL auto_increment COMMENT '主键id',
  `UserName` varchar(100) default '' COMMENT '昵称',
  `Pwd` varchar(100) default '' COMMENT '密码（无加密）',
  `RoleType` int(11) default '1' COMMENT '角色类型',
  `Avatar` varchar(100) default '' COMMENT '头像地址',
  `Sex` int(4) default '0' COMMENT '0:男性，1：女性',
  `CreateTime` datetime default NULL COMMENT '创建或修改时间',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('1', 'admin', '111', '1', 'http://182.254.137.180/bg/images/head/user.png', '0', '2014-07-06 18:27:21');
INSERT INTO `account` VALUES ('2', '11111', 'sfdfsdf', '2', 'http://182.254.137.180/bg/images/head/user.png', '0', '2014-07-06 18:27:32');
INSERT INTO `account` VALUES ('3', 'user1', '111', '20', 'http://182.254.137.180/bg/images/head/user.png', '0', '2014-07-06 18:27:37');
INSERT INTO `account` VALUES ('4', 'user2', '111', '20', 'http://182.254.137.180/bg/images/head/user.png', '0', '2014-07-06 18:27:37');
INSERT INTO `account` VALUES ('5', 'user3', '111', '20', 'http://182.254.137.180/bg/images/head/user.png', '0', '2014-07-06 18:27:37');
INSERT INTO `account` VALUES ('100', 'merchant', '111', '10', 'http://182.254.137.180/bg/images/head/user.png', '0', '2014-07-06 18:27:37');

-- ----------------------------
-- Table structure for active
-- ----------------------------
DROP TABLE IF EXISTS `active`;
CREATE TABLE `active` (
  `Id` int(20) NOT NULL auto_increment,
  `SellerId` int(20) NOT NULL,
  `CoverImgId` int(20) NOT NULL,
  `Title` varchar(100) collate utf8_unicode_ci default NULL COMMENT '活动标题',
  `Summary` varchar(1000) collate utf8_unicode_ci default NULL COMMENT '活动描述',
  `CreateTime` datetime NOT NULL,
  `CoverImgUrl` varchar(1000) collate utf8_unicode_ci default NULL COMMENT '封面url，冗余',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of active
-- ----------------------------
INSERT INTO `active` VALUES ('1', '100', '1', '资讯测试', '资讯测试', '2014-07-09 00:28:21', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `Id` int(11) NOT NULL auto_increment,
  `SellerId` int(11) NOT NULL,
  `Type` int(11) NOT NULL COMMENT '枚举评论类型:1、图片，2、咨询，3、产品、4、优惠券',
  `TypeId` int(11) NOT NULL COMMENT '对应的Id，比如图片Id',
  `Content` varchar(1000) collate utf8_unicode_ci NOT NULL COMMENT '评论内容',
  `UserId` int(11) NOT NULL,
  `CreateTime` datetime NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', '100', '3', '1', '难吃呀', '3', '2014-07-07 23:35:41');
INSERT INTO `comment` VALUES ('2', '100', '3', '1', '好吃呀', '4', '2014-07-07 23:35:45');
INSERT INTO `comment` VALUES ('3', '100', '3', '1', '好好吃哦', '5', '2014-07-08 23:35:41');
INSERT INTO `comment` VALUES ('4', '100', '1', '1', '不错', '3', '2014-07-08 23:55:27');
INSERT INTO `comment` VALUES ('5', '100', '2', '1', '不错', '3', '2014-07-08 23:56:01');
INSERT INTO `comment` VALUES ('6', '100', '1', '1', '不错', '3', '2014-07-09 00:05:19');
INSERT INTO `comment` VALUES ('7', '100', '2', '1', '测试', '1', '2014-07-09 00:32:00');
INSERT INTO `comment` VALUES ('8', '100', '3', '2', '难吃呀', '3', '2014-07-07 23:35:41');
INSERT INTO `comment` VALUES ('9', '100', '3', '2', '好吃呀', '4', '2014-07-07 23:35:45');
INSERT INTO `comment` VALUES ('10', '100', '3', '2', '好好吃哦', '5', '2014-07-08 23:35:41');
INSERT INTO `comment` VALUES ('11', '100', '3', '3', '难吃呀', '3', '2014-07-07 23:35:41');
INSERT INTO `comment` VALUES ('12', '100', '3', '4', '好吃呀', '4', '2014-07-07 23:35:45');
INSERT INTO `comment` VALUES ('13', '100', '3', '5', '好好吃哦', '5', '2014-07-08 23:35:41');
INSERT INTO `comment` VALUES ('14', '100', '3', '6', '难吃呀', '3', '2014-07-07 23:35:41');
INSERT INTO `comment` VALUES ('15', '100', '3', '7', '好吃呀', '4', '2014-07-07 23:35:45');
INSERT INTO `comment` VALUES ('16', '100', '3', '8', '好好吃哦', '5', '2014-07-08 23:35:41');
INSERT INTO `comment` VALUES ('17', '100', '3', '8', '难吃呀', '3', '2014-07-07 23:35:41');
INSERT INTO `comment` VALUES ('18', '100', '3', '9', '好吃呀', '4', '2014-07-07 23:35:45');
INSERT INTO `comment` VALUES ('19', '100', '3', '9', '好好吃哦', '5', '2014-07-08 23:35:41');
INSERT INTO `comment` VALUES ('20', '100', '3', '1', '不错哦', '1', '2014-07-10 12:11:44');
INSERT INTO `comment` VALUES ('21', '100', '3', '1', '不错哦', '1', '2014-07-10 12:29:24');
INSERT INTO `comment` VALUES ('22', '100', '3', '1', '不错哦', '1', '2014-07-11 10:27:44');
INSERT INTO `comment` VALUES ('23', '100', '3', '1', '不错哦', '1', '2014-07-11 17:57:35');
INSERT INTO `comment` VALUES ('24', '100', '3', '1', '不错哦', '1', '2014-07-11 17:57:47');
INSERT INTO `comment` VALUES ('25', '100', '3', '1', '不错哦', '1', '2014-07-11 17:58:20');
INSERT INTO `comment` VALUES ('26', '100', '3', '1', '不错哦', '1', '2014-07-11 18:00:26');
INSERT INTO `comment` VALUES ('27', '100', '3', '1', '不错哦', '1', '2014-07-11 18:05:48');

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `Id` int(20) unsigned NOT NULL auto_increment,
  `Title` varchar(100) NOT NULL,
  `ImgId` int(20) default NULL,
  `ImgUrl` varchar(1000) default NULL,
  `Extcredit` int(20) default NULL COMMENT 'ç§¯åˆ†',
  `Expiry` datetime NOT NULL COMMENT 'æœ‰æ•ˆæœŸ',
  `Description` varchar(1000) default NULL COMMENT 'æè¿°',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of coupon
-- ----------------------------

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
  `Id` int(11) default NULL COMMENT '用户id',
  `Gids` varchar(200) default '' COMMENT '收藏的产品id列表'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of favorite
-- ----------------------------
INSERT INTO `favorite` VALUES ('3', '1,2');
INSERT INTO `favorite` VALUES ('4', '1,2,3,4,5');
INSERT INTO `favorite` VALUES ('5', '6,7,8,9,10');
INSERT INTO `favorite` VALUES ('1', '1');

-- ----------------------------
-- Table structure for goodscategories
-- ----------------------------
DROP TABLE IF EXISTS `goodscategories`;
CREATE TABLE `goodscategories` (
  `Id` int(11) NOT NULL auto_increment COMMENT 'id',
  `Index` int(11) default NULL COMMENT '排序id',
  `Name` varchar(50) default NULL COMMENT '分类名称',
  `SellerId` int(11) default NULL COMMENT '商户id',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodscategories
-- ----------------------------
INSERT INTO `goodscategories` VALUES ('1', '1', '小炒类', '100');
INSERT INTO `goodscategories` VALUES ('2', '2', '海鲜类', '100');
INSERT INTO `goodscategories` VALUES ('3', '3', '面食类', '100');
INSERT INTO `goodscategories` VALUES ('4', '4', '早餐类', '100');
INSERT INTO `goodscategories` VALUES ('5', '5', '套餐类', '100');

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material` (
  `Id` int(20) NOT NULL auto_increment,
  `Title` varchar(100) collate utf8_unicode_ci NOT NULL,
  `Url` varchar(1000) collate utf8_unicode_ci NOT NULL,
  `Description` varchar(1000) collate utf8_unicode_ci NOT NULL,
  `Views` int(11) NOT NULL default '0',
  `Commentnum` int(11) NOT NULL default '0',
  `SellerId` int(20) NOT NULL COMMENT '商家Id',
  `CreateTime` datetime NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES ('1', '飞翔的赶脚', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '海盗来袭', '0', '1', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('2', '玉溪', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_02.png', '海盗突袭', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('3', '么牛', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_03.png', '德国必胜', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('4', '热火嗨', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_04.png', '输了没事', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('5', '把油', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_05.png', 'jj', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('6', 'high起来', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_06.png', '邹师傅', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('7', '方便面', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_07.png', '说好就好', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('8', '糗百', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_08.png', '咬你', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('9', '翻了', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_09.png', '烦了', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('10', '好吧', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_10.png', 'dd', '0', '0', '100', '2014-07-07 22:43:00');

-- ----------------------------
-- Table structure for mparam
-- ----------------------------
DROP TABLE IF EXISTS `mparam`;
CREATE TABLE `mparam` (
  `Id` int(11) NOT NULL auto_increment,
  `AdImgId` int(11) default NULL,
  `AdImgUrl` varchar(200) default NULL,
  `Title` varchar(50) default NULL,
  `Url` varchar(200) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mparam
-- ----------------------------
INSERT INTO `mparam` VALUES ('1', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '广告', 'http://www.baidu.com');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `Id` int(11) NOT NULL auto_increment,
  `SellerId` int(11) default NULL COMMENT '商家id',
  `Logo` int(11) default NULL COMMENT '代表该产品的图片id',
  `ImgIds` varchar(100) default '' COMMENT '产品图片id列表',
  `Sales` int(11) default NULL COMMENT '销量',
  `Title` varchar(50) default '' COMMENT '产品名称',
  `Cid` int(11) default '0' COMMENT '分类id',
  `Nowprice` float(11,2) default NULL COMMENT '现价',
  `OriginalPrice` float(11,2) default '0.00' COMMENT '原价',
  `Score` float(11,0) default NULL COMMENT '评级',
  `CreateTime` datetime NOT NULL COMMENT '创建时间或者修改时间',
  `FavCount` int(11) default NULL COMMENT '收藏次数',
  `ShareCount` int(11) default NULL COMMENT '分享次数',
  `Tag` varchar(255) default NULL COMMENT '产品标签',
  `Content` varchar(1000) default NULL COMMENT '产品描述',
  `IsHot` int(11) default NULL COMMENT '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', '100', '1', '1,2,3', '1', '榨菜肉丝', '1', '10.00', '12.00', '5', '2014-07-07 23:12:58', '3', '10', '肉', '啦啦啦有肉冲啊', '0');
INSERT INTO `goods` VALUES ('2', '100', '4', '2,3,4', '1', '茄子酱肉', '1', '12.00', '13.00', '5', '2014-07-07 23:12:58', '2', '4', '肉', '啦啦啦有肉冲啊', '0');
INSERT INTO `goods` VALUES ('3', '100', '1', '1,2,3', '1', '目鱼筒骨', '2', '10.00', '12.00', '5', '2014-07-07 23:12:58', '1', '1', '肉', '啦啦啦有肉冲啊', '0');
INSERT INTO `goods` VALUES ('4', '100', '4', '2,3,4', '1', '酱爆鱿鱼', '2', '12.00', '13.00', '5', '2014-07-07 23:12:58', '1', '4', '肉', '啦啦啦有肉冲啊', '0');
INSERT INTO `goods` VALUES ('5', '100', '1', '1,2,3', '1', '莆田卤面', '1', '10.00', '12.00', '5', '2014-07-07 23:12:58', '1', '1', '肉', '啦啦啦有肉冲啊', '1');
INSERT INTO `goods` VALUES ('6', '100', '4', '2,3,4', '1', '炒米线', '1', '12.00', '13.00', '5', '2014-07-07 23:12:58', '1', '4', '肉', '啦啦啦有肉冲啊', '0');
INSERT INTO `goods` VALUES ('7', '100', '1', '1,2,3', '1', '肉包', '1', '2.00', '2.50', '5', '2014-07-07 23:12:58', '1', '1', '肉', '啦啦啦有肉冲啊', '0');
INSERT INTO `goods` VALUES ('8', '100', '4', '2,3,4', '1', '馒头', '1', '1.00', '1.50', '5', '2014-07-07 23:12:58', '1', '4', '肉', '啦啦啦有肉冲啊', '1');
INSERT INTO `goods` VALUES ('9', '100', '1', '1,2,3', '1', '套餐1', '1', '10.00', '12.00', '5', '2014-07-07 23:12:58', '1', '1', '肉', '啦啦啦有肉冲啊', '1');
INSERT INTO `goods` VALUES ('10', '100', '4', '2,3,4', '1', '套餐2', '1', '12.00', '13.00', '5', '2014-07-07 23:12:58', '1', '4', '肉', '啦啦啦有肉冲啊', '1');
INSERT INTO `goods` VALUES ('11', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('12', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('13', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('14', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('15', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('16', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('17', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('18', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('19', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('20', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('21', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('22', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('23', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('24', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('25', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('26', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('27', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');
INSERT INTO `goods` VALUES ('28', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `Id` int(11) NOT NULL auto_increment,
  `UserId` int(11) default NULL,
  `Gids` varchar(100) default '',
  `Nums` varchar(100) default '',
  `Imgs` varchar(500) default '',
  `Titles` varchar(100) default '',
  `NowPrices` varchar(100) default '',
  `OriginalPrices` varchar(100) default '',
  `TotalPrice` float(11,2) default NULL,
  `StotalPrice` float(11,2) default NULL,
  `Pid` int(11) default NULL,
  `OrderTime` datetime default NULL COMMENT '就餐时间',
  `OrderType` int(11) default NULL,
  `OrderPeople` int(11) default NULL,
  `CouponId` int(11) default NULL,
  `CtotalPrice` float(11,2) default NULL,
  `Address` varchar(100) default '',
  `LinkMan` varchar(100) default '',
  `Mobile` varchar(100) default '',
  `CreateTime` datetime default NULL,
  `Remark` varchar(100) default NULL,
  `Status` int(11) default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('1', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png,http://182.254.137.180/bg/images/merchant/100/kulouwenhua_04.png,http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '1', '2014-07-15 00:00:00', '0', '10', '1', '0.00', '福州', '隔壁老王', '10000', '2014-07-11 18:04:59', '老王我们一起去吃麻辣烫吧', '2');

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `Id` int(11) NOT NULL auto_increment,
  `SellerId` int(11) default NULL,
  `Name` varchar(50) default NULL COMMENT '名称',
  `Description` varchar(200) default NULL COMMENT '描述',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of payment
-- ----------------------------
INSERT INTO `payment` VALUES ('1', '100', '支付宝', '支付宝余额宝都行');
INSERT INTO `payment` VALUES ('2', '100', '建行', '建设银行');
INSERT INTO `payment` VALUES ('3', '100', '招行', '招商银行');

-- ----------------------------
-- Table structure for shoppingcart
-- ----------------------------
DROP TABLE IF EXISTS `shoppingcart`;
CREATE TABLE `shoppingcart` (
  `Id` int(11) NOT NULL auto_increment,
  `UserId` int(11) default NULL,
  `Gid` int(11) default NULL,
  `Img` varchar(200) default NULL COMMENT '产品图片地址',
  `Num` int(11) default NULL,
  `NowPrice` float(11,2) default NULL COMMENT '单价 ',
  `CreateTime` datetime default NULL,
  `OriginalPrice` float(11,2) default NULL,
  `Title` varchar(50) default NULL,
  `Description` varchar(100) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shoppingcart
-- ----------------------------
INSERT INTO `shoppingcart` VALUES ('1', '3', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '100', '10.00', '2014-07-11 10:27:51', '12.00', '榨菜肉丝', '啦啦啦有肉冲啊');
INSERT INTO `shoppingcart` VALUES ('2', '3', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '100', '10.00', '2014-07-11 18:02:19', '12.00', '榨菜肉丝', '啦啦啦有肉冲啊');
INSERT INTO `shoppingcart` VALUES ('3', '3', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '100', '10.00', '2014-07-11 18:05:42', '12.00', '榨菜肉丝', '啦啦啦有肉冲啊');
