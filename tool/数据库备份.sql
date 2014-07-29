/*
Navicat MySQL Data Transfer

Source Server         : yuanc_myweb
Source Server Version : 50096
Source Host           : 182.254.137.180:3306
Source Database       : myweb

Target Server Type    : MYSQL
Target Server Version : 50096
File Encoding         : 65001

Date: 2014-07-29 08:51:16
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
  `SellerId` int(11) default '0' COMMENT '商户id——用户属于一个商户的',
  `RoleType` int(11) default '1' COMMENT '角色类型',
  `Avatar` varchar(100) default '' COMMENT '头像地址',
  `Sex` int(4) default '0' COMMENT '0:男性，1：女性',
  `LinkMan` varchar(50) default '' COMMENT '联系人',
  `Phone` varchar(30) default '' COMMENT '联系电话',
  `Address` varchar(255) default '' COMMENT '送货地址',
  `Money` float(11,0) default '0' COMMENT '余额',
  `Integral` int(11) default '0' COMMENT '积分',
  `CreateTime` datetime default NULL COMMENT '创建或修改时间',
  `NickName` varchar(50) default '' COMMENT '昵称',
  `RegisterTime` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('1', 'admin', '111', '0', '1', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '0', '10', '2014-07-06 18:27:21', '', '2014-07-14 09:27:16');
INSERT INTO `account` VALUES ('2', '11111', 'sfdfsdf', '0', '2', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '0', '10', '2014-07-06 18:27:32', '', '2014-07-15 09:27:23');
INSERT INTO `account` VALUES ('3', 'user1', '1234', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '1', '隔壁老王', '110', '隔壁', '900', '1050', '2014-07-06 18:27:37', '请叫我雷锋', '2014-07-14 09:27:27');
INSERT INTO `account` VALUES ('4', 'user2', '111', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '0', '0', '2014-07-06 18:27:37', '', '2014-07-14 09:27:30');
INSERT INTO `account` VALUES ('5', 'user3', '111', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '0', '0', '2014-07-06 18:27:37', '', '2014-07-21 09:27:37');
INSERT INTO `account` VALUES ('100', 'muser', '111', '0', '10', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '0', '0', '2014-07-06 18:27:37', '', '2014-07-14 09:27:41');
INSERT INTO `account` VALUES ('101', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '0', '0', '2014-07-18 14:05:39', '', null);
INSERT INTO `account` VALUES ('102', 'saturn', '111111', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '15205065475', '', '0', '30', '2014-07-21 20:25:56', '', null);
INSERT INTO `account` VALUES ('103', '刚回家', '123456', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '13959137940', '', '0', '30', '2014-07-26 22:39:58', '', null);
INSERT INTO `account` VALUES ('104', '操场', '123456', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '15506902089', '', '0', '0', '2014-07-27 15:16:31', '', null);
INSERT INTO `account` VALUES ('105', 'lt', 'asdasd', '100', '1', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '18650390820', '', '0', '0', '2014-07-27 15:16:31', '', '2014-07-27 15:16:31');
INSERT INTO `account` VALUES ('106', 'mmhh', '123456', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '13600887930', '', '0', '0', '2014-07-27 20:50:55', '', null);
INSERT INTO `account` VALUES ('107', '444444', '444444', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '15980207996', '', '0', '20', '2014-07-27 21:22:23', '', null);

-- ----------------------------
-- Table structure for accountbinding
-- ----------------------------
DROP TABLE IF EXISTS `accountbinding`;
CREATE TABLE `accountbinding` (
  `Id` int(11) NOT NULL default '0',
  `AccountType` int(11) default '0' COMMENT '第三方账号类型',
  `UserIdentity` varchar(30) default '' COMMENT '第三方账号标识',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of accountbinding
-- ----------------------------
INSERT INTO `accountbinding` VALUES ('101', '1', '1001');

-- ----------------------------
-- Table structure for active
-- ----------------------------
DROP TABLE IF EXISTS `active`;
CREATE TABLE `active` (
  `Id` int(11) NOT NULL auto_increment,
  `SellerId` int(11) NOT NULL,
  `CoverImgId` int(11) NOT NULL,
  `Title` varchar(100) collate utf8_unicode_ci default NULL COMMENT '活动标题',
  `Summary` varchar(1000) collate utf8_unicode_ci default NULL COMMENT '活动描述',
  `CreateTime` datetime NOT NULL,
  `CoverImgUrl` varchar(1000) collate utf8_unicode_ci default NULL COMMENT '封面url，冗余',
  `Views` int(11) default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of active
-- ----------------------------
INSERT INTO `active` VALUES ('1', '100', '1', '资讯测试', '资讯测试', '2014-07-09 00:28:21', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');
INSERT INTO `active` VALUES ('2', '100', '1', '资讯测试', 'test', '2014-07-15 00:13:10', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');
INSERT INTO `active` VALUES ('3', '100', '1', 'test', 'test', '2014-07-15 00:13:36', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');
INSERT INTO `active` VALUES ('4', '100', '1', '资讯测试', 'Summary', '2014-07-15 00:15:13', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');
INSERT INTO `active` VALUES ('5', '100', '1', '资讯测试', 'Summary', '2014-07-15 00:15:18', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');
INSERT INTO `active` VALUES ('6', '100', '1', '资讯测试', 'Summary', '2014-07-15 00:15:20', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');
INSERT INTO `active` VALUES ('7', '100', '1', '资讯测试', 'Summary', '2014-07-15 00:15:20', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');
INSERT INTO `active` VALUES ('8', '100', '1', '资讯测试', 'Summary', '2014-07-15 00:15:21', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');
INSERT INTO `active` VALUES ('9', '100', '1', '资讯测试', 'Summary', '2014-07-15 00:15:21', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');
INSERT INTO `active` VALUES ('10', '100', '1', '资讯测试', 'Summary', '2014-07-15 00:15:22', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');
INSERT INTO `active` VALUES ('11', '100', '1', '资讯测试', 'Summary', '2014-07-15 00:15:23', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');
INSERT INTO `active` VALUES ('12', '100', '1', '资讯测试', 'Summary', '2014-07-15 00:15:23', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '0');

-- ----------------------------
-- Table structure for chargelog
-- ----------------------------
DROP TABLE IF EXISTS `chargelog`;
CREATE TABLE `chargelog` (
  `Id` int(11) NOT NULL auto_increment,
  `SellerId` int(11) default NULL,
  `UserId` int(11) default NULL,
  `Money` float(11,0) default NULL,
  `Pid` int(11) default NULL COMMENT '充值类型',
  `PayName` varchar(50) default '' COMMENT '充值类型名称',
  `OrderId` varchar(30) default '0' COMMENT '关联的订单号',
  `CreateTime` datetime default NULL COMMENT '创建时间',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chargelog
-- ----------------------------
INSERT INTO `chargelog` VALUES ('1', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:05:35');
INSERT INTO `chargelog` VALUES ('2', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:42');
INSERT INTO `chargelog` VALUES ('3', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:44');
INSERT INTO `chargelog` VALUES ('4', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:45');
INSERT INTO `chargelog` VALUES ('5', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:46');
INSERT INTO `chargelog` VALUES ('6', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:46');
INSERT INTO `chargelog` VALUES ('7', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:47');
INSERT INTO `chargelog` VALUES ('8', '100', '3', '100', '1', '余额支付', '1', '2014-07-23 16:53:09');
INSERT INTO `chargelog` VALUES ('9', '100', '3', '100', '1', '余额支付', '1', '2014-07-26 20:58:13');

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
  `Img` varchar(100) collate utf8_unicode_ci default '' COMMENT '评论对象图片地址',
  `Title` varchar(30) collate utf8_unicode_ci default '' COMMENT '评论对象标题',
  `CreateTime` datetime NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('2', '100', '3', '1', '好吃呀', '4', '', '', '2014-07-07 23:35:45');
INSERT INTO `comment` VALUES ('3', '100', '3', '1', '好好吃哦', '5', '', '', '2014-07-08 23:35:41');
INSERT INTO `comment` VALUES ('7', '100', '2', '1', '测试', '1', '', '', '2014-07-09 00:32:00');
INSERT INTO `comment` VALUES ('9', '100', '3', '2', '好吃呀', '4', '', '', '2014-07-07 23:35:45');
INSERT INTO `comment` VALUES ('10', '100', '3', '2', '好好吃哦', '5', '', '', '2014-07-08 23:35:41');
INSERT INTO `comment` VALUES ('12', '100', '3', '4', '好吃呀', '4', '', '', '2014-07-07 23:35:45');
INSERT INTO `comment` VALUES ('13', '100', '3', '5', '好好吃哦', '5', '', '', '2014-07-08 23:35:41');
INSERT INTO `comment` VALUES ('15', '100', '3', '7', '好吃呀', '4', '', '', '2014-07-07 23:35:45');
INSERT INTO `comment` VALUES ('16', '100', '3', '8', '好好吃哦', '5', '', '', '2014-07-08 23:35:41');
INSERT INTO `comment` VALUES ('18', '100', '3', '9', '好吃呀', '4', '', '', '2014-07-07 23:35:45');
INSERT INTO `comment` VALUES ('19', '100', '3', '9', '好好吃哦', '5', '', '', '2014-07-08 23:35:41');
INSERT INTO `comment` VALUES ('20', '100', '3', '1', '不错哦', '1', '', '', '2014-07-10 12:11:44');
INSERT INTO `comment` VALUES ('21', '100', '3', '1', '不错哦', '1', '', '', '2014-07-10 12:29:24');
INSERT INTO `comment` VALUES ('22', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 10:27:44');
INSERT INTO `comment` VALUES ('23', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 17:57:35');
INSERT INTO `comment` VALUES ('24', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 17:57:47');
INSERT INTO `comment` VALUES ('25', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 17:58:20');
INSERT INTO `comment` VALUES ('26', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 18:00:26');
INSERT INTO `comment` VALUES ('27', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 18:05:48');
INSERT INTO `comment` VALUES ('28', '100', '3', '1', '不错哦', '1', '', '', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('29', '100', '3', '1', '不错哦', '1', '', '', '2014-07-12 21:49:22');
INSERT INTO `comment` VALUES ('30', '100', '3', '1', '不错哦', '1', '', '', '2014-07-16 21:00:15');
INSERT INTO `comment` VALUES ('31', '100', '3', '1', '不错哦dddddddd', '1', '', '', '2014-07-16 21:00:34');
INSERT INTO `comment` VALUES ('32', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:00');
INSERT INTO `comment` VALUES ('33', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:01');
INSERT INTO `comment` VALUES ('34', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:02');
INSERT INTO `comment` VALUES ('35', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:02');
INSERT INTO `comment` VALUES ('36', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:03');
INSERT INTO `comment` VALUES ('37', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:04');
INSERT INTO `comment` VALUES ('38', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:04');
INSERT INTO `comment` VALUES ('39', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:05');
INSERT INTO `comment` VALUES ('40', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:06');
INSERT INTO `comment` VALUES ('41', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:06');
INSERT INTO `comment` VALUES ('42', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:07');
INSERT INTO `comment` VALUES ('43', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:07');
INSERT INTO `comment` VALUES ('44', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:08');
INSERT INTO `comment` VALUES ('45', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:09');
INSERT INTO `comment` VALUES ('46', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:09');
INSERT INTO `comment` VALUES ('47', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:10');
INSERT INTO `comment` VALUES ('48', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:10');
INSERT INTO `comment` VALUES ('49', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:11');
INSERT INTO `comment` VALUES ('50', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:11');
INSERT INTO `comment` VALUES ('51', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:12');
INSERT INTO `comment` VALUES ('52', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:12');
INSERT INTO `comment` VALUES ('53', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:13');
INSERT INTO `comment` VALUES ('54', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:13');
INSERT INTO `comment` VALUES ('55', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:14');
INSERT INTO `comment` VALUES ('56', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:15');
INSERT INTO `comment` VALUES ('57', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:15');
INSERT INTO `comment` VALUES ('58', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:16');
INSERT INTO `comment` VALUES ('59', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:16');
INSERT INTO `comment` VALUES ('60', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:17');
INSERT INTO `comment` VALUES ('61', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:18');
INSERT INTO `comment` VALUES ('62', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:18');
INSERT INTO `comment` VALUES ('63', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:19');
INSERT INTO `comment` VALUES ('64', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:19');
INSERT INTO `comment` VALUES ('65', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:26');
INSERT INTO `comment` VALUES ('66', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:27');
INSERT INTO `comment` VALUES ('67', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:28');
INSERT INTO `comment` VALUES ('68', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:28');
INSERT INTO `comment` VALUES ('69', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:35');
INSERT INTO `comment` VALUES ('70', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:35');
INSERT INTO `comment` VALUES ('71', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:36');
INSERT INTO `comment` VALUES ('72', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:36');
INSERT INTO `comment` VALUES ('73', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:37');
INSERT INTO `comment` VALUES ('74', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:37');
INSERT INTO `comment` VALUES ('75', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:38');
INSERT INTO `comment` VALUES ('76', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:38');
INSERT INTO `comment` VALUES ('77', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:39');
INSERT INTO `comment` VALUES ('78', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:39');
INSERT INTO `comment` VALUES ('79', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:40');
INSERT INTO `comment` VALUES ('80', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:41');
INSERT INTO `comment` VALUES ('81', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:41');
INSERT INTO `comment` VALUES ('82', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:41');
INSERT INTO `comment` VALUES ('83', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:42');
INSERT INTO `comment` VALUES ('84', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:42');
INSERT INTO `comment` VALUES ('85', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:42');
INSERT INTO `comment` VALUES ('86', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:42');
INSERT INTO `comment` VALUES ('87', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:43');
INSERT INTO `comment` VALUES ('88', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:43');
INSERT INTO `comment` VALUES ('89', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:43');
INSERT INTO `comment` VALUES ('90', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:43');
INSERT INTO `comment` VALUES ('91', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44');
INSERT INTO `comment` VALUES ('92', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44');
INSERT INTO `comment` VALUES ('93', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44');
INSERT INTO `comment` VALUES ('94', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44');
INSERT INTO `comment` VALUES ('95', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44');
INSERT INTO `comment` VALUES ('96', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44');
INSERT INTO `comment` VALUES ('97', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:45');
INSERT INTO `comment` VALUES ('98', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:45');
INSERT INTO `comment` VALUES ('99', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:45');
INSERT INTO `comment` VALUES ('100', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:45');
INSERT INTO `comment` VALUES ('101', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:46');
INSERT INTO `comment` VALUES ('102', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:46');
INSERT INTO `comment` VALUES ('103', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:46');
INSERT INTO `comment` VALUES ('104', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:47');
INSERT INTO `comment` VALUES ('105', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:47');
INSERT INTO `comment` VALUES ('106', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:47');
INSERT INTO `comment` VALUES ('107', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:47');
INSERT INTO `comment` VALUES ('108', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:47');
INSERT INTO `comment` VALUES ('109', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:48');
INSERT INTO `comment` VALUES ('110', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:48');
INSERT INTO `comment` VALUES ('111', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:48');
INSERT INTO `comment` VALUES ('112', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:48');
INSERT INTO `comment` VALUES ('113', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:49');
INSERT INTO `comment` VALUES ('114', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:49');
INSERT INTO `comment` VALUES ('115', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:49');
INSERT INTO `comment` VALUES ('116', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:50');
INSERT INTO `comment` VALUES ('117', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:50');
INSERT INTO `comment` VALUES ('118', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:50');
INSERT INTO `comment` VALUES ('119', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:50');
INSERT INTO `comment` VALUES ('120', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:50');
INSERT INTO `comment` VALUES ('121', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:51');
INSERT INTO `comment` VALUES ('122', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:51');
INSERT INTO `comment` VALUES ('123', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:51');
INSERT INTO `comment` VALUES ('124', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:51');
INSERT INTO `comment` VALUES ('125', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:51');
INSERT INTO `comment` VALUES ('126', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:52');
INSERT INTO `comment` VALUES ('127', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:52');
INSERT INTO `comment` VALUES ('128', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:53');
INSERT INTO `comment` VALUES ('129', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:53');
INSERT INTO `comment` VALUES ('130', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:53');
INSERT INTO `comment` VALUES ('131', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:54');
INSERT INTO `comment` VALUES ('132', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:54');
INSERT INTO `comment` VALUES ('133', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:54');
INSERT INTO `comment` VALUES ('134', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:55');
INSERT INTO `comment` VALUES ('135', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:55');
INSERT INTO `comment` VALUES ('136', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:56');
INSERT INTO `comment` VALUES ('137', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:56');
INSERT INTO `comment` VALUES ('138', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:56');
INSERT INTO `comment` VALUES ('139', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:57');
INSERT INTO `comment` VALUES ('140', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:57');
INSERT INTO `comment` VALUES ('141', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:57');
INSERT INTO `comment` VALUES ('142', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:57');
INSERT INTO `comment` VALUES ('143', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:57');
INSERT INTO `comment` VALUES ('144', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:58');
INSERT INTO `comment` VALUES ('145', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:58');
INSERT INTO `comment` VALUES ('146', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:58');
INSERT INTO `comment` VALUES ('147', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:58');
INSERT INTO `comment` VALUES ('148', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:59');
INSERT INTO `comment` VALUES ('149', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:59');
INSERT INTO `comment` VALUES ('150', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:59');
INSERT INTO `comment` VALUES ('151', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:59');
INSERT INTO `comment` VALUES ('152', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:00');
INSERT INTO `comment` VALUES ('153', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:00');
INSERT INTO `comment` VALUES ('154', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:00');
INSERT INTO `comment` VALUES ('155', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:00');
INSERT INTO `comment` VALUES ('156', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:01');
INSERT INTO `comment` VALUES ('157', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:01');
INSERT INTO `comment` VALUES ('158', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:01');
INSERT INTO `comment` VALUES ('159', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:01');
INSERT INTO `comment` VALUES ('160', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:02');
INSERT INTO `comment` VALUES ('161', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:02');
INSERT INTO `comment` VALUES ('162', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:02');
INSERT INTO `comment` VALUES ('163', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:02');
INSERT INTO `comment` VALUES ('164', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:02');
INSERT INTO `comment` VALUES ('165', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:03');
INSERT INTO `comment` VALUES ('166', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:03');
INSERT INTO `comment` VALUES ('167', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:03');
INSERT INTO `comment` VALUES ('168', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:03');
INSERT INTO `comment` VALUES ('169', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:04');
INSERT INTO `comment` VALUES ('170', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:04');
INSERT INTO `comment` VALUES ('171', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:04');
INSERT INTO `comment` VALUES ('172', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:05');
INSERT INTO `comment` VALUES ('173', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:05');
INSERT INTO `comment` VALUES ('174', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:05');
INSERT INTO `comment` VALUES ('175', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:05');
INSERT INTO `comment` VALUES ('176', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:06');
INSERT INTO `comment` VALUES ('177', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:06');
INSERT INTO `comment` VALUES ('178', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:06');
INSERT INTO `comment` VALUES ('179', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:06');
INSERT INTO `comment` VALUES ('180', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:07');
INSERT INTO `comment` VALUES ('181', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:07');
INSERT INTO `comment` VALUES ('182', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:07');
INSERT INTO `comment` VALUES ('183', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:07');
INSERT INTO `comment` VALUES ('184', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:07');
INSERT INTO `comment` VALUES ('185', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:08');
INSERT INTO `comment` VALUES ('186', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:08');
INSERT INTO `comment` VALUES ('187', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:08');
INSERT INTO `comment` VALUES ('188', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:08');
INSERT INTO `comment` VALUES ('189', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:09');
INSERT INTO `comment` VALUES ('190', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:09');
INSERT INTO `comment` VALUES ('191', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:09');
INSERT INTO `comment` VALUES ('192', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:10');
INSERT INTO `comment` VALUES ('193', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:10');
INSERT INTO `comment` VALUES ('194', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:10');
INSERT INTO `comment` VALUES ('195', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:10');
INSERT INTO `comment` VALUES ('196', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:11');
INSERT INTO `comment` VALUES ('197', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:11');
INSERT INTO `comment` VALUES ('198', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:11');
INSERT INTO `comment` VALUES ('199', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:11');
INSERT INTO `comment` VALUES ('200', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:12');
INSERT INTO `comment` VALUES ('201', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:12');
INSERT INTO `comment` VALUES ('202', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:12');
INSERT INTO `comment` VALUES ('203', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:13');
INSERT INTO `comment` VALUES ('204', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:13');
INSERT INTO `comment` VALUES ('205', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:22');
INSERT INTO `comment` VALUES ('206', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:27');
INSERT INTO `comment` VALUES ('207', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:28');
INSERT INTO `comment` VALUES ('208', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:28');
INSERT INTO `comment` VALUES ('209', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:29');
INSERT INTO `comment` VALUES ('210', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:30');
INSERT INTO `comment` VALUES ('217', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('218', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('219', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('220', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('221', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('222', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('223', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('224', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('225', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('226', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('227', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('228', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('229', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('230', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('231', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('232', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('233', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43');
INSERT INTO `comment` VALUES ('234', '0', '2', '10', '', '0', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-20 17:10:43');
INSERT INTO `comment` VALUES ('235', '0', '2', '10', '', '22123', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-20 17:10:57');
INSERT INTO `comment` VALUES ('236', '0', '2', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-20 17:11:05');
INSERT INTO `comment` VALUES ('237', '0', '1', '0', '', '0', null, null, '2014-07-20 17:15:20');
INSERT INTO `comment` VALUES ('238', '100', '1', '2', '', '0', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_02.png', '玉溪', '2014-07-20 17:15:52');
INSERT INTO `comment` VALUES ('239', '100', '1', '2', '', '0', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_02.png', '玉溪', '2014-07-20 17:20:37');
INSERT INTO `comment` VALUES ('242', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 17:45:28');
INSERT INTO `comment` VALUES ('244', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-20 17:47:59');
INSERT INTO `comment` VALUES ('245', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 17:53:25');
INSERT INTO `comment` VALUES ('246', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 19:06:12');
INSERT INTO `comment` VALUES ('247', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 20:41:07');
INSERT INTO `comment` VALUES ('248', '100', '1', '1', 'sdfsdfsdfdsfsd', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 20:41:35');
INSERT INTO `comment` VALUES ('250', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 20:45:59');
INSERT INTO `comment` VALUES ('251', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 20:46:00');
INSERT INTO `comment` VALUES ('252', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-20 22:14:31');
INSERT INTO `comment` VALUES ('253', '0', '2', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 14:04:01');
INSERT INTO `comment` VALUES ('254', '0', '2', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 17:10:50');
INSERT INTO `comment` VALUES ('255', '0', '2', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 17:11:08');
INSERT INTO `comment` VALUES ('256', '0', '2', '1', '12121', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 18:08:19');
INSERT INTO `comment` VALUES ('257', '0', '2', '1', '12121', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 18:11:46');
INSERT INTO `comment` VALUES ('258', '100', '4', '1', '12121', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 18:25:30');
INSERT INTO `comment` VALUES ('259', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-23 16:58:25');
INSERT INTO `comment` VALUES ('260', '0', '1', '0', '', '3', null, null, '2014-07-23 18:45:49');
INSERT INTO `comment` VALUES ('261', '0', '1', '0', 'sdfsdfsdf', '3', null, null, '2014-07-25 17:55:13');
INSERT INTO `comment` VALUES ('262', '0', '1', '0', 'sfsdfsdf', '3', null, null, '2014-07-25 17:56:35');
INSERT INTO `comment` VALUES ('263', '0', '1', '0', '11111', '3', null, null, '2014-07-25 18:00:39');
INSERT INTO `comment` VALUES ('264', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-25 18:03:10');
INSERT INTO `comment` VALUES ('265', '0', '4', '0', '', '3', null, null, '2014-07-25 18:04:42');
INSERT INTO `comment` VALUES ('266', '100', '4', '1', 'sdfsdfsdf', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-25 18:05:03');
INSERT INTO `comment` VALUES ('267', '100', '4', '1', 'sdfsdfsdf', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-25 18:09:18');
INSERT INTO `comment` VALUES ('268', '100', '4', '1', 'sdfsdfs', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-25 18:12:12');
INSERT INTO `comment` VALUES ('269', '100', '4', '1', 'dfsdfsdf', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-25 18:12:23');
INSERT INTO `comment` VALUES ('270', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-25 18:20:37');
INSERT INTO `comment` VALUES ('271', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-25 18:20:51');
INSERT INTO `comment` VALUES ('272', '0', '4', '0', '', '3', null, null, '2014-07-25 18:45:11');
INSERT INTO `comment` VALUES ('273', '0', '4', '0', '11111sdfsdf', '3', null, null, '2014-07-25 18:45:16');
INSERT INTO `comment` VALUES ('274', '0', '4', '0', '', '3', null, null, '2014-07-25 19:22:16');
INSERT INTO `comment` VALUES ('275', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-25 21:13:25');
INSERT INTO `comment` VALUES ('276', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-25 22:26:11');
INSERT INTO `comment` VALUES ('277', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-25 22:26:21');
INSERT INTO `comment` VALUES ('278', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-25 22:26:36');
INSERT INTO `comment` VALUES ('279', '100', '2', '2', '好斤斤计较', '103', null, '资讯测试', '2014-07-27 08:49:46');
INSERT INTO `comment` VALUES ('280', '100', '2', '1', '图哈哈哈', '103', null, '资讯测试', '2014-07-27 09:06:12');
INSERT INTO `comment` VALUES ('281', '100', '2', '1', '图哈哈哈', '103', null, '资讯测试', '2014-07-27 09:06:30');
INSERT INTO `comment` VALUES ('282', '100', '2', '1', '躺一会', '103', null, '资讯测试', '2014-07-27 09:34:36');
INSERT INTO `comment` VALUES ('283', '100', '2', '2', '11111', '103', null, '资讯测试', '2014-07-27 09:37:01');
INSERT INTO `comment` VALUES ('284', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 09:56:40');
INSERT INTO `comment` VALUES ('285', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 09:56:40');
INSERT INTO `comment` VALUES ('286', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 09:58:43');
INSERT INTO `comment` VALUES ('287', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 09:59:34');
INSERT INTO `comment` VALUES ('288', '100', '1', '1', '干活回家', '103', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 10:07:59');
INSERT INTO `comment` VALUES ('289', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 10:11:53');
INSERT INTO `comment` VALUES ('290', '100', '1', '1', '???��??', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 10:47:36');
INSERT INTO `comment` VALUES ('291', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 11:26:58');
INSERT INTO `comment` VALUES ('292', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 19:01:03');
INSERT INTO `comment` VALUES ('293', '100', '2', '1', '111', '102', null, '资讯测试', '2014-07-27 21:18:26');
INSERT INTO `comment` VALUES ('294', '100', '2', '12', '111', '102', null, '资讯测试', '2014-07-27 21:19:12');
INSERT INTO `comment` VALUES ('295', '100', '1', '6', '111', '102', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_06.png', 'high起来', '2014-07-27 21:20:51');
INSERT INTO `comment` VALUES ('296', '100', '2', '7', '111', '107', null, '资讯测试', '2014-07-27 21:23:23');
INSERT INTO `comment` VALUES ('297', '100', '2', '3', '111', '107', null, 'test', '2014-07-27 21:25:27');
INSERT INTO `comment` VALUES ('298', '100', '2', '3', '？', '107', null, 'test', '2014-07-28 00:14:36');

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
  `FullMoney` int(10) default NULL COMMENT '满多少的金额优惠',
  `DiscountMoney` int(10) default NULL COMMENT '优惠的具体金额',
  `GoodsIds` varchar(1000) default NULL COMMENT '限定使用商品',
  `Commentnum` int(20) default NULL COMMENT '评论数',
  `SellerId` int(20) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of coupon
-- ----------------------------
INSERT INTO `coupon` VALUES ('1', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '100', '1', '8', '100');
INSERT INTO `coupon` VALUES ('2', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100');
INSERT INTO `coupon` VALUES ('3', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100');
INSERT INTO `coupon` VALUES ('4', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100');
INSERT INTO `coupon` VALUES ('5', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100');
INSERT INTO `coupon` VALUES ('6', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100');
INSERT INTO `coupon` VALUES ('7', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100');
INSERT INTO `coupon` VALUES ('8', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100');
INSERT INTO `coupon` VALUES ('9', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100');
INSERT INTO `coupon` VALUES ('10', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100');
INSERT INTO `coupon` VALUES ('11', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100');

-- ----------------------------
-- Table structure for extcreditlog
-- ----------------------------
DROP TABLE IF EXISTS `extcreditlog`;
CREATE TABLE `extcreditlog` (
  `Id` int(11) NOT NULL auto_increment,
  `UserId` int(11) default NULL,
  `SellerId` int(11) default NULL,
  `Type` int(11) default NULL,
  `PlatformType` int(11) default '0' COMMENT '分享到的平台 0则不代表分享',
  `SourceId` int(11) default NULL,
  `Extcredit` int(11) default NULL,
  `CreateTime` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of extcreditlog
-- ----------------------------
INSERT INTO `extcreditlog` VALUES ('1', '3', '100', '3', '0', '1405526400', '20', '2014-07-17 22:08:13');
INSERT INTO `extcreditlog` VALUES ('2', '3', '100', '2', '0', '1405663535', '100', '2014-07-18 14:05:35');
INSERT INTO `extcreditlog` VALUES ('3', '1', '0', '21', '0', '1', '10', '2014-07-18 14:07:00');
INSERT INTO `extcreditlog` VALUES ('4', '3', '100', '0', '0', '0', '10', '2014-07-18 14:10:38');
INSERT INTO `extcreditlog` VALUES ('5', '3', '100', '2', '0', '1405666422', '100', '2014-07-18 14:53:42');
INSERT INTO `extcreditlog` VALUES ('6', '3', '100', '2', '0', '1405666424', '100', '2014-07-18 14:53:44');
INSERT INTO `extcreditlog` VALUES ('7', '3', '100', '2', '0', '1405666425', '100', '2014-07-18 14:53:45');
INSERT INTO `extcreditlog` VALUES ('8', '3', '100', '2', '0', '1405666426', '100', '2014-07-18 14:53:46');
INSERT INTO `extcreditlog` VALUES ('9', '3', '100', '2', '0', '1405666426', '100', '2014-07-18 14:53:46');
INSERT INTO `extcreditlog` VALUES ('10', '3', '100', '2', '0', '1405666427', '100', '2014-07-18 14:53:47');
INSERT INTO `extcreditlog` VALUES ('11', '3', '100', '3', '0', '1405612800', '20', '2014-07-18 15:22:42');
INSERT INTO `extcreditlog` VALUES ('12', '3', '100', '3', '0', '1405699200', '20', '2014-07-19 07:09:47');
INSERT INTO `extcreditlog` VALUES ('13', '3', '100', '21', '0', '1', '10', '2014-07-20 08:57:30');
INSERT INTO `extcreditlog` VALUES ('14', '3', '100', '3', '0', '1405785600', '20', '2014-07-20 09:48:22');
INSERT INTO `extcreditlog` VALUES ('15', '3', '100', '3', '0', '1405958400', '20', '2014-07-22 14:07:57');
INSERT INTO `extcreditlog` VALUES ('16', '3', '100', '3', '0', '1406044800', '20', '2014-07-23 15:29:09');
INSERT INTO `extcreditlog` VALUES ('17', '3', '100', '2', '0', '1406105589', '100', '2014-07-23 16:53:09');
INSERT INTO `extcreditlog` VALUES ('18', '3', '100', '2', '0', '1406379493', '100', '2014-07-26 20:58:13');
INSERT INTO `extcreditlog` VALUES ('19', '103', '100', '22', '0', '2', '10', '2014-07-27 08:49:46');
INSERT INTO `extcreditlog` VALUES ('20', '103', '100', '22', '0', '1', '10', '2014-07-27 09:06:12');
INSERT INTO `extcreditlog` VALUES ('21', '3', '100', '23', '0', '1', '10', '2014-07-27 09:56:41');
INSERT INTO `extcreditlog` VALUES ('22', '3', '100', '23', '0', '1', '10', '2014-07-27 09:56:41');
INSERT INTO `extcreditlog` VALUES ('23', '2', '0', '23', '0', '1', '10', '2014-07-27 09:59:35');
INSERT INTO `extcreditlog` VALUES ('24', '103', '100', '23', '0', '1', '10', '2014-07-27 10:07:59');
INSERT INTO `extcreditlog` VALUES ('25', '102', '100', '22', '0', '1', '10', '2014-07-27 21:18:26');
INSERT INTO `extcreditlog` VALUES ('26', '102', '100', '22', '0', '12', '10', '2014-07-27 21:19:12');
INSERT INTO `extcreditlog` VALUES ('27', '102', '100', '23', '0', '6', '10', '2014-07-27 21:20:51');
INSERT INTO `extcreditlog` VALUES ('28', '107', '100', '22', '0', '7', '10', '2014-07-27 21:23:23');
INSERT INTO `extcreditlog` VALUES ('29', '107', '100', '22', '0', '3', '10', '2014-07-27 21:25:27');

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
INSERT INTO `favorite` VALUES ('3', '1,2,3,8');
INSERT INTO `favorite` VALUES ('4', '1,2,3,4,5');
INSERT INTO `favorite` VALUES ('5', '6,7,8,9,10');
INSERT INTO `favorite` VALUES ('1', '1');
INSERT INTO `favorite` VALUES ('0', '');

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
  `CommentCount` int(11) default '0' COMMENT '评论次数',
  `IsHot` int(11) default '0' COMMENT '是否热销',
  `BrowseCount` int(11) default '0' COMMENT '浏览次数',
  `IsRecommend` int(11) default '0' COMMENT '是否推荐',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', '100', '1', '1,2,3', '2', '榨菜肉丝', '1', '10.00', '12.00', '5', '2014-07-07 23:12:58', '3', '10', '肉', '啦啦啦有肉冲啊', '13', '0', '4', '0');
INSERT INTO `goods` VALUES ('2', '100', '4', '2,3,4', '1', '茄子酱肉', '1', '12.00', '13.00', '5', '2014-07-07 23:12:58', '2', '4', '肉', '啦啦啦有肉冲啊', '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('3', '100', '1', '1,2,3', '1', '目鱼筒骨', '2', '10.00', '12.00', '5', '2014-07-07 23:12:58', '2', '1', '肉', '啦啦啦有肉冲啊', '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('4', '100', '4', '2,3,4', '1', '酱爆鱿鱼', '2', '12.00', '13.00', '5', '2014-07-07 23:12:58', '1', '4', '肉', '啦啦啦有肉冲啊', '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('5', '100', '1', '1,2,3', '1', '莆田卤面', '1', '10.00', '12.00', '5', '2014-07-07 23:12:58', '1', '1', '肉', '啦啦啦有肉冲啊', '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('6', '100', '4', '2,3,4', '1', '炒米线', '1', '12.00', '13.00', '5', '2014-07-07 23:12:58', '1', '4', '肉', '啦啦啦有肉冲啊', '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('7', '100', '1', '1,2,3', '1', '肉包', '1', '2.00', '2.50', '5', '2014-07-07 23:12:58', '1', '1', '肉', '啦啦啦有肉冲啊', '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('8', '100', '4', '2,3,4', '1', '馒头', '1', '1.00', '1.50', '5', '2014-07-07 23:12:58', '2', '4', '肉', '啦啦啦有肉冲啊', '0', '1', '0', '0');
INSERT INTO `goods` VALUES ('9', '100', '1', '1,2,3', '1', '套餐1', '1', '10.00', '12.00', '5', '2014-07-07 23:12:58', '1', '1', '肉', '啦啦啦有肉冲啊', '0', '1', '0', '0');
INSERT INTO `goods` VALUES ('10', '100', '4', '2,3,4', '1', '套餐2', '1', '12.00', '13.00', '5', '2014-07-07 23:12:58', '1', '4', '肉', '啦啦啦有肉冲啊', '0', '1', '0', '0');
INSERT INTO `goods` VALUES ('11', '0', '0', '', '0', '', '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '-1', '1', '', '', '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('12', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('13', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('14', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('15', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('16', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('17', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('18', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('19', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('20', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('21', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('22', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('23', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('24', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('25', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('26', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('27', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');
INSERT INTO `goods` VALUES ('28', '0', '0', null, '0', null, '0', '0.00', '0.00', '0', '0001-01-01 00:00:00', '0', '1', null, null, '0', '0', '0', '0');

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
INSERT INTO `material` VALUES ('1', '飞翔的赶脚', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '海盗来袭', '0', '17', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('2', '玉溪', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_02.png', '海盗突袭', '0', '2', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('3', '么牛', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_03.png', '德国必胜', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('4', '热火嗨', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '输了没事', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('5', '把油', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_05.png', 'jj', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('6', 'high起来', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_06.png', '邹师傅', '0', '1', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('7', '方便面', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_07.png', '说好就好', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('8', '糗百', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_08.png', '咬你', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('9', '翻了', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_09.png', '烦了', '0', '0', '100', '2014-07-07 22:43:00');
INSERT INTO `material` VALUES ('10', '好吧', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_10.png', 'dd', '0', '0', '100', '2014-07-07 22:43:00');

-- ----------------------------
-- Table structure for merchant
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant` (
  `Id` int(11) NOT NULL auto_increment,
  `Name` varchar(100) default NULL,
  `Tname` varchar(15) default '' COMMENT '名称缩写',
  `Address` varchar(150) default NULL,
  `Phone` varchar(30) default NULL,
  `Description` varchar(500) default NULL,
  `Mapurl` varchar(200) default NULL,
  `AppId` int(11) default NULL,
  `AppSecret` varchar(100) default NULL,
  `AccessToken` varchar(100) default NULL,
  `AccessExpire` datetime default NULL,
  `AndroidUrl` varchar(100) default NULL,
  `IosUrl` varchar(100) default NULL,
  `WxUrl` varchar(100) default NULL,
  `PointX` varchar(11) default NULL,
  `PointY` varchar(11) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of merchant
-- ----------------------------
INSERT INTO `merchant` VALUES ('100', '大闸蟹大饭店', '大闸蟹', '火星一号船头等舱10号', '110', '接送请拨号', '', '1', 'sdf234', 'dsfsd234', '2014-07-15 14:36:15', ' ', ' ', ' ', '119.304455', '26.091985');

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
  `Contents` varchar(500) default NULL,
  `Titles` varchar(100) default '',
  `NowPrices` varchar(100) default '',
  `OriginalPrices` varchar(100) default '',
  `TotalPrice` float(11,2) default NULL,
  `StotalPrice` float(11,2) default NULL,
  `Pid` int(11) default '0' COMMENT '支付方式id',
  `OrderTime` datetime default NULL COMMENT '就餐时间',
  `OrderType` int(11) default NULL,
  `OrderPeople` int(11) default NULL,
  `CouponId` int(11) default '0' COMMENT '用户优惠券id',
  `CtotalPrice` float(11,2) default NULL,
  `Address` varchar(100) default '',
  `LinkMan` varchar(100) default '',
  `Mobile` varchar(100) default '',
  `CreateTime` datetime default NULL,
  `Remark` varchar(100) default NULL,
  `Status` int(11) default '0',
  `SellerId` int(11) default '0' COMMENT '商户id',
  `Ccontent` varchar(100) default '' COMMENT '优惠券说明',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('1', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '61.50', '66.00', '1', '2014-07-15 00:00:00', '0', '10', '1', '0.50', '福州', '隔壁老王', '', '2014-07-18 14:16:18', '老王我们一起去吃麻辣烫吧', '9', '100', '');
INSERT INTO `orders` VALUES ('2', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:16:21', '0', '0', '0', '0.00', '', '', '', '2014-07-18 14:16:21', null, '0', '100', null);
INSERT INTO `orders` VALUES ('3', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:16:22', '0', '0', '0', '0.00', '', '', '', '2014-07-18 14:16:22', null, '0', '100', null);
INSERT INTO `orders` VALUES ('4', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:16:23', '0', '0', '0', '0.00', '', '', '', '2014-07-18 14:16:23', null, '0', '100', null);
INSERT INTO `orders` VALUES ('5', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:16:24', '0', '0', '0', '0.00', '', '', '', '2014-07-18 14:16:24', null, '0', '100', null);
INSERT INTO `orders` VALUES ('6', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:16:25', '0', '0', '0', '0.00', '', '', '', '2014-07-18 14:16:25', null, '0', '100', null);
INSERT INTO `orders` VALUES ('7', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:37:10', '0', '0', '0', '0.00', '', '', '', '2014-07-18 14:37:10', null, '0', '100', null);
INSERT INTO `orders` VALUES ('8', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-22 22:25:43', '0', '0', '0', '0.00', '', '', '', '2014-07-22 22:25:43', null, '0', '100', null);
INSERT INTO `orders` VALUES ('9', '3', '1,2', '1,5', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '62.00', '62.00', '1', '2014-07-15 00:00:00', '0', '10', '2', '0.00', '福州', '隔壁老王', '', '2014-07-25 19:33:55', '老王我们一起去吃麻辣烫吧', '-1', '100', '');

-- ----------------------------
-- Table structure for param
-- ----------------------------
DROP TABLE IF EXISTS `param`;
CREATE TABLE `param` (
  `Id` int(11) NOT NULL auto_increment,
  `Key` varchar(20) default NULL,
  `Kvalue` varchar(1000) default NULL,
  `Description` varchar(50) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of param
-- ----------------------------
INSERT INTO `param` VALUES ('1', 'PageAd', '{AdImgId:1,AdImgUrl:\"http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png\",Title:\"广告\",Url:\"http://www.baidu.com\"}', '开发方后台设置广告');
INSERT INTO `param` VALUES ('2', 'ExtcreditCfg', '{Charge:1,Share:10,Register:20,Consume:1,Comment:10}', '积分消费及获得');
INSERT INTO `param` VALUES ('3', 'MerchantCfg', '{SendPrice:5,FreeSendPrice:60}', '商户配置信息');

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
INSERT INTO `payment` VALUES ('1', '100', '余额支付', '账号余额支付');
INSERT INTO `payment` VALUES ('2', '100', '支付宝支付', '支持支付宝余额，快捷等多种方式。');
INSERT INTO `payment` VALUES ('3', '100', '银联支付', '安全快捷，支持各大银行支付');

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
  `Id` int(20) NOT NULL auto_increment,
  `ImgId` int(20) default NULL,
  `ImgUrl` varchar(1000) default NULL,
  `Title` varchar(1000) NOT NULL,
  `Price` int(20) default NULL,
  `Description` varchar(1000) default NULL,
  `Phone` float default NULL,
  `Status` int(4) NOT NULL COMMENT '1:已经预定，0：还未预定',
  `SellerId` int(20) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of position
-- ----------------------------
INSERT INTO `position` VALUES ('1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('4', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('6', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('7', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('8', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('9', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('10', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('11', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('12', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('13', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('14', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('15', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '1', '100');
INSERT INTO `position` VALUES ('16', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '0', '100');
INSERT INTO `position` VALUES ('17', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '0', '100');
INSERT INTO `position` VALUES ('18', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '0', '100');
INSERT INTO `position` VALUES ('19', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1.33333e+009', '0', '100');

-- ----------------------------
-- Table structure for sharelog
-- ----------------------------
DROP TABLE IF EXISTS `sharelog`;
CREATE TABLE `sharelog` (
  `Id` int(11) NOT NULL auto_increment,
  `UserId` int(11) default NULL,
  `Type` int(11) default NULL,
  `TypeId` int(11) default NULL,
  `Content` varchar(200) default '',
  `CreateTime` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sharelog
-- ----------------------------

-- ----------------------------
-- Table structure for shoppingcart
-- ----------------------------
DROP TABLE IF EXISTS `shoppingcart`;
CREATE TABLE `shoppingcart` (
  `Id` int(11) NOT NULL auto_increment,
  `UserId` int(11) default NULL,
  `Gid` int(11) default NULL,
  `Num` int(11) default NULL,
  `CreateTime` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shoppingcart
-- ----------------------------

-- ----------------------------
-- Table structure for usercoupon
-- ----------------------------
DROP TABLE IF EXISTS `usercoupon`;
CREATE TABLE `usercoupon` (
  `Id` int(20) unsigned NOT NULL auto_increment,
  `UserId` int(20) NOT NULL,
  `CouponId` int(20) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `Status` int(11) default '0' COMMENT '是否使用 0：未使用 1：已使用',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usercoupon
-- ----------------------------
INSERT INTO `usercoupon` VALUES ('1', '3', '1', '2014-07-20 17:10:57', '0');
INSERT INTO `usercoupon` VALUES ('2', '3', '2', '2014-07-20 17:11:27', '0');
INSERT INTO `usercoupon` VALUES ('3', '3', '3', '2014-07-21 20:58:13', '1');
INSERT INTO `usercoupon` VALUES ('4', '3', '4', '2014-07-21 20:58:35', '1');
INSERT INTO `usercoupon` VALUES ('5', '3', '5', '2014-07-21 21:02:39', '0');
INSERT INTO `usercoupon` VALUES ('6', '3', '6', '2014-07-21 21:02:41', '0');

-- ----------------------------
-- Table structure for userposition
-- ----------------------------
DROP TABLE IF EXISTS `userposition`;
CREATE TABLE `userposition` (
  `Id` int(20) NOT NULL auto_increment,
  `PositionId` int(20) NOT NULL,
  `UserId` int(20) NOT NULL,
  `NickName` varchar(100) default NULL,
  `SellerId` int(20) NOT NULL,
  `Phone` int(20) default NULL,
  `CreateTime` datetime default NULL,
  `Message` varchar(20) default NULL COMMENT '留言',
  `PayId` int(11) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userposition
-- ----------------------------

-- ----------------------------
-- Table structure for userwifi
-- ----------------------------
DROP TABLE IF EXISTS `userwifi`;
CREATE TABLE `userwifi` (
  `Id` int(20) NOT NULL auto_increment,
  `SellerId` int(20) NOT NULL,
  `Pwd` varchar(1000) default NULL COMMENT 'wifi密码',
  `UserId` int(20) NOT NULL,
  `Expiry` datetime NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userwifi
-- ----------------------------

-- ----------------------------
-- Table structure for verificationcode
-- ----------------------------
DROP TABLE IF EXISTS `verificationcode`;
CREATE TABLE `verificationcode` (
  `Id` int(11) NOT NULL auto_increment,
  `SellerId` int(11) default NULL,
  `Phone` varchar(30) default '',
  `Code` varchar(10) default NULL,
  `ExpiredTime` datetime default NULL,
  `UserId` int(11) default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of verificationcode
-- ----------------------------
INSERT INTO `verificationcode` VALUES ('1', '100', '13559165564', '351393', '2014-07-18 16:21:05', '0');
INSERT INTO `verificationcode` VALUES ('2', '100', '15205065475', '942896', '2014-07-21 20:54:35', '0');
INSERT INTO `verificationcode` VALUES ('3', '100', '18120807353', '375854', '2014-07-26 23:09:17', '0');
INSERT INTO `verificationcode` VALUES ('4', '100', '13959137940', '472352', '2014-07-27 12:46:13', '103');
INSERT INTO `verificationcode` VALUES ('5', '100', '155 6902089', '169831', '2014-07-27 15:43:22', '0');
INSERT INTO `verificationcode` VALUES ('6', '100', '15506902089', '516286', '2014-07-27 15:44:09', '0');
INSERT INTO `verificationcode` VALUES ('7', '100', '15980207996', '827636', '2014-07-27 21:51:21', '0');
INSERT INTO `verificationcode` VALUES ('8', '100', '13600887930', '433829', '2014-07-27 21:20:17', '0');
INSERT INTO `verificationcode` VALUES ('9', '100', '13276036517', '461713', '2014-07-27 22:35:18', '0');
INSERT INTO `verificationcode` VALUES ('10', '100', '18650390820', '226971', '2014-07-28 00:56:14', '105');
INSERT INTO `verificationcode` VALUES ('11', '100', '18650390820', '552546', '2014-07-28 01:04:48', '105');
INSERT INTO `verificationcode` VALUES ('12', '100', '18650390820', '615846', '2014-07-28 21:59:08', '105');
INSERT INTO `verificationcode` VALUES ('13', '100', '18650390820', '276659', '2014-07-28 21:59:33', '105');
INSERT INTO `verificationcode` VALUES ('14', '100', '18650390820', '745565', '2014-07-28 22:00:29', '105');
INSERT INTO `verificationcode` VALUES ('15', '100', '18650390820', '634132', '2014-07-28 22:00:29', '105');
INSERT INTO `verificationcode` VALUES ('16', '100', '18650390820', '495464', '2014-07-28 22:57:17', '105');
INSERT INTO `verificationcode` VALUES ('17', '100', '15205065475', '421489', '2014-07-28 23:35:56', '102');

-- ----------------------------
-- Table structure for weixintoken
-- ----------------------------
DROP TABLE IF EXISTS `weixintoken`;
CREATE TABLE `weixintoken` (
  `Id` int(20) NOT NULL auto_increment,
  `access_token` varchar(1000) NOT NULL,
  `token_expire` datetime NOT NULL,
  `SellerId` int(20) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weixintoken
-- ----------------------------
INSERT INTO `weixintoken` VALUES ('1', '', '1601-01-01 00:00:00', '0');
