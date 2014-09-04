/*
Navicat MySQL Data Transfer

Source Server         : myweb
Source Server Version : 50096
Source Host           : localhost:3306
Source Database       : myweb

Target Server Type    : MYSQL
Target Server Version : 50096
File Encoding         : 65001

Date: 2014-09-04 17:58:32
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
  `Avatar` varchar(300) default '' COMMENT '头像地址',
  `Sex` int(4) default '0' COMMENT '0:男性，1：女性',
  `LinkMan` varchar(50) default '' COMMENT '联系人',
  `Phone` varchar(30) default '' COMMENT '联系电话',
  `Address` varchar(255) default '' COMMENT '送货地址',
  `Money` float(11,0) default '0' COMMENT '余额',
  `Integral` int(11) default '0' COMMENT '积分',
  `CreateTime` datetime default NULL COMMENT '创建或修改时间',
  `NickName` varchar(50) default '' COMMENT '昵称',
  `RegisterTime` datetime default NULL,
  `Status` int(11) default '0' COMMENT '0：正常，-1：已删除',
  `Discount` float(11,0) default '10' COMMENT '折扣',
  `TotalRecharge` float(11,0) default '0' COMMENT '总充值',
  `TotalConsume` float(11,0) default '0' COMMENT '总消费',
  `TotalLoginCount` int(11) default '0' COMMENT '总登录次数',
  `TotalOrdersCount` int(11) default '0' COMMENT '总订单数',
  `LastLoginTime` datetime default '1970-01-01 12:00:00' COMMENT '最后一次登录时间',
  `Remark` varchar(300) default '' COMMENT '用户备注',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('1', 'admin', '111', '0', '1', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '0', '20', '2014-07-06 18:27:21', '', '2014-07-14 09:27:16', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('2', '11111', 'sfdfsdf', '0', '2', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '0', '10', '2014-07-06 18:27:32', '', '2014-07-15 09:27:23', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('3', 'user1', '1234', '100', '20', 'http://app.mto2o.cn/bg/File/3/image/head.jpg', '1', 'wangnima', '11086', '隔壁', '624', '1954', '2014-07-06 18:27:37', '', '2014-07-14 09:27:27', '0', '10', '100', '-32', '15', '3', '2014-08-17 15:39:20', '');
INSERT INTO `account` VALUES ('4', 'user2', '111', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '0', '20', '2014-07-06 18:27:37', '', '2014-07-14 09:27:30', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('5', 'user3', '111', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '0', '0', '2014-07-06 18:27:37', '', '2014-07-21 09:27:37', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('100', 'muser', '111', '0', '10', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '-200', '60', '2014-07-06 18:27:37', '', '2014-07-14 09:27:41', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('101', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '', '', '0', '0', '2014-07-18 14:05:39', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '4', '0', '2014-08-10 15:29:37', '');
INSERT INTO `account` VALUES ('102', 'saturn', '111111', '100', '20', 'http://www.mto2o.cn/bg/File/102/image/head.jpg', '0', '阿萨德风格', '15205065475', '好久哦也纷纷 v', '0', '100271', '2014-07-21 20:25:56', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '29', '0', '2014-09-03 23:59:38', '');
INSERT INTO `account` VALUES ('103', '刚回家', '123456', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '13959137940', '', '0', '30', '2014-07-26 22:39:58', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('104', '操场', '123456', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '15506902089', '', '0', '0', '2014-07-27 15:16:31', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('105', 'lt', 'asdasd', '100', '1', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '18650390820', '', '0', '0', '2014-07-27 15:16:31', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('106', 'mmhh', '123456', '100', '20', 'http://app.mto2o.cn/bg/File/106/image/head.jpg', '0', '腹股沟', '1360088793', '刚回家几节课', '0', '130', '2014-07-27 20:50:55', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '5', '0', '2014-08-17 14:15:46', '');
INSERT INTO `account` VALUES ('107', '444444', '444444', '100', '20', 'http://182.254.137.180/bg/css/img/head/user.png', '0', '', '15980207996', '', '0', '20', '2014-07-27 21:22:23', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '1', '0', '2014-08-11 15:56:50', '');
INSERT INTO `account` VALUES ('108', 'thirduser', '123456', '100', '30', 'qqq', '0', '', '', '', '0', '0', '2014-08-01 01:05:50', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('109', 'thirduser', '123456', '100', '30', 'qqq', '1', '', '', '', '0', '0', '2014-08-01 01:05:55', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('110', 'thirduser', '123456', '100', '30', 'qqq', '1', '', '', '', '0', '0', '2014-08-01 01:05:59', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('111', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/head/user.png', '0', '', '', '', '0', '0', '2014-08-01 09:51:05', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('112', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/head/user.png', '0', '', '', '', '0', '0', '2014-08-01 09:51:12', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('113', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/head/user.png', '0', '', '', '', '0', '0', '2014-08-01 09:51:17', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('114', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/head/user.png', '0', '', '', '', '0', '0', '2014-08-01 09:51:20', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('115', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/head/user.png', '0', '', '', '', '0', '0', '2014-08-01 09:51:23', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('116', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/head/user.png', '0', '', '', '', '0', '0', '2014-08-01 09:51:27', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('117', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/head/user.png', '0', '', '', '', '0', '0', '2014-08-01 09:51:32', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('118', 'thirduser', '123456', '100', '30', 'http://app.mto2o.cn/bg/File/118/image/head.jpg', '0', '', '', '', '0', '70', '2014-08-01 09:53:10', '', '2014-07-27 15:16:31', '-1', '10', '0', '0', '5', '0', '2014-08-16 01:05:20', '');
INSERT INTO `account` VALUES ('119', '', '123456', '100', '30', '', '0', '', '', '', '0', '0', '2014-08-02 12:05:21', '', '2014-07-27 15:16:31', '-1', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('120', 'thirduser', '123456', '100', '30', 'sdfsdfsfsfd', '0', '', '', '', '0', '0', '2014-08-02 14:58:32', '', '2014-07-27 15:16:31', '-1', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('121', 'thirduser', '123456', '100', '30', 'sdfsdf', '0', '', '', '', '0', '0', '2014-08-02 14:59:38', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('122', 'thirduser', '123456', '100', '30', 'sdfsdf', '0', '', '', '', '0', '0', '2014-08-02 14:59:43', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('123', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/header.jpg', '0', '', '', '', '0', '0', '2014-08-02 15:38:52', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('124', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/header.jpg', '0', '', '', '', '0', '0', '2014-08-02 15:41:08', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('125', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/header.jpg', '0', '', '', '', '0', '0', '2014-08-02 15:45:01', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('126', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/header.jpg', '0', '', '', '', '0', '0', '2014-08-02 15:45:09', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('127', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/header.jpg', '0', '', '', '', '0', '0', '2014-08-02 15:45:42', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('128', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/header.jpg', '0', '', '', '', '0', '0', '2014-08-02 15:47:31', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('129', 'thirduser', '123456', '100', '30', '12121212', '0', '', '', '', '0', '0', '2014-08-02 15:49:45', '', '2014-07-27 15:16:31', '0', '10', '0', '0', '0', '0', '1970-01-01 12:00:00', '');
INSERT INTO `account` VALUES ('130', '医院', '123456', '142', '21', 'http://www.mto2o.cn/bg/css/img/head/user.png', '0', '一点点', '18120807353', '', '0', '20', '2014-08-03 09:14:24', '', '2014-07-27 15:16:31', '0', '9', '0', '0', '16', '0', '2014-08-31 22:12:42', 'sdfsdf');
INSERT INTO `account` VALUES ('131', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/head/user.png', '0', '', '', '', '0', '0', '2014-08-10 16:01:11', '', '0001-01-01 00:00:00', '-1', '10', '0', '0', '1', '0', '2014-08-10 16:01:11', null);
INSERT INTO `account` VALUES ('134', '18950454890', '123456', '100', '20', 'http://app.mto2o.cn/bg/css/img/head/user.png', '0', '', '18950454890', '', '0', '0', '2014-08-14 21:59:51', '', '0001-01-01 00:00:00', '-1', '10', '0', '0', '1', '0', '2014-08-14 22:22:58', '');
INSERT INTO `account` VALUES ('135', '18050283546', '123456', '100', '20', 'http://app.mto2o.cn/bg/css/img/head/user.png', '0', '', '18050283546', '', '0', '0', '2014-08-14 22:09:36', '', '0001-01-01 00:00:00', '-1', '10', '0', '0', '0', '0', '0001-01-01 00:00:00', null);
INSERT INTO `account` VALUES ('136', 'thirduser', '123456', '100', '30', 'http://182.254.137.180/bg/images/head/user.png', '0', '隔壁老王', '110', '隔壁', '0', '0', '2014-08-16 22:46:16', '', '0001-01-01 00:00:00', '0', '9', '0', '0', '1', '0', '2014-08-16 22:46:16', '1111');
INSERT INTO `account` VALUES ('137', 'ssdsd', '123456', '100', '30', 'http://app.mto2o.cn/bg/File/137/image/head.jpg', '0', '', '', '', '0', '100', '2014-08-16 22:50:39', '', '0001-01-01 00:00:00', '-1', '10', '0', '0', '13', '0', '2014-08-17 14:14:32', '');
INSERT INTO `account` VALUES ('138', '林其', '123456', '100', '30', 'http://wx.qlogo.cn/mmopen/Xg0Hy1ekq3XwCCx2BEZOQhnzOC0e0KzoiadQTlaszsaWc0wxovRoyEQ45IrDicdLpX0nWHXGzXDEiay0gTeM3NBPdib3f0Kwlhia5/0', '1', '', '', '', '0', '0', '2014-08-16 22:50:46', '', '0001-01-01 00:00:00', '-1', '10', '0', '0', '1', '0', '2014-08-16 22:50:46', null);
INSERT INTO `account` VALUES ('139', '   小丑鱼', '123456', '0', '30', 'http://wx.qlogo.cn/mmopen/Xg0Hy1ekq3VIL9Ak7ZwSYbsLY6MOnTCHdicKcbSQrpqS9uBxS2wffk54Po1Be4uTMxT9bW7icvrT4HLCWRQAcdXmZ9kbsovNNa/0', '2', '', '', '', '0', '0', '2014-08-17 14:06:13', '', '0001-01-01 00:00:00', '0', '10', '0', '0', '2', '0', '2014-08-17 14:11:04', '');
INSERT INTO `account` VALUES ('140', 'merchantuser1', '111111', '0', '10', 'http://app.mto2o.cn/bg/css/img/head/user.png', '0', '', 'q', 'q', '0', '0', '2014-08-24 01:01:10', '', '0001-01-01 00:00:00', '0', '10', '0', '0', '0', '0', '0001-01-01 00:00:00', null);
INSERT INTO `account` VALUES ('141', 'merchantuser1', '111111', '0', '10', 'http://app.mto2o.cn/bg/css/img/head/user.png', '0', '', 'q', 'q', '0', '0', '2014-08-24 01:01:10', '', '0001-01-01 00:00:00', '0', '10', '0', '0', '0', '0', '0001-01-01 00:00:00', null);
INSERT INTO `account` VALUES ('142', 'merchantuser2', '111111', '0', '10', 'http://app.mto2o.cn/bg/css/img/head/user.png', '0', '', 'q', 'q', '0', '0', '2014-08-24 01:01:30', '', '0001-01-01 00:00:00', '0', '10', '0', '0', '0', '0', '0001-01-01 00:00:00', null);
INSERT INTO `account` VALUES ('143', 'merchantuser2', '111111', '0', '10', 'http://app.mto2o.cn/bg/css/img/head/user.png', '0', '', 'q', 'q', '0', '0', '2014-08-24 01:01:30', '', '0001-01-01 00:00:00', '0', '10', '0', '0', '0', '0', '0001-01-01 00:00:00', null);
INSERT INTO `account` VALUES ('144', 'merchantuser3', '111111', '0', '10', 'http://app.mto2o.cn/bg/css/img/head/user.png', '0', '', 'q', 'q', '0', '0', '2014-08-24 01:01:49', '', '0001-01-01 00:00:00', '0', '10', '0', '0', '0', '0', '0001-01-01 00:00:00', null);
INSERT INTO `account` VALUES ('145', 'merchantuser3', '111111', '0', '10', 'http://app.mto2o.cn/bg/css/img/head/user.png', '0', '', 'q', 'q', '0', '0', '2014-08-24 01:01:49', '', '0001-01-01 00:00:00', '0', '10', '0', '0', '0', '0', '0001-01-01 00:00:00', null);
INSERT INTO `account` VALUES ('146', 'merchantuser4', '111111', '0', '10', 'http://app.mto2o.cn/bg/css/img/head/user.png', '0', '', 'q', 'q', '0', '0', '2014-08-24 01:02:07', '', '0001-01-01 00:00:00', '0', '10', '0', '0', '0', '0', '0001-01-01 00:00:00', null);
INSERT INTO `account` VALUES ('147', 'merchantuser4', '111111', '0', '10', 'http://app.mto2o.cn/bg/css/img/head/user.png', '0', '', 'q', 'q', '0', '0', '2014-08-24 01:02:07', '', '0001-01-01 00:00:00', '0', '10', '0', '0', '0', '0', '0001-01-01 00:00:00', null);
INSERT INTO `account` VALUES ('148', 'xmz', '1237456', '100', '20', 'http://182.254.137.180/bg/images/head/user.png', '0', '', '13600887930', '', '0', '0', '2014-09-02 23:48:35', 'xmz', '0001-01-01 00:00:00', '0', '10', '0', '0', '1', '0', '2014-09-02 23:48:35', '');
INSERT INTO `account` VALUES ('149', '林其', '123456', '100', '30', 'http://wx.qlogo.cn/mmopen/Xg0Hy1ekq3XwCCx2BEZOQhnzOC0e0KzoiadQTlaszsaWc0wxovRoyEQ45IrDicdLpX0nWHXGzXDEiay0gTeM3NBPdib3f0Kwlhia5/0', '1', '', '', '', '0', '0', '2014-09-03 10:39:09', '', '0001-01-01 00:00:00', '0', '10', '0', '0', '6', '0', '2014-09-04 17:38:47', '');

-- ----------------------------
-- Table structure for accountbinding
-- ----------------------------
DROP TABLE IF EXISTS `accountbinding`;
CREATE TABLE `accountbinding` (
  `Id` int(11) NOT NULL default '0',
  `AccountType` int(11) default '0' COMMENT '第三方账号类型',
  `UserIdentity` varchar(30) default '' COMMENT '第三方账号标识',
  `Status` int(11) default '0' COMMENT '0正常 -1已删除',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of accountbinding
-- ----------------------------
INSERT INTO `accountbinding` VALUES ('58', '1', 'asdasdasdaa', '0');
INSERT INTO `accountbinding` VALUES ('101', '1', '1001', '0');
INSERT INTO `accountbinding` VALUES ('108', '1', '2121', '0');
INSERT INTO `accountbinding` VALUES ('111', '1', '121212xd', '0');
INSERT INTO `accountbinding` VALUES ('113', '1', '4E7B1F72FC', '0');
INSERT INTO `accountbinding` VALUES ('114', '1', '4E7B1F72FC12121', '0');
INSERT INTO `accountbinding` VALUES ('115', '1', '4E7B1F72FC1212123232', '0');
INSERT INTO `accountbinding` VALUES ('116', '1', '4E7B1F72dfgdgddd', '0');
INSERT INTO `accountbinding` VALUES ('117', '1', '4E7B1F72dfgdgdddddddddd', '0');
INSERT INTO `accountbinding` VALUES ('119', '1', '', '0');
INSERT INTO `accountbinding` VALUES ('120', '1', 'sdfsdfsdfsd', '0');
INSERT INTO `accountbinding` VALUES ('121', '1', '1002', '0');
INSERT INTO `accountbinding` VALUES ('124', '1', '1003', '0');
INSERT INTO `accountbinding` VALUES ('127', '1', '1005', '0');
INSERT INTO `accountbinding` VALUES ('128', '1', '1006', '0');
INSERT INTO `accountbinding` VALUES ('129', '1', 'sdsdsd', '0');
INSERT INTO `accountbinding` VALUES ('131', '1', 'sdfsfs', '-1');
INSERT INTO `accountbinding` VALUES ('136', '1', '1001sdfsd', '0');
INSERT INTO `accountbinding` VALUES ('137', '1', 'oYDWXt56ukQ9YaJjAKc8wuaP3fIc', '-1');
INSERT INTO `accountbinding` VALUES ('138', '1', 'oYDWXt56ukQ9YaJjAKc8wuaP3fIcdd', '-1');
INSERT INTO `accountbinding` VALUES ('139', '1', 'oYDWXt6goM-F7ez7UDHfeYHCVdx4', '0');
INSERT INTO `accountbinding` VALUES ('149', '1', 'oYDWXt56ukQ9YaJjAKc8wuaP3fIc', '0');
INSERT INTO `accountbinding` VALUES ('305', '1', '1212121', '0');

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
  `Commentnum` int(11) default '0' COMMENT '评论数量，冗余',
  `Description` varchar(2000) collate utf8_unicode_ci default NULL,
  `CouponId` int(11) default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of active
-- ----------------------------
INSERT INTO `active` VALUES ('18', '100', '0', '测试', '测试', '2014-09-04 11:54:36', '/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0(2).jpg', '0', '0', '测试', '1');

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement` (
  `Id` int(11) NOT NULL auto_increment,
  `Content` varchar(1000) default NULL,
  `CreateTime` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of announcement
-- ----------------------------
INSERT INTO `announcement` VALUES ('3', '1111111111111111', '2014-09-02 17:34:14');

-- ----------------------------
-- Table structure for boxtype
-- ----------------------------
DROP TABLE IF EXISTS `boxtype`;
CREATE TABLE `boxtype` (
  `Id` int(11) NOT NULL auto_increment,
  `Title` varchar(1000) NOT NULL,
  `Lowest` int(11) NOT NULL,
  `HoldNum` int(11) NOT NULL,
  `CreateTime` datetime default NULL,
  `SellerId` int(11) NOT NULL default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of boxtype
-- ----------------------------
INSERT INTO `boxtype` VALUES ('1', '小包', '100', '5', '2014-08-24 15:30:20', '100');
INSERT INTO `boxtype` VALUES ('2', '中包', '500', '10', '2014-08-24 15:30:36', '100');
INSERT INTO `boxtype` VALUES ('3', '大包', '1000', '20', '2014-08-24 15:31:15', '142');
INSERT INTO `boxtype` VALUES ('4', '小包', '100', '5', '2014-08-24 15:31:26', '142');
INSERT INTO `boxtype` VALUES ('5', '中包', '500', '10', '2014-08-24 15:31:38', '142');

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
  `Status` int(11) default '0' COMMENT '充值状态 0：充值请求、10：充值成功、-1：充值失败',
  `UpdateStatusTime` datetime default '1970-01-01 00:00:00' COMMENT '更新状态时间',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chargelog
-- ----------------------------
INSERT INTO `chargelog` VALUES ('1', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:05:35', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('2', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:42', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('3', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:44', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('4', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:45', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('5', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:46', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('6', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:46', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('7', '100', '3', '100', '1', '余额支付', '1', '2014-07-18 14:53:47', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('8', '100', '3', '100', '1', '余额支付', '1', '2014-07-23 16:53:09', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('9', '100', '3', '100', '1', '余额支付', '1', '2014-07-26 20:58:13', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('10', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:01:06', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('11', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:01:08', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('12', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:01:09', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('13', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:01:09', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('14', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:01:10', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('15', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:01:10', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('16', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:02:11', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('17', '100', '3', '-66', '1', '账户余额', '11', '2014-07-29 23:05:13', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('18', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:07:18', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('19', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:07:29', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('20', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:07:55', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('21', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:08:19', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('22', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:08:25', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('23', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:08:26', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('24', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:08:26', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('25', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:08:27', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('26', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:08:53', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('27', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:09:09', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('28', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:10:46', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('29', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:10:47', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('30', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:10:47', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('31', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:11:50', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('32', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:13:51', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('33', '100', '3', '-10', '1', '账户余额', '10', '2014-07-29 23:17:35', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('34', '100', '3', '-62', '1', '账户余额', '9', '2014-07-29 23:19:05', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('35', '100', '3', '-66', '1', '账户余额', '11', '2014-07-31 23:42:33', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('36', '100', '3', '100', '1', '余额支付', '1', '2014-08-02 12:36:30', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('37', '100', '3', '-10', '1', '账户余额', '24', '2014-08-02 18:04:56', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('38', '100', '3', '-10', '1', '账户余额', '26', '2014-08-02 18:17:52', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('39', '100', '3', '-20', '1', '账户余额', '69', '2014-08-03 16:42:44', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('40', '100', '3', '-10', '1', '账户余额', '71', '2014-08-03 17:04:52', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('41', '100', '3', '-10', '1', '账户余额', '94', '2014-08-04 09:36:37', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('42', '100', '3', '-12', '1', '账户余额', '174', '2014-08-12 00:31:38', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('43', '100', '3', '-10', '1', '账户余额', '178', '2014-08-12 00:33:27', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('44', '100', '3', '-10', '1', '账户余额', '195', '2014-08-12 16:56:04', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('45', '100', '3', '100', '1', '余额支付', '1', '2014-08-27 00:14:17', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('46', '100', '3', '100', '1', '余额支付', '1', '2014-09-02 20:47:37', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('47', '100', '3', '100', '1', '余额支付', '', '2014-09-02 20:48:09', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('48', '100', '3', '100', '1', '余额支付', '', '2014-09-02 23:15:35', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('49', '100', '102', '-32', '0', '账户余额', '597', '2014-09-02 23:47:20', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('50', '100', '102', '-28', '0', '账户余额', '598', '2014-09-02 23:48:01', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('51', '100', '102', '-17', '0', '账户余额', '596', '2014-09-02 23:48:13', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('52', '100', '102', '-38', '0', '账户余额', '600', '2014-09-02 23:54:16', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('53', '100', '102', '-49', '0', '账户余额', '601', '2014-09-02 23:57:29', '0', '1970-01-01 00:00:00');
INSERT INTO `chargelog` VALUES ('54', '100', '102', '-17', '0', '账户余额', '603', '2014-09-03 00:05:22', '0', '1970-01-01 00:00:00');

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
  `Feedback` varchar(1000) collate utf8_unicode_ci default NULL COMMENT '评论回复',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=431 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('2', '100', '3', '1', '好吃呀', '4', '', '', '2014-07-07 23:35:45', null);
INSERT INTO `comment` VALUES ('3', '100', '3', '1', '好好吃哦', '5', '', '', '2014-07-08 23:35:41', null);
INSERT INTO `comment` VALUES ('7', '100', '2', '1', '测试', '1', '', '', '2014-07-09 00:32:00', null);
INSERT INTO `comment` VALUES ('9', '100', '3', '2', '好吃呀', '4', '', '', '2014-07-07 23:35:45', null);
INSERT INTO `comment` VALUES ('10', '100', '3', '2', '好好吃哦', '5', '', '', '2014-07-08 23:35:41', null);
INSERT INTO `comment` VALUES ('12', '100', '3', '4', '好吃呀', '4', '', '', '2014-07-07 23:35:45', null);
INSERT INTO `comment` VALUES ('13', '100', '3', '5', '好好吃哦', '5', '', '', '2014-07-08 23:35:41', null);
INSERT INTO `comment` VALUES ('15', '100', '3', '7', '好吃呀', '4', '', '', '2014-07-07 23:35:45', null);
INSERT INTO `comment` VALUES ('16', '100', '3', '8', '好好吃哦', '5', '', '', '2014-07-08 23:35:41', null);
INSERT INTO `comment` VALUES ('18', '100', '3', '9', '好吃呀', '4', '', '', '2014-07-07 23:35:45', null);
INSERT INTO `comment` VALUES ('19', '100', '3', '9', '好好吃哦', '5', '', '', '2014-07-08 23:35:41', null);
INSERT INTO `comment` VALUES ('20', '100', '3', '1', '不错哦', '1', '', '', '2014-07-10 12:11:44', null);
INSERT INTO `comment` VALUES ('21', '100', '3', '1', '不错哦', '1', '', '', '2014-07-10 12:29:24', null);
INSERT INTO `comment` VALUES ('22', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 10:27:44', null);
INSERT INTO `comment` VALUES ('23', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 17:57:35', null);
INSERT INTO `comment` VALUES ('24', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 17:57:47', null);
INSERT INTO `comment` VALUES ('25', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 17:58:20', null);
INSERT INTO `comment` VALUES ('26', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 18:00:26', null);
INSERT INTO `comment` VALUES ('27', '100', '3', '1', '不错哦', '1', '', '', '2014-07-11 18:05:48', null);
INSERT INTO `comment` VALUES ('28', '100', '3', '1', '不错哦', '1', '', '', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('29', '100', '3', '1', '不错哦', '1', '', '', '2014-07-12 21:49:22', null);
INSERT INTO `comment` VALUES ('30', '100', '3', '1', '不错哦', '1', '', '', '2014-07-16 21:00:15', null);
INSERT INTO `comment` VALUES ('31', '100', '3', '1', '不错哦dddddddd', '1', '', '', '2014-07-16 21:00:34', null);
INSERT INTO `comment` VALUES ('32', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:00', null);
INSERT INTO `comment` VALUES ('33', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:01', null);
INSERT INTO `comment` VALUES ('34', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:02', null);
INSERT INTO `comment` VALUES ('35', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:02', null);
INSERT INTO `comment` VALUES ('36', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:03', null);
INSERT INTO `comment` VALUES ('37', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:04', null);
INSERT INTO `comment` VALUES ('38', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:04', null);
INSERT INTO `comment` VALUES ('39', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:05', null);
INSERT INTO `comment` VALUES ('40', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:06', null);
INSERT INTO `comment` VALUES ('41', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:06', null);
INSERT INTO `comment` VALUES ('42', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:07', null);
INSERT INTO `comment` VALUES ('43', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:07', null);
INSERT INTO `comment` VALUES ('44', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:08', null);
INSERT INTO `comment` VALUES ('45', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:09', null);
INSERT INTO `comment` VALUES ('46', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:09', null);
INSERT INTO `comment` VALUES ('47', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:10', null);
INSERT INTO `comment` VALUES ('48', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:10', null);
INSERT INTO `comment` VALUES ('49', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:11', null);
INSERT INTO `comment` VALUES ('50', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:11', null);
INSERT INTO `comment` VALUES ('51', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:12', null);
INSERT INTO `comment` VALUES ('52', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:12', null);
INSERT INTO `comment` VALUES ('53', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:13', null);
INSERT INTO `comment` VALUES ('54', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:13', null);
INSERT INTO `comment` VALUES ('55', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:14', null);
INSERT INTO `comment` VALUES ('56', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:15', null);
INSERT INTO `comment` VALUES ('57', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:15', null);
INSERT INTO `comment` VALUES ('58', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:16', null);
INSERT INTO `comment` VALUES ('59', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:16', null);
INSERT INTO `comment` VALUES ('60', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:17', null);
INSERT INTO `comment` VALUES ('61', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:18', null);
INSERT INTO `comment` VALUES ('62', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:18', null);
INSERT INTO `comment` VALUES ('63', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:19', null);
INSERT INTO `comment` VALUES ('64', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:07:19', null);
INSERT INTO `comment` VALUES ('65', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:26', null);
INSERT INTO `comment` VALUES ('66', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:27', null);
INSERT INTO `comment` VALUES ('67', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:28', null);
INSERT INTO `comment` VALUES ('68', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:28', null);
INSERT INTO `comment` VALUES ('69', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:35', null);
INSERT INTO `comment` VALUES ('70', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:35', null);
INSERT INTO `comment` VALUES ('71', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:36', null);
INSERT INTO `comment` VALUES ('72', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:36', null);
INSERT INTO `comment` VALUES ('73', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:37', null);
INSERT INTO `comment` VALUES ('74', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:37', null);
INSERT INTO `comment` VALUES ('75', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:38', null);
INSERT INTO `comment` VALUES ('76', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:38', null);
INSERT INTO `comment` VALUES ('77', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:39', null);
INSERT INTO `comment` VALUES ('78', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:39', null);
INSERT INTO `comment` VALUES ('79', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:40', null);
INSERT INTO `comment` VALUES ('80', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:41', null);
INSERT INTO `comment` VALUES ('81', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:41', null);
INSERT INTO `comment` VALUES ('82', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:41', null);
INSERT INTO `comment` VALUES ('83', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:42', null);
INSERT INTO `comment` VALUES ('84', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:42', null);
INSERT INTO `comment` VALUES ('85', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:42', null);
INSERT INTO `comment` VALUES ('86', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:42', null);
INSERT INTO `comment` VALUES ('87', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:43', null);
INSERT INTO `comment` VALUES ('88', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:43', null);
INSERT INTO `comment` VALUES ('89', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:43', null);
INSERT INTO `comment` VALUES ('90', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:43', null);
INSERT INTO `comment` VALUES ('91', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44', null);
INSERT INTO `comment` VALUES ('92', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44', null);
INSERT INTO `comment` VALUES ('93', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44', null);
INSERT INTO `comment` VALUES ('94', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44', null);
INSERT INTO `comment` VALUES ('95', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44', null);
INSERT INTO `comment` VALUES ('96', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:44', null);
INSERT INTO `comment` VALUES ('97', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:45', null);
INSERT INTO `comment` VALUES ('98', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:45', null);
INSERT INTO `comment` VALUES ('99', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:45', null);
INSERT INTO `comment` VALUES ('100', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:45', null);
INSERT INTO `comment` VALUES ('101', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:46', null);
INSERT INTO `comment` VALUES ('102', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:46', null);
INSERT INTO `comment` VALUES ('103', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:46', null);
INSERT INTO `comment` VALUES ('104', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:47', null);
INSERT INTO `comment` VALUES ('105', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:47', null);
INSERT INTO `comment` VALUES ('106', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:47', null);
INSERT INTO `comment` VALUES ('107', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:47', null);
INSERT INTO `comment` VALUES ('108', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:47', null);
INSERT INTO `comment` VALUES ('109', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:48', null);
INSERT INTO `comment` VALUES ('110', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:48', null);
INSERT INTO `comment` VALUES ('111', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:48', null);
INSERT INTO `comment` VALUES ('112', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:48', null);
INSERT INTO `comment` VALUES ('113', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:49', null);
INSERT INTO `comment` VALUES ('114', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:49', null);
INSERT INTO `comment` VALUES ('115', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:49', null);
INSERT INTO `comment` VALUES ('116', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:50', null);
INSERT INTO `comment` VALUES ('117', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:50', null);
INSERT INTO `comment` VALUES ('118', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:50', null);
INSERT INTO `comment` VALUES ('119', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:50', null);
INSERT INTO `comment` VALUES ('120', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:50', null);
INSERT INTO `comment` VALUES ('121', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:51', null);
INSERT INTO `comment` VALUES ('122', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:51', null);
INSERT INTO `comment` VALUES ('123', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:51', null);
INSERT INTO `comment` VALUES ('124', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:51', null);
INSERT INTO `comment` VALUES ('125', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:51', null);
INSERT INTO `comment` VALUES ('126', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:52', null);
INSERT INTO `comment` VALUES ('127', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:52', null);
INSERT INTO `comment` VALUES ('128', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:53', null);
INSERT INTO `comment` VALUES ('129', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:53', null);
INSERT INTO `comment` VALUES ('130', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:53', null);
INSERT INTO `comment` VALUES ('131', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:54', null);
INSERT INTO `comment` VALUES ('132', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:54', null);
INSERT INTO `comment` VALUES ('133', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:54', null);
INSERT INTO `comment` VALUES ('134', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:55', null);
INSERT INTO `comment` VALUES ('135', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:55', null);
INSERT INTO `comment` VALUES ('136', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:56', null);
INSERT INTO `comment` VALUES ('137', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:56', null);
INSERT INTO `comment` VALUES ('138', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:56', null);
INSERT INTO `comment` VALUES ('139', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:57', null);
INSERT INTO `comment` VALUES ('140', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:57', null);
INSERT INTO `comment` VALUES ('141', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:57', null);
INSERT INTO `comment` VALUES ('142', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:57', null);
INSERT INTO `comment` VALUES ('143', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:57', null);
INSERT INTO `comment` VALUES ('144', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:58', null);
INSERT INTO `comment` VALUES ('145', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:58', null);
INSERT INTO `comment` VALUES ('146', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:58', null);
INSERT INTO `comment` VALUES ('147', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:58', null);
INSERT INTO `comment` VALUES ('148', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:59', null);
INSERT INTO `comment` VALUES ('149', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:59', null);
INSERT INTO `comment` VALUES ('150', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:59', null);
INSERT INTO `comment` VALUES ('151', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:08:59', null);
INSERT INTO `comment` VALUES ('152', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:00', null);
INSERT INTO `comment` VALUES ('153', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:00', null);
INSERT INTO `comment` VALUES ('154', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:00', null);
INSERT INTO `comment` VALUES ('155', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:00', null);
INSERT INTO `comment` VALUES ('156', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:01', null);
INSERT INTO `comment` VALUES ('157', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:01', null);
INSERT INTO `comment` VALUES ('158', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:01', null);
INSERT INTO `comment` VALUES ('159', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:01', null);
INSERT INTO `comment` VALUES ('160', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:02', null);
INSERT INTO `comment` VALUES ('161', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:02', null);
INSERT INTO `comment` VALUES ('162', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:02', null);
INSERT INTO `comment` VALUES ('163', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:02', null);
INSERT INTO `comment` VALUES ('164', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:02', null);
INSERT INTO `comment` VALUES ('165', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:03', null);
INSERT INTO `comment` VALUES ('166', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:03', null);
INSERT INTO `comment` VALUES ('167', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:03', null);
INSERT INTO `comment` VALUES ('168', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:03', null);
INSERT INTO `comment` VALUES ('169', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:04', null);
INSERT INTO `comment` VALUES ('170', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:04', null);
INSERT INTO `comment` VALUES ('171', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:04', null);
INSERT INTO `comment` VALUES ('172', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:05', null);
INSERT INTO `comment` VALUES ('173', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:05', null);
INSERT INTO `comment` VALUES ('174', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:05', null);
INSERT INTO `comment` VALUES ('175', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:05', null);
INSERT INTO `comment` VALUES ('176', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:06', null);
INSERT INTO `comment` VALUES ('177', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:06', null);
INSERT INTO `comment` VALUES ('178', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:06', null);
INSERT INTO `comment` VALUES ('179', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:06', null);
INSERT INTO `comment` VALUES ('180', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:07', null);
INSERT INTO `comment` VALUES ('181', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:07', null);
INSERT INTO `comment` VALUES ('182', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:07', null);
INSERT INTO `comment` VALUES ('183', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:07', null);
INSERT INTO `comment` VALUES ('184', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:07', null);
INSERT INTO `comment` VALUES ('185', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:08', null);
INSERT INTO `comment` VALUES ('186', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:08', null);
INSERT INTO `comment` VALUES ('187', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:08', null);
INSERT INTO `comment` VALUES ('188', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:08', null);
INSERT INTO `comment` VALUES ('189', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:09', null);
INSERT INTO `comment` VALUES ('190', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:09', null);
INSERT INTO `comment` VALUES ('191', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:09', null);
INSERT INTO `comment` VALUES ('192', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:10', null);
INSERT INTO `comment` VALUES ('193', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:10', null);
INSERT INTO `comment` VALUES ('194', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:10', null);
INSERT INTO `comment` VALUES ('195', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:10', null);
INSERT INTO `comment` VALUES ('196', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:11', null);
INSERT INTO `comment` VALUES ('197', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:11', null);
INSERT INTO `comment` VALUES ('198', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:11', null);
INSERT INTO `comment` VALUES ('199', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:11', null);
INSERT INTO `comment` VALUES ('200', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:12', null);
INSERT INTO `comment` VALUES ('201', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:12', null);
INSERT INTO `comment` VALUES ('202', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:12', null);
INSERT INTO `comment` VALUES ('203', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:13', null);
INSERT INTO `comment` VALUES ('204', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-18 14:09:13', null);
INSERT INTO `comment` VALUES ('205', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:22', null);
INSERT INTO `comment` VALUES ('206', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:27', null);
INSERT INTO `comment` VALUES ('207', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:28', null);
INSERT INTO `comment` VALUES ('208', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:28', null);
INSERT INTO `comment` VALUES ('209', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:29', null);
INSERT INTO `comment` VALUES ('210', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 08:56:30', null);
INSERT INTO `comment` VALUES ('217', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('218', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('219', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('220', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('221', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('222', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('223', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('224', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('225', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('226', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('227', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('228', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('229', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('230', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('231', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('232', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('233', '100', '1', '1', '好好吃哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-12 19:34:43', null);
INSERT INTO `comment` VALUES ('235', '0', '2', '10', '', '22123', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-20 17:10:57', null);
INSERT INTO `comment` VALUES ('236', '0', '2', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-20 17:11:05', null);
INSERT INTO `comment` VALUES ('242', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '榨菜肉丝', '2014-07-20 17:45:28', null);
INSERT INTO `comment` VALUES ('244', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-20 17:47:59', null);
INSERT INTO `comment` VALUES ('245', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 17:53:25', null);
INSERT INTO `comment` VALUES ('246', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 19:06:12', null);
INSERT INTO `comment` VALUES ('247', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 20:41:07', null);
INSERT INTO `comment` VALUES ('248', '100', '1', '1', 'sdfsdfsdfdsfsd', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 20:41:35', null);
INSERT INTO `comment` VALUES ('250', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 20:45:59', null);
INSERT INTO `comment` VALUES ('251', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-20 20:46:00', null);
INSERT INTO `comment` VALUES ('252', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-20 22:14:31', null);
INSERT INTO `comment` VALUES ('253', '0', '2', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 14:04:01', null);
INSERT INTO `comment` VALUES ('254', '0', '2', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 17:10:50', null);
INSERT INTO `comment` VALUES ('255', '0', '2', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 17:11:08', null);
INSERT INTO `comment` VALUES ('256', '0', '2', '1', '12121', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 18:08:19', null);
INSERT INTO `comment` VALUES ('257', '0', '2', '1', '12121', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 18:11:46', null);
INSERT INTO `comment` VALUES ('258', '100', '4', '1', '12121', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-22 18:25:30', null);
INSERT INTO `comment` VALUES ('259', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-23 16:58:25', null);
INSERT INTO `comment` VALUES ('260', '0', '1', '0', '', '3', null, null, '2014-07-23 18:45:49', null);
INSERT INTO `comment` VALUES ('261', '0', '1', '0', 'sdfsdfsdf', '3', null, null, '2014-07-25 17:55:13', null);
INSERT INTO `comment` VALUES ('262', '0', '1', '0', 'sfsdfsdf', '3', null, null, '2014-07-25 17:56:35', null);
INSERT INTO `comment` VALUES ('263', '0', '1', '0', '11111', '3', null, null, '2014-07-25 18:00:39', null);
INSERT INTO `comment` VALUES ('264', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-25 18:03:10', null);
INSERT INTO `comment` VALUES ('265', '0', '4', '0', '', '3', null, null, '2014-07-25 18:04:42', null);
INSERT INTO `comment` VALUES ('266', '100', '4', '1', 'sdfsdfsdf', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-25 18:05:03', null);
INSERT INTO `comment` VALUES ('267', '100', '4', '1', 'sdfsdfsdf', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-25 18:09:18', null);
INSERT INTO `comment` VALUES ('268', '100', '4', '1', 'sdfsdfs', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-25 18:12:12', null);
INSERT INTO `comment` VALUES ('269', '100', '4', '1', 'dfsdfsdf', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '优惠券测试', '2014-07-25 18:12:23', null);
INSERT INTO `comment` VALUES ('270', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-25 18:20:37', null);
INSERT INTO `comment` VALUES ('271', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-25 18:20:51', null);
INSERT INTO `comment` VALUES ('272', '0', '4', '0', '', '3', null, null, '2014-07-25 18:45:11', null);
INSERT INTO `comment` VALUES ('273', '0', '4', '0', '11111sdfsdf', '3', null, null, '2014-07-25 18:45:16', null);
INSERT INTO `comment` VALUES ('274', '0', '4', '0', '', '3', null, null, '2014-07-25 19:22:16', null);
INSERT INTO `comment` VALUES ('275', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-25 21:13:25', null);
INSERT INTO `comment` VALUES ('276', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-25 22:26:11', null);
INSERT INTO `comment` VALUES ('277', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-25 22:26:21', null);
INSERT INTO `comment` VALUES ('278', '100', '2', '1', 'sdfsdfsd', '3', null, '资讯测试', '2014-07-25 22:26:36', null);
INSERT INTO `comment` VALUES ('279', '100', '2', '2', '好斤斤计较', '103', null, '资讯测试', '2014-07-27 08:49:46', null);
INSERT INTO `comment` VALUES ('280', '100', '2', '1', '图哈哈哈', '103', null, '资讯测试', '2014-07-27 09:06:12', null);
INSERT INTO `comment` VALUES ('281', '100', '2', '1', '图哈哈哈', '103', null, '资讯测试', '2014-07-27 09:06:30', null);
INSERT INTO `comment` VALUES ('282', '100', '2', '1', '躺一会', '103', null, '资讯测试', '2014-07-27 09:34:36', null);
INSERT INTO `comment` VALUES ('283', '100', '2', '2', '11111', '103', null, '资讯测试', '2014-07-27 09:37:01', null);
INSERT INTO `comment` VALUES ('284', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 09:56:40', null);
INSERT INTO `comment` VALUES ('285', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 09:56:40', null);
INSERT INTO `comment` VALUES ('286', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 09:58:43', null);
INSERT INTO `comment` VALUES ('287', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 09:59:34', null);
INSERT INTO `comment` VALUES ('288', '100', '1', '1', '干活回家', '103', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 10:07:59', null);
INSERT INTO `comment` VALUES ('289', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 10:11:53', null);
INSERT INTO `comment` VALUES ('290', '100', '1', '1', '???��??', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 10:47:36', null);
INSERT INTO `comment` VALUES ('291', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 11:26:58', null);
INSERT INTO `comment` VALUES ('292', '100', '1', '1', '不错', '3', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_01.png', '飞翔的赶脚', '2014-07-27 19:01:03', null);
INSERT INTO `comment` VALUES ('293', '100', '2', '1', '111', '102', null, '资讯测试', '2014-07-27 21:18:26', null);
INSERT INTO `comment` VALUES ('294', '100', '2', '12', '111', '102', null, '资讯测试', '2014-07-27 21:19:12', null);
INSERT INTO `comment` VALUES ('295', '100', '1', '6', '111', '102', 'http://182.254.137.180/bg/images/merchant/100/kulouwenhua_06.png', 'high起来', '2014-07-27 21:20:51', null);
INSERT INTO `comment` VALUES ('296', '100', '2', '7', '111', '107', null, '资讯测试', '2014-07-27 21:23:23', null);
INSERT INTO `comment` VALUES ('297', '100', '2', '3', '111', '107', null, 'test', '2014-07-27 21:25:27', null);
INSERT INTO `comment` VALUES ('298', '100', '2', '3', '？', '107', null, 'test', '2014-07-28 00:14:36', null);
INSERT INTO `comment` VALUES ('301', '0', '4', '0', '考虑考虑', '118', null, null, '2014-08-02 13:54:01', null);
INSERT INTO `comment` VALUES ('302', '0', '4', '0', '哈哈哈', '118', null, null, '2014-08-02 14:41:24', null);
INSERT INTO `comment` VALUES ('303', '0', '4', '0', '哈哈', '118', null, null, '2014-08-02 14:42:40', null);
INSERT INTO `comment` VALUES ('304', '100', '2', '2', 'sdfsdfsd', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 14:43:25', null);
INSERT INTO `comment` VALUES ('305', '100', '2', '2', 'sdfsdfsd', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 14:43:27', null);
INSERT INTO `comment` VALUES ('306', '100', '2', '2', 'sdfsdfsd', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 14:43:28', null);
INSERT INTO `comment` VALUES ('307', '100', '2', '1', 'sdfsdfsd', '3', '', '资讯测试', '2014-08-02 16:07:03', null);
INSERT INTO `comment` VALUES ('308', '100', '2', '2', 'vvvxcvxcvsdf', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:09:43', null);
INSERT INTO `comment` VALUES ('309', '100', '2', '2', '哈哈哈', '118', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:15:18', null);
INSERT INTO `comment` VALUES ('310', '100', '2', '2', '啊啊啊', '118', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:15:29', null);
INSERT INTO `comment` VALUES ('311', '100', '2', '2', '呃呃呃', '118', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:15:47', null);
INSERT INTO `comment` VALUES ('312', '100', '2', '5', '接口', '118', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:16:05', null);
INSERT INTO `comment` VALUES ('313', '100', '2', '5', '哈哈哈哈', '118', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:16:24', null);
INSERT INTO `comment` VALUES ('314', '100', '2', '5', '兔兔', '118', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:16:37', null);
INSERT INTO `comment` VALUES ('316', '100', '2', '2', 'dfsdfsdfsdf', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:27:28', null);
INSERT INTO `comment` VALUES ('317', '100', '2', '2', 'sfsdfsdf', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:29:06', null);
INSERT INTO `comment` VALUES ('318', '100', '2', '2', 'sdsdsds', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:30:18', null);
INSERT INTO `comment` VALUES ('319', '100', '2', '6', '了解了', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:31:57', null);
INSERT INTO `comment` VALUES ('320', '100', '2', '9', '接口', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:32:07', null);
INSERT INTO `comment` VALUES ('321', '100', '2', '9', '解决', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-02 16:32:13', null);
INSERT INTO `comment` VALUES ('322', '100', '1', '1', '解决', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-02 16:46:22', null);
INSERT INTO `comment` VALUES ('323', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-02 16:47:13', null);
INSERT INTO `comment` VALUES ('324', '100', '1', '1', 'dfsdfsdf', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-02 16:47:32', null);
INSERT INTO `comment` VALUES ('325', '100', '1', '1', 'sdsdsd', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-02 16:47:50', null);
INSERT INTO `comment` VALUES ('326', '100', '1', '1', 'sdfsdfsdf', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-02 16:48:15', null);
INSERT INTO `comment` VALUES ('327', '100', '1', '1', 'sdfsdfs', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-02 16:48:21', null);
INSERT INTO `comment` VALUES ('328', '100', '1', '1', '吧', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-02 16:51:23', null);
INSERT INTO `comment` VALUES ('329', '100', '1', '1', 'sdfdfs', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-02 16:51:44', null);
INSERT INTO `comment` VALUES ('330', '100', '1', '1', 'sdfsdfs', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-02 16:53:21', null);
INSERT INTO `comment` VALUES ('332', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '榨菜肉丝', '2014-08-02 17:03:06', null);
INSERT INTO `comment` VALUES ('333', '100', '3', '1', 'sdfsdfsdf', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '榨菜肉丝', '2014-08-02 17:06:30', null);
INSERT INTO `comment` VALUES ('334', '100', '3', '2', 'sdfsdfsfds', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-02 17:11:57', null);
INSERT INTO `comment` VALUES ('335', '100', '3', '2', 'fsfssfd', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-02 17:14:24', null);
INSERT INTO `comment` VALUES ('336', '100', '3', '2', 'sdfsdfs', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-02 17:14:30', null);
INSERT INTO `comment` VALUES ('337', '100', '3', '2', 'ssss', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-02 17:15:51', null);
INSERT INTO `comment` VALUES ('338', '100', '3', '2', 'ss', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-02 17:16:53', null);
INSERT INTO `comment` VALUES ('339', '100', '3', '2', 'sssss', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-02 17:17:24', null);
INSERT INTO `comment` VALUES ('340', '100', '3', '2', 'sdfsdfs', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-02 17:17:27', null);
INSERT INTO `comment` VALUES ('341', '100', '3', '2', 'sdfsdfsd', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-02 17:18:41', null);
INSERT INTO `comment` VALUES ('342', '100', '3', '2', 'dsfsdfsdf', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-02 17:19:18', null);
INSERT INTO `comment` VALUES ('343', '100', '3', '2', 'sdfsdfsdf', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-02 17:19:47', null);
INSERT INTO `comment` VALUES ('344', '100', '3', '2', 'sdfsdfsdf', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-02 17:20:19', null);
INSERT INTO `comment` VALUES ('345', '100', '3', '3', 'ssss', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '目鱼筒骨', '2014-08-02 17:23:21', null);
INSERT INTO `comment` VALUES ('346', '100', '3', '3', 'sdfsdf', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '目鱼筒骨', '2014-08-02 17:23:50', null);
INSERT INTO `comment` VALUES ('347', '100', '3', '3', 'sdfsdfs', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '目鱼筒骨', '2014-08-02 17:24:08', null);
INSERT INTO `comment` VALUES ('348', '100', '3', '3', 'dfsdfs', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '目鱼筒骨', '2014-08-02 17:24:51', null);
INSERT INTO `comment` VALUES ('349', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-02 21:29:45', null);
INSERT INTO `comment` VALUES ('350', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-02 21:29:54', null);
INSERT INTO `comment` VALUES ('351', '100', '3', '1', '不错哦', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '榨菜肉丝', '2014-08-02 22:16:16', null);
INSERT INTO `comment` VALUES ('352', '100', '4', '1', 'sdfsdfsdf', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-02 22:32:47', null);
INSERT INTO `comment` VALUES ('353', '100', '4', '2', 'dfs', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-02 22:32:58', null);
INSERT INTO `comment` VALUES ('354', '100', '4', '2', 'dddd', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-02 22:33:02', null);
INSERT INTO `comment` VALUES ('355', '100', '4', '3', '啊啊啊', '118', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-02 22:34:26', null);
INSERT INTO `comment` VALUES ('356', '100', '4', '3', '拉出来', '118', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-02 22:34:46', null);
INSERT INTO `comment` VALUES ('359', '100', '4', '1', '11111', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-02 22:40:50', null);
INSERT INTO `comment` VALUES ('361', '100', '2', '2', '接口', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-03 16:32:37', null);
INSERT INTO `comment` VALUES ('362', '100', '2', '12', '吧', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-03 16:33:02', null);
INSERT INTO `comment` VALUES ('363', '100', '2', '12', '哈哈', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-03 16:38:11', null);
INSERT INTO `comment` VALUES ('365', '100', '2', '8', '哈哈哈', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-03 20:21:16', null);
INSERT INTO `comment` VALUES ('366', '100', '3', '29', '提高', '3', '/bg/File/100/image/goods/20140730/Koala.jpg', '新增商品', '2014-08-03 20:38:25', null);
INSERT INTO `comment` VALUES ('374', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-07 22:36:26', null);
INSERT INTO `comment` VALUES ('375', '100', '3', '2', '了解了', '102', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-10 17:12:04', null);
INSERT INTO `comment` VALUES ('376', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-10 17:13:44', null);
INSERT INTO `comment` VALUES ('377', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-10 17:13:47', null);
INSERT INTO `comment` VALUES ('378', '100', '1', '4', '了解了', '102', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '热火嗨', '2014-08-10 17:14:00', null);
INSERT INTO `comment` VALUES ('379', '100', '1', '4', '了解了', '102', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '热火嗨', '2014-08-10 17:14:08', null);
INSERT INTO `comment` VALUES ('381', '100', '1', '2', '了解了', '102', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_02.png', '玉溪', '2014-08-10 17:14:30', null);
INSERT INTO `comment` VALUES ('382', '100', '2', '5', '哥哥呵呵', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-11 21:34:06', null);
INSERT INTO `comment` VALUES ('383', '100', '2', '1', '呵呵叫姐姐', '3', '', '资讯测试', '2014-08-11 23:46:12', null);
INSERT INTO `comment` VALUES ('384', '100', '3', '1', '感觉姐姐', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '榨菜肉丝', '2014-08-11 23:46:28', null);
INSERT INTO `comment` VALUES ('385', '100', '2', '6', '了解了', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-12 00:32:43', null);
INSERT INTO `comment` VALUES ('386', '100', '2', '12', '了解了', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-12 00:46:00', null);
INSERT INTO `comment` VALUES ('387', '100', '2', '2', '了解了', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-12 01:00:11', null);
INSERT INTO `comment` VALUES ('388', '100', '1', '1', '额打开', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-12 11:28:10', null);
INSERT INTO `comment` VALUES ('389', '100', '2', '2', '经理', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-12 12:10:40', null);
INSERT INTO `comment` VALUES ('390', '100', '2', '2', '经理', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-12 12:10:41', null);
INSERT INTO `comment` VALUES ('391', '100', '2', '2', '我是', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-12 16:49:23', null);
INSERT INTO `comment` VALUES ('392', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-12 21:25:43', null);
INSERT INTO `comment` VALUES ('393', '100', '1', '10', '1111', '118', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_10.png', '好吧', '2014-08-13 22:10:00', null);
INSERT INTO `comment` VALUES ('394', '100', '2', '10', 'ssss', '137', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-17 12:55:02', null);
INSERT INTO `comment` VALUES ('395', '100', '2', '11', '哈哈', '137', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-17 12:56:30', null);
INSERT INTO `comment` VALUES ('396', '100', '2', '6', 'aaaa', '137', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-17 12:57:22', null);
INSERT INTO `comment` VALUES ('397', '100', '3', '8', '哈哈', '137', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '馒头', '2014-08-17 13:02:28', null);
INSERT INTO `comment` VALUES ('398', '100', '2', '6', '好多好多胡椒粉', '137', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '资讯测试', '2014-08-17 15:32:20', null);
INSERT INTO `comment` VALUES ('399', '100', '3', '10', '斑斑驳驳', '137', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '套餐2', '2014-08-17 15:38:14', null);
INSERT INTO `comment` VALUES ('400', '100', '3', '1', 'xxxxxx', '137', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '榨菜肉丝1', '2014-08-17 16:12:42', null);
INSERT INTO `comment` VALUES ('401', '100', '1', '10', '点点滴滴', '137', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_10.png', '好吧', '2014-08-17 20:14:18', null);
INSERT INTO `comment` VALUES ('402', '100', '1', '10', 'ggg', '137', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_10.png', '好吧', '2014-08-17 20:14:28', null);
INSERT INTO `comment` VALUES ('403', '100', '3', '6', 'fsdfs', '137', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '炒米线', '2014-08-24 20:43:08', null);
INSERT INTO `comment` VALUES ('404', '100', '1', '1', 'fsfsfsdf', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-27 22:41:21', null);
INSERT INTO `comment` VALUES ('405', '100', '1', '4', 'hehehiOS', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '热火嗨', '2014-08-27 23:11:39', null);
INSERT INTO `comment` VALUES ('406', '100', '1', '4', 'hehehiOS', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '热火嗨', '2014-08-27 23:11:46', null);
INSERT INTO `comment` VALUES ('407', '100', '1', '4', 'hehehiOS', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '热火嗨', '2014-08-27 23:12:34', null);
INSERT INTO `comment` VALUES ('408', '100', '1', '1', 'lllllllllllllllllllll', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-27 23:13:19', null);
INSERT INTO `comment` VALUES ('409', '100', '1', '1', 'mtmtmtmtmtmtmt', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '飞翔的赶脚', '2014-08-27 23:13:41', null);
INSERT INTO `comment` VALUES ('410', '100', '1', '2', 'hehehiOS', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_02.png', '玉溪', '2014-08-27 23:24:49', null);
INSERT INTO `comment` VALUES ('411', '100', '1', '2', 'hehehiOS', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_02.png', '玉溪', '2014-08-27 23:26:38', null);
INSERT INTO `comment` VALUES ('412', '100', '1', '2', '123466899754', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_02.png', '玉溪', '2014-08-27 23:31:48', null);
INSERT INTO `comment` VALUES ('413', '100', '3', '2', '企鹅俄同意', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '茄子酱肉', '2014-08-27 23:45:37', null);
INSERT INTO `comment` VALUES ('414', '100', '3', '1', '而退', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '榨菜肉丝1', '2014-08-27 23:46:06', null);
INSERT INTO `comment` VALUES ('415', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-27 23:54:04', null);
INSERT INTO `comment` VALUES ('416', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-27 23:54:09', null);
INSERT INTO `comment` VALUES ('417', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-27 23:58:25', null);
INSERT INTO `comment` VALUES ('418', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-27 23:58:26', null);
INSERT INTO `comment` VALUES ('419', '100', '4', '1', '', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-27 23:59:10', null);
INSERT INTO `comment` VALUES ('420', '100', '4', '1', '', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-28 07:31:54', null);
INSERT INTO `comment` VALUES ('421', '100', '4', '1', '儿童韩国 vv', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-28 07:33:18', null);
INSERT INTO `comment` VALUES ('422', '100', '4', '1', '儿童韩国 vv', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-28 07:33:23', null);
INSERT INTO `comment` VALUES ('423', '100', '4', '3', '问题与 i 九宫格', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-28 07:34:36', null);
INSERT INTO `comment` VALUES ('424', '100', '4', '1', '千万人吐', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-28 07:37:15', null);
INSERT INTO `comment` VALUES ('425', '100', '3', '1', '', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '榨菜肉丝1', '2014-08-28 14:41:12', null);
INSERT INTO `comment` VALUES ('426', '100', '3', '1', '请问耳语', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '榨菜肉丝1', '2014-08-28 22:23:24', null);
INSERT INTO `comment` VALUES ('427', '100', '3', '3', '请问荣誉', '102', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '目鱼筒骨', '2014-08-28 22:43:52', null);
INSERT INTO `comment` VALUES ('428', '100', '4', '2', '恶如我', '102', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '优惠券测试', '2014-08-31 13:44:41', null);
INSERT INTO `comment` VALUES ('429', '100', '3', '3', '\n\n\n\n\n\n\n\n\n\n\n\n\n', '102', '/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '目鱼筒骨', '2014-09-04 16:05:33', null);
INSERT INTO `comment` VALUES ('430', '100', '3', '3', '工会举办 v 估计会被广告韩国规划局那边吧 vv 骨灰盒据 v 个黄金纪念版 v\n\n', '102', '/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '目鱼筒骨', '2014-09-04 16:07:06', null);

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
  `DownloadTimes` int(11) default '0' COMMENT '下载次数',
  `UsedTimes` int(11) default '0' COMMENT '使用次数',
  `Enabled` int(11) default '0' COMMENT '1：可用，1：不可用',
  `Views` int(11) default '0' COMMENT '浏览次数',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of coupon
-- ----------------------------
INSERT INTO `coupon` VALUES ('1', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '100', '1', '25', '100', '7', '1', '1', '0');
INSERT INTO `coupon` VALUES ('2', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '100', '1', '3', '100', '2', '1', '1', '0');
INSERT INTO `coupon` VALUES ('3', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '100', '1', '3', '100', '2', '0', '0', '0');
INSERT INTO `coupon` VALUES ('4', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '100', '1', '0', '100', '1', '1', '1', '0');
INSERT INTO `coupon` VALUES ('5', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100', '0', '0', '0', '0');
INSERT INTO `coupon` VALUES ('6', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100', '0', '0', '0', '0');
INSERT INTO `coupon` VALUES ('7', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100', '0', '0', '0', '0');
INSERT INTO `coupon` VALUES ('8', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '100', '1', '0', '100', '1', '0', '0', '0');
INSERT INTO `coupon` VALUES ('9', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '100', '1', '1', '100', '1', '0', '0', '0');
INSERT INTO `coupon` VALUES ('10', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '100', '1', '0', '100', '3', '0', '0', '0');
INSERT INTO `coupon` VALUES ('11', '优惠券测试', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '50', '2014-08-30 00:00:00', 'Description', '100', '10', '1', '0', '100', '0', '0', '0', '0');
INSERT INTO `coupon` VALUES ('12', '', '0', 'http://placehold.it/128x128', '10', '2012-12-02 00:00:00', '阿萨德', '10', '10', '', '0', '100', '0', '0', '1', '0');
INSERT INTO `coupon` VALUES ('13', '', '0', 'http://placehold.it/128x128', '10', '2012-12-02 00:00:00', '阿萨德', '10', '10', '', '0', '100', '0', '0', '1', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8;

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
INSERT INTO `extcreditlog` VALUES ('30', '3', '100', '4', '0', '10', '10', '2014-07-29 23:01:06');
INSERT INTO `extcreditlog` VALUES ('31', '3', '100', '4', '0', '10', '10', '2014-07-29 23:01:09');
INSERT INTO `extcreditlog` VALUES ('32', '3', '100', '4', '0', '10', '10', '2014-07-29 23:01:09');
INSERT INTO `extcreditlog` VALUES ('33', '3', '100', '4', '0', '10', '10', '2014-07-29 23:01:09');
INSERT INTO `extcreditlog` VALUES ('34', '3', '100', '4', '0', '10', '10', '2014-07-29 23:01:10');
INSERT INTO `extcreditlog` VALUES ('35', '3', '100', '4', '0', '10', '10', '2014-07-29 23:01:10');
INSERT INTO `extcreditlog` VALUES ('36', '3', '100', '4', '0', '10', '10', '2014-07-29 23:02:11');
INSERT INTO `extcreditlog` VALUES ('37', '3', '100', '4', '0', '11', '65', '2014-07-29 23:05:13');
INSERT INTO `extcreditlog` VALUES ('38', '3', '100', '4', '0', '10', '10', '2014-07-29 23:07:18');
INSERT INTO `extcreditlog` VALUES ('39', '3', '100', '4', '0', '10', '10', '2014-07-29 23:07:29');
INSERT INTO `extcreditlog` VALUES ('40', '3', '100', '4', '0', '10', '10', '2014-07-29 23:07:55');
INSERT INTO `extcreditlog` VALUES ('41', '3', '100', '4', '0', '10', '10', '2014-07-29 23:08:19');
INSERT INTO `extcreditlog` VALUES ('42', '3', '100', '4', '0', '10', '10', '2014-07-29 23:08:25');
INSERT INTO `extcreditlog` VALUES ('43', '3', '100', '4', '0', '10', '10', '2014-07-29 23:08:26');
INSERT INTO `extcreditlog` VALUES ('44', '3', '100', '4', '0', '10', '10', '2014-07-29 23:08:26');
INSERT INTO `extcreditlog` VALUES ('45', '3', '100', '4', '0', '10', '10', '2014-07-29 23:08:27');
INSERT INTO `extcreditlog` VALUES ('46', '3', '100', '4', '0', '10', '10', '2014-07-29 23:08:53');
INSERT INTO `extcreditlog` VALUES ('47', '3', '100', '4', '0', '10', '10', '2014-07-29 23:09:09');
INSERT INTO `extcreditlog` VALUES ('48', '3', '100', '4', '0', '10', '10', '2014-07-29 23:10:46');
INSERT INTO `extcreditlog` VALUES ('49', '3', '100', '4', '0', '10', '10', '2014-07-29 23:10:47');
INSERT INTO `extcreditlog` VALUES ('50', '3', '100', '4', '0', '10', '10', '2014-07-29 23:10:47');
INSERT INTO `extcreditlog` VALUES ('51', '3', '100', '4', '0', '10', '10', '2014-07-29 23:11:50');
INSERT INTO `extcreditlog` VALUES ('52', '3', '100', '4', '0', '10', '10', '2014-07-29 23:13:51');
INSERT INTO `extcreditlog` VALUES ('53', '3', '100', '4', '0', '10', '10', '2014-07-29 23:17:35');
INSERT INTO `extcreditlog` VALUES ('54', '3', '100', '4', '0', '9', '62', '2014-07-29 23:19:05');
INSERT INTO `extcreditlog` VALUES ('55', '106', '100', '21', '0', '2', '10', '2014-07-31 07:05:02');
INSERT INTO `extcreditlog` VALUES ('56', '3', '100', '4', '0', '11', '65', '2014-07-31 23:42:33');
INSERT INTO `extcreditlog` VALUES ('57', '3', '100', '2', '0', '1406954190', '100', '2014-08-02 12:36:30');
INSERT INTO `extcreditlog` VALUES ('58', '3', '100', '22', '0', '2', '10', '2014-08-02 14:43:25');
INSERT INTO `extcreditlog` VALUES ('59', '3', '100', '22', '0', '1', '10', '2014-08-02 16:07:03');
INSERT INTO `extcreditlog` VALUES ('60', '118', '100', '22', '0', '2', '10', '2014-08-02 16:15:18');
INSERT INTO `extcreditlog` VALUES ('61', '118', '100', '22', '0', '5', '10', '2014-08-02 16:16:05');
INSERT INTO `extcreditlog` VALUES ('62', '118', '100', '22', '0', '6', '10', '2014-08-02 16:23:14');
INSERT INTO `extcreditlog` VALUES ('63', '3', '100', '22', '0', '6', '10', '2014-08-02 16:31:57');
INSERT INTO `extcreditlog` VALUES ('64', '3', '100', '22', '0', '9', '10', '2014-08-02 16:32:07');
INSERT INTO `extcreditlog` VALUES ('65', '3', '100', '21', '0', '2', '10', '2014-08-02 17:11:57');
INSERT INTO `extcreditlog` VALUES ('66', '3', '100', '21', '0', '3', '10', '2014-08-02 17:23:21');
INSERT INTO `extcreditlog` VALUES ('67', '3', '100', '4', '0', '24', '10', '2014-08-02 18:04:56');
INSERT INTO `extcreditlog` VALUES ('68', '3', '100', '4', '0', '26', '10', '2014-08-02 18:17:52');
INSERT INTO `extcreditlog` VALUES ('69', '118', '100', '3', '0', '1406908800', '20', '2014-08-02 18:24:30');
INSERT INTO `extcreditlog` VALUES ('70', '3', '100', '24', '0', '1', '10', '2014-08-02 21:29:45');
INSERT INTO `extcreditlog` VALUES ('71', '3', '100', '3', '0', '1406908800', '20', '2014-08-02 22:13:05');
INSERT INTO `extcreditlog` VALUES ('72', '3', '100', '24', '0', '2', '10', '2014-08-02 22:32:58');
INSERT INTO `extcreditlog` VALUES ('73', '118', '100', '24', '0', '3', '10', '2014-08-02 22:34:26');
INSERT INTO `extcreditlog` VALUES ('74', '1', '0', '24', '0', '1', '10', '2014-08-02 22:40:51');
INSERT INTO `extcreditlog` VALUES ('75', '3', '100', '22', '0', '12', '10', '2014-08-03 16:33:02');
INSERT INTO `extcreditlog` VALUES ('76', '3', '100', '21', '0', '8', '10', '2014-08-03 16:39:58');
INSERT INTO `extcreditlog` VALUES ('77', '3', '100', '4', '0', '69', '20', '2014-08-03 16:42:44');
INSERT INTO `extcreditlog` VALUES ('78', '3', '100', '3', '0', '1406995200', '20', '2014-08-03 16:54:20');
INSERT INTO `extcreditlog` VALUES ('79', '3', '100', '4', '0', '71', '10', '2014-08-03 17:04:52');
INSERT INTO `extcreditlog` VALUES ('80', '3', '100', '22', '0', '8', '10', '2014-08-03 20:21:16');
INSERT INTO `extcreditlog` VALUES ('81', '3', '100', '21', '0', '29', '10', '2014-08-03 20:38:25');
INSERT INTO `extcreditlog` VALUES ('82', '3', '100', '4', '0', '94', '10', '2014-08-04 09:36:37');
INSERT INTO `extcreditlog` VALUES ('83', '106', '100', '23', '0', '4', '10', '2014-08-06 00:19:03');
INSERT INTO `extcreditlog` VALUES ('84', '106', '100', '23', '0', '5', '10', '2014-08-06 00:19:17');
INSERT INTO `extcreditlog` VALUES ('85', '106', '100', '23', '0', '1', '10', '2014-08-06 00:23:14');
INSERT INTO `extcreditlog` VALUES ('86', '106', '100', '24', '0', '9', '10', '2014-08-06 00:24:47');
INSERT INTO `extcreditlog` VALUES ('87', '106', '100', '3', '0', '1407427200', '20', '2014-08-08 07:27:48');
INSERT INTO `extcreditlog` VALUES ('88', '106', '100', '3', '0', '1407600000', '20', '2014-08-10 10:52:42');
INSERT INTO `extcreditlog` VALUES ('89', '3', '100', '3', '0', '1407600000', '20', '2014-08-10 14:48:18');
INSERT INTO `extcreditlog` VALUES ('90', '102', '100', '3', '0', '1407600000', '20', '2014-08-10 17:08:39');
INSERT INTO `extcreditlog` VALUES ('91', '102', '100', '21', '0', '2', '10', '2014-08-10 17:12:04');
INSERT INTO `extcreditlog` VALUES ('92', '102', '100', '23', '0', '4', '10', '2014-08-10 17:14:01');
INSERT INTO `extcreditlog` VALUES ('93', '102', '100', '23', '0', '2', '10', '2014-08-10 17:14:30');
INSERT INTO `extcreditlog` VALUES ('94', '3', '100', '3', '0', '1407686400', '20', '2014-08-11 20:35:39');
INSERT INTO `extcreditlog` VALUES ('95', '3', '100', '22', '0', '5', '10', '2014-08-11 21:34:06');
INSERT INTO `extcreditlog` VALUES ('96', '3', '100', '4', '0', '174', '12', '2014-08-12 00:31:38');
INSERT INTO `extcreditlog` VALUES ('97', '3', '100', '4', '0', '178', '10', '2014-08-12 00:33:27');
INSERT INTO `extcreditlog` VALUES ('98', '3', '100', '3', '0', '1407772800', '20', '2014-08-12 00:47:06');
INSERT INTO `extcreditlog` VALUES ('99', '3', '100', '4', '0', '195', '10', '2014-08-12 16:56:04');
INSERT INTO `extcreditlog` VALUES ('100', '118', '100', '23', '0', '10', '10', '2014-08-13 22:10:00');
INSERT INTO `extcreditlog` VALUES ('101', '3', '100', '3', '0', '1408118400', '20', '2014-08-16 01:48:17');
INSERT INTO `extcreditlog` VALUES ('102', '106', '100', '3', '0', '1408118400', '20', '2014-08-16 15:39:36');
INSERT INTO `extcreditlog` VALUES ('103', '137', '100', '3', '0', '1408204800', '20', '2014-08-17 12:46:03');
INSERT INTO `extcreditlog` VALUES ('104', '137', '100', '22', '0', '10', '10', '2014-08-17 12:55:02');
INSERT INTO `extcreditlog` VALUES ('105', '137', '100', '22', '0', '11', '10', '2014-08-17 12:56:30');
INSERT INTO `extcreditlog` VALUES ('106', '137', '100', '22', '0', '6', '10', '2014-08-17 12:57:22');
INSERT INTO `extcreditlog` VALUES ('107', '137', '100', '21', '0', '8', '10', '2014-08-17 13:02:28');
INSERT INTO `extcreditlog` VALUES ('108', '106', '100', '3', '0', '1408204800', '20', '2014-08-17 14:22:43');
INSERT INTO `extcreditlog` VALUES ('109', '137', '100', '21', '0', '10', '10', '2014-08-17 15:38:14');
INSERT INTO `extcreditlog` VALUES ('110', '137', '100', '21', '0', '1', '10', '2014-08-17 16:12:42');
INSERT INTO `extcreditlog` VALUES ('111', '137', '100', '23', '0', '10', '10', '2014-08-17 20:14:18');
INSERT INTO `extcreditlog` VALUES ('112', '137', '100', '21', '0', '6', '10', '2014-08-24 20:43:08');
INSERT INTO `extcreditlog` VALUES ('113', '130', '100', '3', '0', '1408809600', '20', '2014-08-24 20:49:45');
INSERT INTO `extcreditlog` VALUES ('114', '102', '100', '3', '0', '1408809600', '20', '2014-08-24 21:40:54');
INSERT INTO `extcreditlog` VALUES ('115', '3', '100', '2', '0', '1409069657', '100', '2014-08-27 00:14:17');
INSERT INTO `extcreditlog` VALUES ('116', '3', '100', '3', '0', '1409068800', '20', '2014-08-27 17:32:09');
INSERT INTO `extcreditlog` VALUES ('117', '4', '100', '3', '0', '1409068800', '20', '2014-08-27 17:32:27');
INSERT INTO `extcreditlog` VALUES ('118', '100', '0', '23', '0', '4', '10', '2014-08-27 23:11:39');
INSERT INTO `extcreditlog` VALUES ('119', '100', '0', '23', '0', '2', '10', '2014-08-27 23:24:49');
INSERT INTO `extcreditlog` VALUES ('120', '100', '0', '21', '0', '2', '10', '2014-08-27 23:45:37');
INSERT INTO `extcreditlog` VALUES ('121', '100', '0', '21', '0', '1', '10', '2014-08-27 23:46:06');
INSERT INTO `extcreditlog` VALUES ('122', '100', '0', '24', '0', '1', '10', '2014-08-27 23:59:10');
INSERT INTO `extcreditlog` VALUES ('123', '100', '0', '24', '0', '3', '10', '2014-08-28 07:34:36');
INSERT INTO `extcreditlog` VALUES ('124', '3', '100', '3', '0', '1409155200', '20', '2014-08-28 10:52:19');
INSERT INTO `extcreditlog` VALUES ('125', '102', '100', '21', '0', '3', '10', '2014-08-28 22:43:52');
INSERT INTO `extcreditlog` VALUES ('126', '102', '100', '3', '0', '1409414400', '20', '2014-08-31 12:06:34');
INSERT INTO `extcreditlog` VALUES ('127', '102', '100', '24', '0', '2', '10', '2014-08-31 13:44:41');
INSERT INTO `extcreditlog` VALUES ('128', '102', '100', '3', '0', '1409500800', '20', '2014-09-01 21:54:08');
INSERT INTO `extcreditlog` VALUES ('129', '102', '100', '3', '0', '1409587200', '20', '2014-09-02 11:27:00');
INSERT INTO `extcreditlog` VALUES ('130', '102', '100', '4', '0', '597', '32', '2014-09-02 23:47:20');
INSERT INTO `extcreditlog` VALUES ('131', '102', '100', '4', '0', '598', '28', '2014-09-02 23:48:01');
INSERT INTO `extcreditlog` VALUES ('132', '102', '100', '4', '0', '596', '17', '2014-09-02 23:48:13');
INSERT INTO `extcreditlog` VALUES ('133', '102', '100', '4', '0', '600', '38', '2014-09-02 23:54:16');
INSERT INTO `extcreditlog` VALUES ('134', '102', '100', '4', '0', '601', '49', '2014-09-02 23:57:29');
INSERT INTO `extcreditlog` VALUES ('135', '102', '100', '4', '0', '603', '17', '2014-09-03 00:05:22');
INSERT INTO `extcreditlog` VALUES ('136', '102', '100', '3', '0', '1409673600', '20', '2014-09-03 11:03:24');
INSERT INTO `extcreditlog` VALUES ('137', '102', '100', '3', '0', '1409760000', '20', '2014-09-04 09:35:21');

-- ----------------------------
-- Table structure for extractmoney
-- ----------------------------
DROP TABLE IF EXISTS `extractmoney`;
CREATE TABLE `extractmoney` (
  `Id` int(11) unsigned NOT NULL auto_increment,
  `SellerId` int(11) NOT NULL default '0',
  `Balance` float(11,0) NOT NULL default '0' COMMENT '余额',
  `Bank` varchar(100) NOT NULL COMMENT '银行',
  `CardNumber` bigint(20) NOT NULL default '0' COMMENT '卡号',
  `Money` float(11,0) NOT NULL default '0' COMMENT '提现金额',
  `CreateTime` datetime default NULL COMMENT '提现时间',
  `AccountName` varchar(100) default NULL,
  `Status` int(11) NOT NULL default '0',
  `Fee` float default NULL COMMENT '手续费',
  `UserAccount` varchar(50) default '' COMMENT '商户账户名',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of extractmoney
-- ----------------------------
INSERT INTO `extractmoney` VALUES ('1', '100', '10000', '建设银行', '443323432234323', '500', '2014-08-30 23:50:20', 'useraa', '1', '10', 'user');
INSERT INTO `extractmoney` VALUES ('2', '100', '10000', '建设银行', '443323432234323', '200', '2014-08-30 23:50:20', 'useraa', '1', '10', 'user');
INSERT INTO `extractmoney` VALUES ('3', '100', '10000', '建设银行', '443323432234323', '300', '2014-08-30 23:50:20', 'useraa', '0', '10', 'user');
INSERT INTO `extractmoney` VALUES ('4', '100', '10000', '建设银行', '443323432234323', '400', '2014-08-30 23:50:20', 'useraa', '0', '10', 'user');
INSERT INTO `extractmoney` VALUES ('5', '100', '10000', '建设银行', '443323432234323', '100', '2014-08-30 23:50:20', 'useraa', '0', '10', 'user');
INSERT INTO `extractmoney` VALUES ('6', '100', '10000', '建设银行', '443323432234323', '600', '2014-08-30 23:50:20', 'useraa', '0', '10', 'user');
INSERT INTO `extractmoney` VALUES ('7', '100', '10000', '建设银行', '443323432234323', '700', '2014-08-30 23:50:20', 'useraa', '0', '10', 'user');
INSERT INTO `extractmoney` VALUES ('8', '100', '10000', '建设银行', '443323432234323', '800', '2014-08-30 23:50:20', 'useraa', '0', '10', 'user');

-- ----------------------------
-- Table structure for fastlinks
-- ----------------------------
DROP TABLE IF EXISTS `fastlinks`;
CREATE TABLE `fastlinks` (
  `Id` int(11) NOT NULL auto_increment,
  `Title` varchar(1000) NOT NULL,
  `Url` varchar(1000) default NULL,
  `ImgUrl` varchar(1000) default NULL,
  `CreateTime` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fastlinks
-- ----------------------------
INSERT INTO `fastlinks` VALUES ('1', 'zxc', 'http://dev.app.test.nd/View/Dev/System/FastLinks.aspx', '/File/1/image/goods/20140901/图片1.png', '2014-09-01 01:21:24');
INSERT INTO `fastlinks` VALUES ('2', 'zxc', 'http://dev.app.test.nd/View/Dev/System/FastLinks.aspx', '/File/1/image/goods/20140901/图片1.png', '2014-09-01 01:23:14');

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
INSERT INTO `favorite` VALUES ('3', '1,2,5,6');
INSERT INTO `favorite` VALUES ('4', '1,2,3,4,5');
INSERT INTO `favorite` VALUES ('5', '6,7,8,9,10');
INSERT INTO `favorite` VALUES ('1', '10');
INSERT INTO `favorite` VALUES ('0', '');
INSERT INTO `favorite` VALUES ('106', '');
INSERT INTO `favorite` VALUES ('107', '1,2,3,4,5,6,7,8,9,10,29');
INSERT INTO `favorite` VALUES ('118', '10');
INSERT INTO `favorite` VALUES ('130', '9');
INSERT INTO `favorite` VALUES ('102', '1,2,5,6,7,9,31');
INSERT INTO `favorite` VALUES ('2', '');
INSERT INTO `favorite` VALUES ('110', '');
INSERT INTO `favorite` VALUES ('108', '');
INSERT INTO `favorite` VALUES ('100', '');
INSERT INTO `favorite` VALUES ('135', '');
INSERT INTO `favorite` VALUES ('137', '1,5,7,10');
INSERT INTO `favorite` VALUES ('139', '');
INSERT INTO `favorite` VALUES ('148', '');
INSERT INTO `favorite` VALUES ('149', '1,3');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `Id` int(11) NOT NULL auto_increment,
  `SellerId` int(11) default NULL COMMENT '商家id',
  `LogoUrl` varchar(255) default '',
  `ImagesUrl` varchar(1000) default '',
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', '100', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg', '1', '1,2,3', '15', '榨菜肉丝1', '1', '8.00', '11.00', '5', '2014-07-07 23:12:58', '6', '10', '肉', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '31', '1', '360', '0');
INSERT INTO `goods` VALUES ('3', '100', '/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '1', '1,2,3', '6', '目鱼筒骨', '2', '9.00', '12.00', '5', '2014-07-07 23:12:58', '3', '1', '肉', '啦啦啦有肉冲啊', '7', '0', '161', '0');
INSERT INTO `goods` VALUES ('5', '100', '/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '1', '1,2,3', '8', '莆田卤面', '1', '10.00', '13.00', '5', '2014-07-07 23:12:58', '5', '1', '肉', '啦啦啦有肉冲啊', '0', '0', '27', '0');
INSERT INTO `goods` VALUES ('30', '142', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', null, '', '0', 'asdasd', '0', '10.00', '100.00', '0', '0001-01-01 00:00:00', '0', '0', 'ads', 'asd', '0', '1', '6', '0');
INSERT INTO `goods` VALUES ('31', '100', '/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0.jpg', '/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0.jpg', null, '', '4', '鸡蛋饼', '5', '22.00', '26.00', '0', '0001-01-01 00:00:00', '1', '0', '大小：大份,口味：微辣', '鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼', '0', '0', '2', '1');
INSERT INTO `goods` VALUES ('32', '100', '/File/100/image/goods/20140904/图片1.png', '/File/100/image/goods/20140904/图片1.png', null, '', '0', '测试', '1', '10.00', '100.00', '0', '0001-01-01 00:00:00', '0', '0', '1', '11', '0', '0', '0', '1');

-- ----------------------------
-- Table structure for goodscategories
-- ----------------------------
DROP TABLE IF EXISTS `goodscategories`;
CREATE TABLE `goodscategories` (
  `Id` int(11) NOT NULL auto_increment COMMENT 'id',
  `Index` int(11) default NULL COMMENT '排序id',
  `Name` varchar(50) default NULL COMMENT '分类名称',
  `SellerId` int(11) default NULL COMMENT '商户id',
  `ImageUrl` varchar(100) default '' COMMENT '图片url',
  `Count` int(11) default '0' COMMENT '数量',
  `Color` varchar(255) default '#ffffff' COMMENT '分类颜色',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodscategories
-- ----------------------------
INSERT INTO `goodscategories` VALUES ('1', '1', '小炒类', '100', '/bg/File/100/image/goods/20140730/Koala(2).jpg', '-5', '#ffffff');
INSERT INTO `goodscategories` VALUES ('2', '2', '海鲜类', '100', '/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '-1', '#ffffff');
INSERT INTO `goodscategories` VALUES ('3', '3', '面食类', '100', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg', '-1', '#ffffff');
INSERT INTO `goodscategories` VALUES ('5', '5', '套餐类', '100', '/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '1', '#ffffff');
INSERT INTO `goodscategories` VALUES ('6', '6', '十大', '100', '/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '0', '#ffffff');

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
  `ImageType` int(11) default '0' COMMENT '素材库图片类型 1、图片墙，2、活动，3、产品，4、头像',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES ('1', '飞翔的赶脚', 'http://182.254.149.149/bg/file/100/image/kulouwenhua_01.png', '海盗来袭', '0', '36', '100', '2014-07-07 22:43:00', '0');
INSERT INTO `material` VALUES ('4', '热火嗨', 'http://182.254.149.149/bg/file/100/image/kulouwenhua_04.png', '输了没事', '0', '7', '100', '2014-07-07 22:43:00', '0');
INSERT INTO `material` VALUES ('5', '把油', 'http://182.254.149.149/bg/file/100/image/kulouwenhua_05.png', 'jj', '0', '1', '100', '2014-07-07 22:43:00', '0');
INSERT INTO `material` VALUES ('6', 'high起来', 'http://182.254.149.149/bg/file/100/image/kulouwenhua_06.png', '邹师傅', '0', '1', '100', '2014-07-07 22:43:00', '0');
INSERT INTO `material` VALUES ('7', '方便面', 'http://182.254.149.149/bg/file/100/image/kulouwenhua_07.png', '说好就好', '0', '0', '100', '2014-07-07 22:43:00', '0');
INSERT INTO `material` VALUES ('8', '糗百', 'http://182.254.149.149/bg/file/100/image/kulouwenhua_08.png', '咬你', '0', '0', '100', '2014-07-07 22:43:00', '0');
INSERT INTO `material` VALUES ('9', '翻了', 'http://182.254.149.149/bg/file/100/image/kulouwenhua_09.png', '烦了', '0', '0', '100', '2014-07-07 22:43:00', '0');
INSERT INTO `material` VALUES ('10', '好吧', 'http://182.254.149.149/bg/file/100/image/kulouwenhua_10.png', 'dd', '0', '3', '100', '2014-07-07 22:43:00', '0');
INSERT INTO `material` VALUES ('11', 'Koala', 'http://182.254.149.149/bg/File/100/image/goods/20140730/Koala.jpg', 'Koala', '0', '0', '100', '2014-07-30 00:45:40', '0');
INSERT INTO `material` VALUES ('12', 'Koala(2)', 'http://182.254.149.149/bg/File/100/image/goods/20140730/Koala(2).jpg', 'Koala(2)', '0', '0', '100', '2014-07-30 00:45:52', '0');
INSERT INTO `material` VALUES ('14', '图片1', 'http://mto2o.cn/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', '图片1', '0', '0', '1', '2014-08-01 00:19:20', '0');
INSERT INTO `material` VALUES ('15', '图片1(2)', 'http://mto2o.cn/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', '图片1(2)', '0', '0', '1', '2014-08-01 00:40:13', '0');
INSERT INTO `material` VALUES ('16', '图片1(3)', 'http://mto2o.cn/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', '图片1(3)', '0', '0', '1', '2014-08-01 00:42:59', '0');
INSERT INTO `material` VALUES ('17', 'lt测试', 'http://mto2o.cn/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', '图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试', '0', '0', '0', '2014-08-02 23:48:05', '0');
INSERT INTO `material` VALUES ('18', 'lt测试', 'http://mto2o.cn/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', '图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试图片墙lt测试', '0', '0', '100', '2014-08-02 23:51:45', '1');
INSERT INTO `material` VALUES ('19', '图片1', 'http://mto2o.cn/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', '图片1', '0', '0', '1', '2014-08-03 14:50:45', '0');
INSERT INTO `material` VALUES ('20', '9e3e41d9jw1dz2eb7w384j', 'http://mto2o.cn/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', '9e3e41d9jw1dz2eb7w384j', '0', '0', '1', '2014-08-23 13:47:58', '0');
INSERT INTO `material` VALUES ('21', '135460836012943', 'http://mto2o.cn/bg/File/1/image/goods/20140823/135460836012943.png', '135460836012943', '0', '0', '1', '2014-08-23 13:48:09', '0');
INSERT INTO `material` VALUES ('22', '1284286700464ed', 'http://mto2o.cn/bg/File/1/image/goods/20140823/1284286700464ed.jpg', '1284286700464ed', '0', '0', '1', '2014-08-23 13:48:16', '0');
INSERT INTO `material` VALUES ('23', '135460835581456', 'http://mto2o.cn/bg/File/1/image/goods/20140823/135460835581456.png', '135460835581456', '0', '0', '1', '2014-08-23 13:48:21', '0');
INSERT INTO `material` VALUES ('24', '62037b5ajw1e082gfja81j', 'http://mto2o.cn/bg/File/1/image/goods/20140823/62037b5ajw1e082gfja81j.jpg', '62037b5ajw1e082gfja81j', '0', '0', '1', '2014-08-23 13:48:29', '0');
INSERT INTO `material` VALUES ('25', '90627d01jw1dzlcx64dxcj', 'http://mto2o.cn/bg/File/1/image/goods/20140823/90627d01jw1dzlcx64dxcj.jpg', '90627d01jw1dzlcx64dxcj', '0', '0', '1', '2014-08-23 13:48:37', '0');
INSERT INTO `material` VALUES ('26', 'logo3', 'http://mto2o.cn/bg/File/1/image/goods/20140824/logo3.png', 'logo3', '0', '0', '1', '2014-08-24 15:02:34', '0');
INSERT INTO `material` VALUES ('27', 'logo3(2)', 'http://mto2o.cn/bg/File/1/image/goods/20140824/logo3(2).png', 'logo3(2)', '0', '0', '1', '2014-08-24 15:04:22', '0');
INSERT INTO `material` VALUES ('28', '图片1', '/File/1/image/goods/20140901/图片1.png', '图片1', '0', '0', '1', '2014-09-01 01:20:00', '0');
INSERT INTO `material` VALUES ('29', 'APP2副本', 'http://www.mto2o.cn/bg/File/100/image/goods/20140901/APP2副本.jpg', 'APP2副本', '0', '0', '100', '2014-09-01 17:22:53', '0');
INSERT INTO `material` VALUES ('30', 'u=3425888035.1983349493&fm=21&gp=0', 'http://www.mto2o.cn/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0.jpg', 'u=3425888035.1983349493&fm=21&gp=0', '0', '0', '100', '2014-09-01 17:31:32', '0');
INSERT INTO `material` VALUES ('31', 'u=279121271.937951038&fm=21&gp=0', 'http://www.mto2o.cn/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', 'u=279121271.937951038&fm=21&gp=0', '0', '0', '100', '2014-09-01 17:34:34', '0');
INSERT INTO `material` VALUES ('32', 'u=1966325563.3781173364&fm=21&gp=0', 'http://www.mto2o.cn/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg', 'u=1966325563.3781173364&fm=21&gp=0', '0', '0', '100', '2014-09-01 17:34:40', '0');
INSERT INTO `material` VALUES ('33', 'u=3425888035.1983349493&fm=21&gp=0(2)', 'http://www.mto2o.cn/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0(2).jpg', 'u=3425888035.1983349493&fm=21&gp=0(2)', '0', '0', '100', '2014-09-01 17:34:52', '0');
INSERT INTO `material` VALUES ('34', 'u=20725595.3613037323&fm=21&gp=0', 'http://www.mto2o.cn/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', 'u=20725595.3613037323&fm=21&gp=0', '0', '0', '100', '2014-09-01 17:34:58', '0');
INSERT INTO `material` VALUES ('35', 'u=2824686930.1646565543&fm=21&gp=0', 'http://www.mto2o.cn/bg/File/100/image/goods/20140901/u=2824686930.1646565543&fm=21&gp=0.jpg', 'u=2824686930.1646565543&fm=21&gp=0', '0', '0', '100', '2014-09-01 17:43:55', '0');
INSERT INTO `material` VALUES ('36', '2', 'http://www.mto2o.cn/bg/File/100/image/goods/20140901/2.jpg', '2', '0', '0', '100', '2014-09-01 23:56:08', '0');
INSERT INTO `material` VALUES ('37', '图片1', '/File/100/image/goods/20140904/图片1.png', '图片1', '0', '0', '100', '2014-09-04 11:25:25', '0');

-- ----------------------------
-- Table structure for merchant
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant` (
  `Id` int(11) NOT NULL,
  `Name` varchar(100) default '' COMMENT '商户名称',
  `Tname` varchar(15) default '' COMMENT '名称缩写',
  `Address` varchar(150) default '' COMMENT '地址',
  `Phone` varchar(30) default '' COMMENT '电话号码',
  `Description` varchar(500) default '' COMMENT '描述',
  `Mapurl` varchar(200) default '' COMMENT '地图url',
  `AppId` varchar(100) default '',
  `AppSecret` varchar(100) default '',
  `AccessToken` varchar(100) default '',
  `AccessExpire` datetime default '2014-01-01 12:00:00',
  `AndroidUrl` varchar(100) default '',
  `IosUrl` varchar(100) default '',
  `WxUrl` varchar(100) default '',
  `PointX` varchar(11) default '',
  `PointY` varchar(11) default '',
  `ReChargeIntegral` int(11) default '0',
  `ConsumptionIntegral` int(11) default '0',
  `CommentIntegral` int(11) default '0',
  `ShareIntegral` int(11) default '0',
  `Freight` int(11) default '0',
  `NeedToFreeFreight` int(11) default '0',
  `ServerEndTime` datetime default '2014-01-01 12:00:00' COMMENT '服务时间',
  `LogoUrl` varchar(200) default '' COMMENT '商户logo',
  `Mid` int(11) default '0' COMMENT '商户分类',
  `UserCount` int(11) default '0' COMMENT '商户的用户量',
  `Tid` int(11) default '0' COMMENT '商户模板id',
  `HasWifi` int(11) default '0' COMMENT '是否使用易WiFi',
  `HasPrint` int(11) default '0' COMMENT '是否使用云打印',
  `ManagerPhone` varchar(100) default '' COMMENT '管理员联系方式',
  `Qq` varchar(30) default '' COMMENT 'qq',
  `WinXinAccount` varchar(50) default '' COMMENT '微信公众号',
  `Email` varchar(100) default '' COMMENT '邮箱号',
  `CnameList` varchar(255) default '' COMMENT '类名称列表【活动咨询、商品展示、快速预约、图片墙、包厢】',
  `Money` float(255,0) default '0' COMMENT '总营业额（不会减少）',
  `DevName` varchar(50) default '' COMMENT '开发人员名称',
  `Sid` int(11) default '1' COMMENT '签约类型id',
  `AccountName` varchar(100) default NULL COMMENT '开户名',
  `CardNumber` bigint(20) default NULL COMMENT '卡号',
  `Bank` varchar(200) default NULL COMMENT '开户行',
  `CreateTime` datetime default NULL COMMENT '入驻时间',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of merchant
-- ----------------------------
INSERT INTO `merchant` VALUES ('100', '大闸蟹大饭店', '大闸蟹', '火星一号船头等舱10号', '110', '接送请拨号', '', 'wxbc8591c8e9596b18', '7a315e301f33559bc903c99804d76480', 'uB1a9t6cAVzGXcSnC4nJ6BUNAvvt38MyL0AnoHJDsaO-Kddga0JyIclQNMApiBJplPZ1DETvELUvXqsuUAwQXA', '2014-07-06 14:24:14', ' ', ' ', ' ', '119.304455', '26.091985', '0', '0', '0', '0', '0', '0', '2014-01-01 08:00:00', '/bg/File/1/image/goods/20140823/135460836012943.png', '1', '0', '1', '1', '1', 'd', 'd', 'd', 'd', '订单,dd,dd,dd,dd', '31546', 's', '1', null, '11111111111111111', null, null);
INSERT INTO `merchant` VALUES ('140', 'test1', '', 'q', 'q', '', '', '', '', '', '2014-08-24 01:01:10', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '2015-02-12 08:00:00', '/bg/File/1/image/goods/20140823/1284286700464ed.jpg', '2', '0', '4', '1', '1', 'q', 'q', 'q', 'q', '活动咨询,商品展示,快速预约,图片墙,包厢', '0', 'qq', '2', null, '11111111111111111', null, null);
INSERT INTO `merchant` VALUES ('142', 'test2', '', 'q', 'q', '', '', '', '', '', '2014-08-24 01:01:30', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '2015-02-12 08:00:00', '/bg/File/1/image/goods/20140823/135460835581456.png', '4', '0', '2', '1', '1', 'q', 'q', 'q', 'q', '活动咨询,商品展示,快速预约,图片墙,包厢', '0', 'qq', '2', null, '11111111111111111', null, null);
INSERT INTO `merchant` VALUES ('144', 'test3', '', 'q', 'q', '', '', '', '', '', '2014-08-24 01:01:49', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '2015-02-12 08:00:00', '/bg/File/1/image/goods/20140823/90627d01jw1dzlcx64dxcj.jpg', '5', '0', '3', '1', '1', 'q', 'q', 'q', 'q', '活动咨询,商品展示,快速预约,图片墙,包厢', '0', 'qq', '2', null, '11111111111111111', null, null);
INSERT INTO `merchant` VALUES ('146', 'test4', '', 'q', 'q', '', '', '', '', '', '2014-08-24 01:02:07', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '2015-02-12 08:00:00', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', '2', '0', '1', '1', '1', 'q', 'q', 'q', 'q', '活动咨询,商品展示,快速预约,图片墙,包厢', '0', 'qq', '2', null, '11111111111111111', null, null);

-- ----------------------------
-- Table structure for merchanttype
-- ----------------------------
DROP TABLE IF EXISTS `merchanttype`;
CREATE TABLE `merchanttype` (
  `Id` int(11) NOT NULL auto_increment,
  `Name` varchar(20) default '',
  `Count` int(11) default '0' COMMENT '商户个数',
  `TypeId` int(11) default '1' COMMENT '默认的类型id',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of merchanttype
-- ----------------------------
INSERT INTO `merchanttype` VALUES ('1', '餐饮类', '10', '1');
INSERT INTO `merchanttype` VALUES ('2', '超市类', '2', '1');
INSERT INTO `merchanttype` VALUES ('3', '酒吧类', '44', '2');
INSERT INTO `merchanttype` VALUES ('4', 'KTV类', '33', '2');
INSERT INTO `merchanttype` VALUES ('5', '办公', '22', '3');

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
  `CouponTitle` varchar(100) default '' COMMENT '优惠券标题',
  `CtotalPrice` float(11,2) default NULL,
  `Address` varchar(100) default '',
  `LinkMan` varchar(100) default '',
  `Mobile` varchar(100) default '',
  `CreateTime` datetime default NULL,
  `Remark` varchar(100) default NULL,
  `Status` int(11) default '0',
  `SellerId` int(11) default '0' COMMENT '商户id',
  `Ccontent` varchar(100) default '' COMMENT '优惠券说明',
  `Discount` float(11,0) default '10' COMMENT '打折',
  `Boxno` int(11) default '0' COMMENT '包厢号 夜场才有',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=613 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('1', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '61.50', '66.00', '1', '2014-07-15 00:00:00', '0', '10', '1', '', '0.50', '福州', '隔壁老王', '', '2014-07-18 14:16:18', '老王我们一起去吃麻辣烫吧', '9', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('2', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:16:21', '0', '0', '0', '', '0.00', '', '', '', '2014-07-18 14:16:21', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('3', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:16:22', '0', '0', '0', '', '0.00', '', '', '', '2014-07-18 14:16:22', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('4', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:16:23', '0', '0', '0', '', '0.00', '', '', '', '2014-07-18 14:16:23', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('5', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:16:24', '0', '0', '0', '', '0.00', '', '', '', '2014-07-18 14:16:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('6', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:16:25', '0', '0', '0', '', '0.00', '', '', '', '2014-07-18 14:16:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('7', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-18 14:37:10', '0', '0', '0', '', '0.00', '', '', '', '2014-07-18 14:37:10', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('8', '3', '3,4,5', '2,3,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-22 22:25:43', '0', '0', '0', '', '0.00', '', '', '', '2014-07-22 22:25:43', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('9', '3', '1,2', '1,5', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '62.00', '62.00', '1', '2014-07-15 20:12:00', '0', '10', '0', '', '0.00', '福州', '隔壁老王', '', '2014-07-25 19:33:55', '老王我们一起去吃麻辣烫吧', '2', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('10', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '榨菜肉丝', '10', '12', '10.00', '10.00', '1', '2014-07-29 12:22:00', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '', '2014-07-29 20:22:34', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('11', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '65.50', '66.00', '1', '2014-07-15 00:00:00', '0', '10', '1', '', '0.50', '福州', '隔壁老王', '', '2014-07-29 23:04:41', '老王我们一起去吃麻辣烫吧', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('12', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-07-29 23:09:50', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-07-29 23:09:50', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('13', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-07-31 00:37:31', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-07-31 00:37:31', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('14', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-02 14:36:58', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-02 14:36:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('15', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-02 16:42:44', '0', '0', '0', '', '0.00', '', '', '', '2014-08-02 16:42:44', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('16', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-02 16:43:28', '0', '0', '0', '', '0.00', '', '', '', '2014-08-02 16:43:28', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('17', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-02 16:46:49', '0', '0', '0', '', '0.00', '', '', '', '2014-08-02 16:46:49', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('18', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-02 16:47:21', '0', '0', '0', '', '0.00', '', '', '', '2014-08-02 16:47:21', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('19', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-02 16:59:23', '0', '0', '0', '', '0.00', '', '', '', '2014-08-02 16:59:23', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('20', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-02 17:11:58', '0', '0', '0', '', '0.00', '', '', '', '2014-08-02 17:11:58', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('21', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-02 17:16:25', '0', '0', '0', '', '0.00', '', '', '', '2014-08-02 17:16:25', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('22', '107', '1,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,莆田卤面', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-02 17:18:47', '0', '0', '0', '', '0.00', '', '', '15980207996', '2014-08-02 17:18:47', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('23', '107', '1,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,莆田卤面', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-02 17:19:50', '0', '0', '0', '', '0.00', '', '', '15980207996', '2014-08-02 17:19:50', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('24', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '榨菜肉丝', '10', '12', '10.00', '10.00', '1', '2014-08-02 10:04:00', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '', '2014-08-02 18:04:43', '', '2', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('25', '107', '1,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,莆田卤面', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-02 18:11:24', '0', '0', '0', '', '0.00', '', '', '15980207996', '2014-08-02 18:11:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('26', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '榨菜肉丝', '10', '12', '10.00', '10.00', '1', '2014-08-02 10:17:00', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '', '2014-08-02 18:17:46', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('27', '118', '1', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '榨菜肉丝', '10', '12', '20.00', '20.00', '1', '2014-08-02 18:23:00', '0', '0', '0', '', '0.00', '', '', '', '2014-08-02 18:23:39', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('28', '118', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '榨菜肉丝', '10', '12', '10.00', '10.00', '1', '2014-08-02 18:24:00', '0', '0', '0', '', '0.00', '', '', '', '2014-08-02 18:24:02', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('29', '107', '1,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,莆田卤面', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-02 22:30:11', '0', '0', '0', '', '0.00', '', '', '15980207996', '2014-08-02 22:30:11', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('30', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 06:58:33', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 06:58:33', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('31', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 07:00:04', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 07:00:04', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('32', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 07:00:33', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 07:00:33', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('33', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 07:02:05', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 07:02:05', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('34', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 07:02:55', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 07:02:55', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('35', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 07:33:59', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 07:33:59', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('36', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 07:37:53', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 07:37:53', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('37', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 08:22:55', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 08:22:55', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('38', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 08:30:16', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 08:30:16', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('39', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 08:45:38', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 08:45:38', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('40', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 08:47:41', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 08:47:41', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('41', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 08:55:31', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 08:55:31', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('42', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 09:01:35', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 09:01:35', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('43', '107', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 09:08:38', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 09:08:38', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('44', '130', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 09:16:06', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 09:16:06', '', '-1', '0', '', '10', '0');
INSERT INTO `orders` VALUES ('45', '130', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 10:01:08', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 10:01:08', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('46', '130', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 10:01:18', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 10:01:18', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('47', '106', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 10:13:38', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 10:13:38', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('48', '106', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 10:14:56', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 10:14:56', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('49', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-03 10:40:39', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-03 10:40:39', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('50', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-03 10:45:29', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-03 10:45:29', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('51', '130', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 10:46:10', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 10:46:10', '', '-1', '0', '', '10', '0');
INSERT INTO `orders` VALUES ('52', '130', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 10:46:51', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 10:46:51', '', '-1', '0', '', '10', '0');
INSERT INTO `orders` VALUES ('53', '130', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 10:50:48', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 10:50:48', '', '-1', '0', '', '10', '0');
INSERT INTO `orders` VALUES ('54', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-03 10:55:30', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-03 10:55:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('55', '130', '', '', '', '', '', '', '', '0.00', '0.00', '0', '2014-08-03 10:55:41', '0', '0', '0', '', '0.00', '', '', '', '2014-08-03 10:55:41', null, '0', '0', null, '10', '0');
INSERT INTO `orders` VALUES ('56', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-03 11:01:16', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-03 11:01:16', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('57', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-03 11:02:17', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-03 11:02:17', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('58', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-03 11:05:33', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-03 11:05:33', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('59', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-03 11:20:35', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-03 11:20:35', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('60', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '1', '2014-07-15 00:00:00', '1', '10', '0', '', '0.00', '福州', '隔壁老王', '', '2014-08-03 14:51:23', '老王我们一起去吃麻辣烫吧', '2', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('61', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '1', '2014-07-15 00:00:00', '1', '10', '0', '', '0.00', '福州', '隔壁老王', '', '2014-08-03 14:52:00', '老王我们一起去吃麻辣烫吧', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('62', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '1', '2014-07-15 00:00:00', '1', '10', '0', '', '0.00', '福州', '隔壁老王', '', '2014-08-03 14:52:13', '老王我们一起去吃麻辣烫吧', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('63', '130', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-03 15:47:53', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-03 15:47:53', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('64', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-03 15:49:00', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-03 15:49:00', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('65', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-03 16:18:51', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 16:18:51', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('66', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-03 16:22:36', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 16:22:36', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('67', '130', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-03 16:23:45', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 16:23:45', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('68', '3', '8', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '馒头', '1', '1.5', '1.00', '1.00', '0', '2014-08-03 16:41:18', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-03 16:41:18', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('69', '3', '1,9', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,套餐1', '10,10', '12,12', '20.00', '20.00', '1', '2014-08-03 16:42:00', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '', '2014-08-03 16:42:37', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('70', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-03 16:43:15', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-03 16:43:15', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('71', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '榨菜肉丝', '10', '12', '10.00', '10.00', '1', '2014-08-03 17:04:00', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '', '2014-08-03 17:04:43', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('72', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-03 17:21:41', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 17:21:41', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('73', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-03 17:23:56', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 17:23:56', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('74', '130', '1,2,5', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉,莆田卤面', '10,12,10', '12,13,12', '44.00', '44.00', '0', '2014-08-03 17:30:24', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 17:30:24', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('75', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-03 17:32:39', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 17:32:39', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('76', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-03 17:33:06', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 17:33:06', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('77', '130', '1,2', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '32.00', '32.00', '0', '2014-08-03 17:36:23', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 17:36:23', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('78', '130', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '2', '2014-08-03 17:37:49', '1', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 17:37:49', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('79', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-03 17:38:15', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 17:38:15', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('80', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-03 17:40:06', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 17:40:06', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('81', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-03 18:10:03', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-03 18:10:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('82', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-03 20:47:21', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-03 20:47:21', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('83', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-03 22:15:08', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-03 22:15:08', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('84', '106', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '1', '0001-01-01 00:00:00', '2', '0', '0', '', '0.00', '', '', '', '2014-08-03 23:17:29', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('85', '106', '1,2,5', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉,莆田卤面', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-03 23:22:07', '0', '0', '0', '', '0.00', '', '有', '13600887930', '2014-08-03 23:22:07', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('86', '106', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '1', '0001-01-01 00:00:00', '1', '0', '0', '', '0.00', '', '', '', '2014-08-03 23:25:39', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('87', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '2', '0001-01-01 00:00:00', '1', '0', '0', '', '0.00', '发个不会', '', '', '2014-08-04 06:24:05', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('88', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-04 07:14:28', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-04 07:14:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('89', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-04 07:14:33', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-04 07:14:33', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('90', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '1', '0001-01-01 00:00:00', '1', '0', '0', '', '0.00', '发个不会', '', '', '2014-08-04 07:14:40', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('91', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-04 07:15:04', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-04 07:15:04', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('92', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-04 07:15:27', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-04 07:15:27', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('93', '130', '9,10', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '套餐1,套餐2', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-04 07:48:48', '0', '0', '0', '', '0.00', '发个不会', '干活', '13600887930', '2014-08-04 07:48:48', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('94', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '1', '2014-08-04 09:36:00', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '', '2014-08-04 09:36:31', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('95', '102', '7,8', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '肉包,馒头', '2,1', '2.5,1.5', '4.00', '4.00', '1', '0001-01-01 00:00:00', '1', '0', '0', '', '0.00', '', '', '', '2014-08-04 09:38:53', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('96', '106', '9', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '套餐1', '10', '12', '10.00', '10.00', '1', '0001-01-01 00:00:00', '1', '0', '0', '', '0.00', '', '', '', '2014-08-05 21:11:51', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('97', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-06 15:50:39', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-06 15:50:39', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('98', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-06 15:56:30', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-06 15:56:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('99', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-06 16:06:02', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-06 16:06:02', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('100', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-06 16:06:06', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-06 16:06:06', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('101', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-06 16:06:09', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-06 16:06:09', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('102', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-06 16:06:11', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-06 16:06:11', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('103', '106', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '1', '0001-01-01 00:00:00', '1', '0', '0', '', '0.00', '', '', '', '2014-08-06 21:48:01', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('104', '106', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-06 21:49:24', '0', '0', '0', '', '0.00', '', '', '13600887930', '2014-08-06 21:49:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('105', '106', '4,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '酱爆鱿鱼,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-06 23:17:28', '0', '0', '0', '', '0.00', '', '', '13600887930', '2014-08-06 23:17:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('106', '106', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-07 05:46:15', '0', '0', '0', '', '0.00', '', '', '13600887930', '2014-08-07 05:46:15', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('107', '106', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-07 05:47:32', '0', '0', '0', '', '0.00', '', '', '13600887930', '2014-08-07 05:47:32', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('108', '106', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-07 05:48:42', '0', '0', '0', '', '0.00', '', '', '13600887930', '2014-08-07 05:48:42', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('109', '106', '2', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '24.00', '24.00', '0', '2014-08-07 05:54:11', '0', '0', '0', '', '0.00', '', '', '13600887930', '2014-08-07 05:54:11', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('110', '106', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '1', '0001-01-01 00:00:00', '1', '0', '0', '', '0.00', '刚回家几节课', '', '', '2014-08-07 05:55:10', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('111', '106', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '1', '0001-01-01 00:00:00', '1', '0', '0', '', '0.00', '刚回家几节课', '', '', '2014-08-08 07:52:47', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('112', '3', '1,2', '2,300', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '3024.00', '3024.00', '0', '2014-08-09 00:06:01', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-09 00:06:01', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('113', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-09 23:01:57', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-09 23:01:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('114', '3', '3,4,5', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '42.00', '42.00', '0', '2014-08-09 23:02:13', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-09 23:02:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('115', '3', '3,4,5', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '42.00', '42.00', '0', '2014-08-09 23:11:59', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-09 23:11:59', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('116', '3', '3,4,5', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '42.00', '42.00', '0', '2014-08-10 08:45:51', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-10 08:45:51', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('117', '3', '3,4,5', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '42.00', '42.00', '0', '2014-08-10 08:47:35', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-10 08:47:35', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('118', '3', '1', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '1000.00', '1000.00', '0', '2014-08-10 08:54:58', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-10 08:54:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('119', '3', '1', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '1000.00', '1000.00', '0', '2014-08-10 08:54:58', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-10 08:54:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('120', '3', '1,2', '100,100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '2200.00', '2200.00', '0', '2014-08-10 08:55:58', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-10 08:55:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('121', '106', '2', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '24.00', '24.00', '1', '0001-01-01 00:00:00', '1', '0', '0', '', '0.00', '刚回家几节课', '', '', '2014-08-10 10:52:03', 'hhjjf', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('122', '3', '1,2', '100,100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '2200.00', '2200.00', '0', '2014-08-10 12:13:26', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-10 12:13:26', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('123', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-10 15:22:41', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-10 15:22:41', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('124', '3', '1', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '20.00', '20.00', '0', '2014-08-10 15:42:51', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-10 15:42:51', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('125', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-10 15:47:14', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '110', '2014-08-10 15:47:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('126', '102', '1,2,8,9', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉,馒头,套餐1', '10,12,1,10', '12,13,1.5,12', '33.00', '33.00', '0', '2014-08-10 17:02:18', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-10 17:02:18', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('127', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-10 17:05:45', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-10 17:05:45', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('128', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-10 17:11:08', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-10 17:11:08', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('129', '102', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-10 17:12:49', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-10 17:12:49', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('130', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '1', '2014-07-15 00:00:00', '0', '10', '1', '', '0.00', '福州', '隔壁老王', '', '2014-08-10 17:13:57', '老王我们一起去吃麻辣烫吧', '-1', '100', '满100减100元电子券', '10', '0');
INSERT INTO `orders` VALUES ('131', '102', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-10 17:36:17', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-10 17:36:17', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('132', '3', '1,2', '10,100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '1120.00', '1120.00', '0', '2014-08-10 18:40:07', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 18:40:07', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('133', '3', '1,2', '10,100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '1120.00', '1120.00', '0', '2014-08-10 18:42:58', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 18:42:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('134', '3', '1,2', '25,100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '1300.00', '1300.00', '0', '2014-08-10 20:15:10', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 20:15:10', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('135', '3', '1,2', '25,100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '1300.00', '1300.00', '0', '2014-08-10 20:15:12', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 20:15:12', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('136', '3', '1,2', '25,100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '1300.00', '1300.00', '0', '2014-08-10 20:16:00', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 20:16:00', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('137', '3', '1,2', '25,45', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '750.00', '750.00', '0', '2014-08-10 20:21:01', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 20:21:01', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('138', '3', '1,2', '21,100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '1252.00', '1252.00', '0', '2014-08-10 20:29:25', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 20:29:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('139', '3', '1', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '1000.00', '1000.00', '0', '2014-08-10 20:47:13', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 20:47:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('140', '3', '1', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '1000.00', '1000.00', '0', '2014-08-10 20:53:47', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 20:53:47', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('141', '3', '1,5,9', '1,1,100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,莆田卤面,套餐1', '10,10,10', '12,12,12', '1020.00', '1020.00', '0', '2014-08-10 20:59:16', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 20:59:16', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('142', '3', '4,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '酱爆鱿鱼,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-10 20:59:30', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 20:59:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('143', '3', '3,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-10 21:01:19', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 21:01:19', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('144', '3', '4,9', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '酱爆鱿鱼,套餐1', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-10 21:19:29', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 21:19:29', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('145', '3', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-10 21:20:13', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 21:20:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('146', '3', '1', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '1000.00', '1000.00', '0', '2014-08-10 21:20:56', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 21:20:56', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('147', '3', '1', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '1000.00', '1000.00', '0', '2014-08-10 21:24:35', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 21:24:35', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('148', '3', '1', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '1000.00', '1000.00', '0', '2014-08-10 21:26:14', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 21:26:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('149', '3', '1', '100', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '1000.00', '1000.00', '0', '2014-08-10 21:41:16', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 21:41:16', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('150', '3', '3,4,9', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,套餐1', '10,12,10', '12,13,12', '44.00', '44.00', '0', '2014-08-10 22:27:28', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 22:27:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('151', '3', '9', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '套餐1', '10', '12', '10.00', '10.00', '0', '2014-08-10 22:30:14', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 22:30:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('152', '3', '9', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '套餐1', '10', '12', '10.00', '10.00', '0', '2014-08-10 22:32:46', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 22:32:46', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('153', '3', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-10 22:36:37', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-10 22:36:37', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('154', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-11 16:01:46', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-11 16:01:46', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('155', '3', '1,2,4,5,9', '1,1,4,6,9', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉,酱爆鱿鱼,莆田卤面,套餐1', '10,12,12,10,10', '12,13,13,12,12', '220.00', '220.00', '0', '2014-08-11 22:16:34', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-11 22:16:34', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('156', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-11 23:53:31', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-11 23:53:31', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('157', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '1', '2014-08-11 23:54:32', '1', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-11 23:54:32', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('158', '3', '1,4,5', '1,2,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '54.00', '54.00', '0', '2014-08-11 23:57:50', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-11 23:57:50', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('159', '3', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-11 23:59:04', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-11 23:59:04', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('160', '3', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-12 00:00:07', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:00:07', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('161', '3', '1,2,3,5', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉,目鱼筒骨,莆田卤面', '10,12,10,10', '12,13,12,12', '42.00', '42.00', '0', '2014-08-12 00:05:28', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:05:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('162', '3', '2,3,4', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨,酱爆鱿鱼', '12,10,12', '13,12,13', '34.00', '34.00', '0', '2014-08-12 00:06:03', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:06:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('163', '3', '6,9', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '炒米线,套餐1', '12,10', '13,12', '34.00', '34.00', '0', '2014-08-12 00:06:39', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:06:39', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('164', '3', '9', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '套餐1', '10', '12', '10.00', '10.00', '0', '2014-08-12 00:06:51', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:06:51', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('165', '3', '7', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '肉包', '2', '2.5', '2.00', '2.00', '0', '2014-08-12 00:07:02', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:07:02', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('166', '3', '7', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '肉包', '2', '2.5', '2.00', '2.00', '0', '2014-08-12 00:07:20', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:07:20', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('167', '3', '1', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '20.00', '20.00', '0', '2014-08-12 00:07:38', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:07:38', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('168', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-12 00:08:09', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:08:09', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('169', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-12 00:12:28', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:12:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('170', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-12 00:14:35', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:14:35', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('171', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-12 00:15:57', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:15:57', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('172', '3', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-12 00:16:44', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:16:44', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('173', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-12 00:17:25', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:17:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('174', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '1', '2014-08-13 00:31:00', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:31:11', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('175', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-12 00:31:13', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:31:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('176', '3', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-12 00:31:17', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:31:17', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('177', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-12 00:31:26', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:31:26', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('178', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '1', '2014-08-12 00:31:00', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:31:43', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('179', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-12 00:33:23', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:33:23', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('180', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-12 00:33:28', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:33:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('181', '3', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-12 00:34:02', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:34:02', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('182', '3', '9', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '套餐1', '10', '12', '10.00', '10.00', '0', '2014-08-12 00:35:35', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:35:35', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('183', '3', '6,29', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,/bg/File/100/image/goods/20140730/Koala.jpg', '啦啦啦有肉冲啊,阿萨德发啊实得分', '炒米线,新增商品', '12,23', '13,45', '35.00', '35.00', '0', '2014-08-12 00:36:19', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:36:19', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('184', '3', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-12 00:36:23', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:36:23', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('185', '3', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-12 00:37:12', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:37:12', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('186', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-12 00:37:31', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:37:31', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('187', '3', '1,2', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '32.00', '32.00', '0', '2014-08-12 00:37:50', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:37:50', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('188', '3', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-12 00:38:05', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:38:05', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('189', '3', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-12 00:38:21', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:38:21', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('190', '3', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-12 00:39:03', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:39:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('191', '3', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-12 00:40:38', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:40:38', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('192', '3', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-12 00:41:17', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:41:17', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('193', '3', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-12 00:42:40', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234', '2014-08-12 00:42:40', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('194', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-12 01:25:57', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-12 01:25:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('195', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '1', '2014-08-12 16:54:00', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-12 16:54:06', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('196', '3', '1', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '20.00', '20.00', '0', '2014-08-12 16:59:57', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-12 16:59:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('197', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-12 19:55:39', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-12 19:55:39', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('198', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-12 19:58:09', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-12 19:58:09', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('199', '3', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-12 19:58:32', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-12 19:58:32', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('200', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-12 20:46:52', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-12 20:46:52', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('201', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-12 21:49:03', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-12 21:49:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('202', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-12 21:49:04', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-12 21:49:04', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('203', '106', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-12 23:50:12', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-12 23:50:12', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('204', '106', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-13 21:55:10', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-13 21:55:10', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('205', '3', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-14 23:18:07', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-14 23:18:07', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('206', '3', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-14 23:18:19', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-14 23:18:19', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('207', '3', '1,2', '2,8', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FF,啦啦啦有肉冲啊', '榨菜肉丝,茄子酱肉', '10,12', '12,13', '104.00', '104.00', '0', '2014-08-15 21:29:06', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-15 21:29:06', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('208', '3', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-15 21:45:56', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-15 21:45:56', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('209', '3', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-15 21:46:10', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-15 21:46:10', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('210', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-15 21:46:17', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-15 21:46:17', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('211', '3', '7,8', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '肉包,馒头', '2,1', '2.5,1.5', '4.00', '4.00', '0', '2014-08-15 21:46:56', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-15 21:46:56', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('212', '3', '7,8', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '肉包,馒头', '2,1', '2.5,1.5', '3.00', '3.00', '0', '2014-08-15 21:47:39', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-15 21:47:39', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('213', '3', '7', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '肉包', '2', '2.5', '2.00', '2.00', '0', '2014-08-15 21:49:16', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-15 21:49:16', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('214', '3', '6,9', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '炒米线,套餐1', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-15 21:51:49', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-15 21:51:49', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('215', '106', '8', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '馒头', '1', '1.5', '1.00', '1.00', '0', '2014-08-15 21:52:57', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-15 21:52:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('216', '106', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-15 21:53:22', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-15 21:53:22', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('217', '3', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FF', '榨菜肉丝', '10', '12', '10.00', '10.00', '0', '2014-08-15 23:13:25', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-15 23:13:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('218', '106', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-16 14:42:50', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-16 14:42:50', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('219', '106', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-16 14:43:19', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-16 14:43:19', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('220', '106', '4', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '酱爆鱿鱼', '12', '13', '12.00', '12.00', '0', '2014-08-16 14:48:09', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-16 14:48:09', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('221', '106', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '1', '2014-08-16 14:49:00', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-16 14:49:00', '北斗星', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('222', '106', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '1', '2014-08-16 15:23:04', '1', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-16 15:23:04', 'ghjj', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('223', '106', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-16 15:24:21', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-16 15:24:21', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('224', '106', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-16 15:30:36', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-16 15:30:36', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('225', '3', '1,2', '2,5', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '74.00', '74.00', '0', '2014-08-16 16:54:08', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-16 16:54:08', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('226', '3', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-16 16:54:31', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-16 16:54:31', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('227', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-16 18:11:20', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-16 18:11:20', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('228', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-16 18:13:32', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-16 18:13:32', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('229', '137', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-17 00:26:24', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 00:26:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('230', '137', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-17 00:26:56', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 00:26:56', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('231', '137', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-17 12:17:52', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 12:17:52', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('232', '137', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-17 12:19:04', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 12:19:04', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('233', '106', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-17 14:22:54', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-17 14:22:54', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('234', '106', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-17 14:29:41', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-17 14:29:41', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('235', '106', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-17 14:43:18', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-17 14:43:18', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('236', '106', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-17 15:34:19', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-17 15:34:19', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('237', '106', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-17 15:35:50', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-17 15:35:50', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('238', '137', '1', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '20.00', '20.00', '1', '2014-08-17 15:37:00', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 15:37:16', '发反反复复', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('239', '137', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-17 18:39:57', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 18:39:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('240', '137', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-17 19:36:04', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 19:36:04', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('241', '137', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-17 19:36:34', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 19:36:34', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('242', '137', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-17 19:47:06', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 19:47:06', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('243', '137', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-17 20:10:51', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 20:10:51', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('244', '137', '1,2,3', '3,3,4', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '108.00', '108.00', '0', '2014-08-17 21:39:45', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 21:39:45', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('245', '137', '1,2', '5,5', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '110.00', '110.00', '0', '2014-08-17 21:42:25', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 21:42:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('246', '3', '1,2', '10,200', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '2120.00', '2120.00', '0', '2014-08-17 22:06:06', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-17 22:06:06', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('247', '137', '1,2', '4,5', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '100.00', '100.00', '0', '2014-08-17 22:14:28', '0', '0', '0', '', '0.00', '', '', '', '2014-08-17 22:14:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('248', '137', '1,2', '4,5', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '100.00', '100.00', '2', '2014-08-16 22:25:00', '0', '0', '20', '', '0.00', '', '', '', '2014-08-17 22:25:36', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('249', '106', '1,2,10,29', '1,1,1,8', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,/bg/File/100/image/goods/20140730/Koala.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,阿萨德发啊实得分', '榨菜肉丝1,茄子酱肉,套餐2,新增商品', '10,12,12,23', '12,13,13,45', '141.00', '141.00', '0', '2014-08-17 22:39:54', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-17 22:39:54', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('250', '106', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '10.00', '10.00', '0', '2014-08-17 22:46:46', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-17 22:46:46', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('251', '106', '1,2,3,4,5,10', '1,1,1,1,1,10', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼,莆田卤面,套餐2', '10,12,10,12,10,12', '12,13,12,13,12,13', '174.00', '174.00', '0', '2014-08-17 22:48:25', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-17 22:48:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('252', '106', '2', '10', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '120.00', '120.00', '0', '2014-08-17 22:50:00', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-17 22:50:00', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('253', '106', '2', '10', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '20.00', '120.00', '1', '2014-08-17 22:52:33', '1', '0', '18', '', '100.00', '刚回家几节课', '腹股沟', '13600887930', '2014-08-17 22:52:33', '', '1', '100', '满100减100元电子券', '10', '0');
INSERT INTO `orders` VALUES ('254', '106', '8', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '馒头', '1', '1.5', '1.00', '1.00', '0', '2014-08-17 22:59:20', '0', '0', '0', '', '0.00', '刚回家几节课', '腹股沟', '1360088793', '2014-08-17 22:59:20', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('255', '137', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-18 23:16:13', '0', '0', '0', '', '0.00', '', '', '', '2014-08-18 23:16:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('256', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-18 23:16:25', '0', '0', '0', '', '0.00', '隔壁', '隔壁老王', '1101234122', '2014-08-18 23:16:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('257', '137', '2,3', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '32.00', '32.00', '0', '2014-08-18 23:17:43', '0', '0', '0', '', '0.00', '', '', '', '2014-08-18 23:17:43', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('258', '137', '2,3', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '32.00', '32.00', '0', '2014-08-18 23:18:15', '0', '0', '0', '', '0.00', '', '', '', '2014-08-18 23:18:15', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('259', '137', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-18 23:20:14', '0', '0', '0', '', '0.00', '', '', '', '2014-08-18 23:20:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('260', '137', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-18 23:20:35', '0', '0', '0', '', '0.00', '', '', '', '2014-08-18 23:20:35', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('261', '130', '9', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '套餐1', '10', '12', '9.00', '10.00', '0', '2014-08-22 23:57:52', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-22 23:57:52', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('262', '130', '9', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '套餐1', '10', '12', '9.00', '10.00', '0', '2014-08-22 23:58:03', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-22 23:58:03', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('263', '130', '7', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '肉包', '2', '2.5', '1.80', '2.00', '0', '2014-08-24 15:46:01', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 15:46:01', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('264', '130', '4,7', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '酱爆鱿鱼,肉包', '12,2', '13,2.5', '12.60', '14.00', '0', '2014-08-24 16:03:47', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 16:03:47', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('265', '130', '4,7', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '酱爆鱿鱼,肉包', '12,2', '13,2.5', '12.60', '14.00', '0', '2014-08-24 16:04:08', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 16:04:08', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('266', '137', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-24 17:01:46', '0', '0', '0', '', '0.00', '', '', '', '2014-08-24 17:01:46', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('267', '137', '10', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '套餐2', '12', '13', '12.00', '12.00', '0', '2014-08-24 17:02:33', '0', '0', '0', '', '0.00', '', '', '', '2014-08-24 17:02:33', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('268', '137', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-24 17:04:52', '0', '0', '0', '', '0.00', '', '', '', '2014-08-24 17:04:52', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('269', '137', '8', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '馒头', '1', '1.5', '1.00', '1.00', '0', '2014-08-24 17:22:21', '0', '0', '0', '', '0.00', '', '', '', '2014-08-24 17:22:21', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('270', '137', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-24 17:22:57', '0', '0', '0', '', '0.00', '', '', '', '2014-08-24 17:22:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('271', '137', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-24 17:23:14', '0', '0', '0', '', '0.00', '', '', '', '2014-08-24 17:23:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('272', '137', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '2', '2014-08-24 17:29:05', '0', '0', '0', '', '0.00', '', '', '', '2014-08-24 17:29:05', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('273', '137', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '1', '2014-08-24 09:33:00', '0', '0', '0', '', '0.00', '', '', '', '2014-08-24 17:33:13', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('274', '130', '4,7', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '酱爆鱿鱼,肉包', '12,2', '13,2.5', '12.60', '14.00', '0', '2014-08-24 18:03:19', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 18:03:19', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('275', '130', '4,7', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '酱爆鱿鱼,肉包', '12,2', '13,2.5', '12.60', '14.00', '0', '2014-08-24 18:06:14', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 18:06:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('276', '130', '3,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '19.80', '22.00', '0', '2014-08-24 18:08:38', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 18:08:38', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('277', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '19.80', '22.00', '0', '2014-08-24 18:17:14', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 18:17:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('278', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '19.80', '22.00', '0', '2014-08-24 18:17:18', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 18:17:18', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('279', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '19.80', '22.00', '0', '2014-08-24 18:17:22', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 18:17:22', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('280', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '19.80', '22.00', '0', '2014-08-24 20:12:30', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 20:12:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('281', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '19.80', '22.00', '1', '2014-08-24 20:12:36', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 20:12:36', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('282', '130', '2,5,9', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面,套餐1', '12,10,10', '13,12,12', '28.80', '32.00', '0', '2014-08-24 20:12:42', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 20:12:42', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('283', '137', '29', '1', '/bg/File/100/image/goods/20140730/Koala.jpg', '阿萨德发啊实得分', '新增商品', '23', '45', '23.00', '23.00', '0', '2014-08-24 21:03:55', '0', '0', '0', '', '0.00', '', '', '', '2014-08-24 21:03:55', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('284', '130', '3,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '19.80', '22.00', '0', '2014-08-24 21:17:24', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 21:17:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('285', '130', '5', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '莆田卤面', '10', '12', '9.00', '10.00', '0', '2014-08-24 21:17:34', '0', '0', '0', '', '0.00', '', '', '18120807353', '2014-08-24 21:17:34', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('286', '137', '29', '1', '/bg/File/100/image/goods/20140730/Koala.jpg', '阿萨德发啊实得分', '新增商品', '23', '45', '23.00', '23.00', '0', '2014-08-24 21:51:24', '0', '0', '0', '', '0.00', '', '', '', '2014-08-24 21:51:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('287', '137', '29', '1', '/bg/File/100/image/goods/20140730/Koala.jpg', '阿萨德发啊实得分', '新增商品', '23', '45', '23.00', '23.00', '0', '2014-08-24 21:51:28', '0', '0', '0', '', '0.00', '', '', '', '2014-08-24 21:51:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('288', '137', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-25 21:46:27', '0', '0', '0', '', '0.00', '', '', '', '2014-08-25 21:46:27', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('289', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 09:42:28', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 09:42:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('290', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-29 11:56:44', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 11:56:44', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('291', '102', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-29 11:56:58', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 11:56:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('292', '102', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-29 11:57:06', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 11:57:06', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('293', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-29 11:57:16', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 11:57:16', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('294', '102', '3,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 12:07:35', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 12:07:35', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('295', '102', '1,2', '1,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '46.00', '46.00', '0', '2014-08-29 12:08:12', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 12:08:12', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('296', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-29 12:08:53', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 12:08:53', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('297', '102', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-29 12:10:54', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 12:10:54', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('298', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-29 12:13:33', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 12:13:33', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('299', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 12:14:06', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 12:14:06', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('300', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-29 12:14:14', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 12:14:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('301', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-29 14:08:56', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 14:08:56', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('302', '102', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-29 15:07:34', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:07:34', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('303', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-29 15:08:14', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:08:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('304', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-29 15:16:29', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:16:29', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('305', '102', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-29 15:22:13', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:22:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('306', '102', '4', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '酱爆鱿鱼', '12', '13', '12.00', '12.00', '0', '2014-08-29 15:22:53', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:22:53', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('307', '102', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-29 15:26:20', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:26:20', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('308', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 15:35:29', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:35:29', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('309', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-29 15:36:20', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:36:20', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('310', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-29 15:37:13', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:37:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('311', '102', '2,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,酱爆鱿鱼', '12,12', '13,13', '24.00', '24.00', '0', '2014-08-29 15:39:02', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:39:02', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('312', '102', '1', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '20.00', '20.00', '0', '2014-08-29 15:46:47', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:46:47', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('313', '102', '3,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 15:49:40', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:49:40', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('314', '102', '4', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '酱爆鱿鱼', '12', '13', '12.00', '12.00', '0', '2014-08-29 15:52:24', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:52:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('315', '102', '3', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '20.00', '20.00', '0', '2014-08-29 15:52:28', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:52:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('316', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-29 15:52:39', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:52:39', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('317', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-29 15:53:22', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:53:22', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('318', '102', '1,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,酱爆鱿鱼', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 15:56:53', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:56:53', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('319', '102', '3,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 15:59:50', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 15:59:50', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('320', '102', '3,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 16:00:25', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:00:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('321', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-29 16:01:13', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:01:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('322', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-29 16:01:13', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:01:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('323', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-29 16:01:13', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:01:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('324', '102', '2,4', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,酱爆鱿鱼', '12,12', '13,13', '36.00', '36.00', '0', '2014-08-29 16:01:36', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:01:36', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('325', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-29 16:01:47', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:01:47', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('326', '102', '2,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,酱爆鱿鱼', '12,12', '13,13', '24.00', '24.00', '0', '2014-08-29 16:01:56', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:01:56', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('327', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 16:04:20', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:04:20', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('328', '102', '3', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '20.00', '20.00', '0', '2014-08-29 16:04:53', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:04:53', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('329', '102', '4', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '酱爆鱿鱼', '12', '13', '12.00', '12.00', '0', '2014-08-29 16:05:39', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:05:39', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('330', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 16:05:56', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:05:56', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('331', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-29 16:06:02', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:06:02', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('332', '102', '4', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '酱爆鱿鱼', '12', '13', '12.00', '12.00', '0', '2014-08-29 16:06:16', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:06:16', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('333', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-29 16:06:21', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:06:21', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('334', '102', '3,7,8', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,肉包,馒头', '10,2,1', '12,2.5,1.5', '23.00', '23.00', '0', '2014-08-29 16:09:18', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:09:18', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('335', '102', '4', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '酱爆鱿鱼', '12', '13', '12.00', '12.00', '0', '2014-08-29 16:09:24', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:09:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('336', '102', '1', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '20.00', '20.00', '0', '2014-08-29 16:09:28', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:09:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('337', '102', '2,4', '1,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,酱爆鱿鱼', '12,12', '13,13', '48.00', '48.00', '0', '2014-08-29 16:22:11', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:22:11', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('338', '102', '2,4', '1,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,酱爆鱿鱼', '12,12', '13,13', '48.00', '48.00', '0', '2014-08-29 16:22:11', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:22:11', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('339', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-29 16:22:27', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:22:27', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('340', '102', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-29 16:24:04', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:24:04', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('341', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-29 16:25:17', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:25:17', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('342', '102', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-29 16:25:33', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:25:33', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('343', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:26:32', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:26:32', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('344', '102', '7,8', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '肉包,馒头', '2,1', '2.5,1.5', '4.00', '4.00', '0', '2014-08-29 16:27:21', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:27:21', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('345', '102', '9,10', '2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '套餐1,套餐2', '10,12', '12,13', '54.00', '54.00', '0', '2014-08-29 16:27:58', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:27:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('346', '102', '2,29', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,/bg/File/100/image/goods/20140730/Koala.jpg', '啦啦啦有肉冲啊,阿萨德发啊实得分', '茄子酱肉,新增商品', '12,23', '13,45', '35.00', '35.00', '0', '2014-08-29 16:28:21', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:28:21', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('347', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:29:02', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:29:02', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('348', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:29:17', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:29:17', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('349', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:29:23', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:29:23', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('350', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:29:24', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:29:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('351', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:29:25', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:29:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('352', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:29:25', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:29:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('353', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:29:26', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:29:26', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('354', '102', '9,10', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '套餐1,套餐2', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 16:29:33', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:29:33', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('355', '102', '8,9', '2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '馒头,套餐1', '1,10', '1.5,12', '23.00', '23.00', '0', '2014-08-29 16:31:27', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:31:27', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('356', '102', '8,9', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '馒头,套餐1', '1,10', '1.5,12', '12.00', '12.00', '0', '2014-08-29 16:35:30', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:35:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('357', '102', '8,9', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '馒头,套餐1', '1,10', '1.5,12', '12.00', '12.00', '0', '2014-08-29 16:35:30', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:35:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('358', '102', '8,9', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '馒头,套餐1', '1,10', '1.5,12', '12.00', '12.00', '0', '2014-08-29 16:35:30', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:35:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('359', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:35:59', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:35:59', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('360', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:36:01', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:36:01', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('361', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:36:02', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:36:02', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('362', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:36:03', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:36:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('363', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:36:04', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:36:04', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('364', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:36:27', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:36:27', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('365', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:36:28', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:36:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('366', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:36:29', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:36:29', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('367', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:36:30', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:36:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('368', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:36:30', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:36:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('369', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 16:36:31', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:36:31', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('370', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-29 16:49:23', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:49:23', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('371', '102', '3,4', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '32.00', '32.00', '0', '2014-08-29 16:58:05', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:58:05', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('372', '102', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-29 16:59:00', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 16:59:00', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('373', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-29 17:03:19', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:03:19', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('374', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-29 17:03:25', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:03:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('375', '102', '2,3', '1,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '46.00', '46.00', '0', '2014-08-29 17:03:35', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:03:35', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('376', '102', '3,4', '2,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '44.00', '44.00', '0', '2014-08-29 17:04:02', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:04:02', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('377', '102', '1', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '20.00', '20.00', '0', '2014-08-29 17:04:07', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:04:07', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('378', '102', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-29 17:05:04', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:05:04', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('379', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-29 17:11:58', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:11:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('380', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 17:13:04', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:13:04', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('381', '102', '3', '2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '20.00', '20.00', '0', '2014-08-29 17:13:08', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:13:08', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('382', '102', '4', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '酱爆鱿鱼', '12', '13', '12.00', '12.00', '0', '2014-08-29 17:13:47', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:13:47', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('383', '102', '3,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 17:15:07', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:15:07', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('384', '102', '3,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 17:15:07', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:15:07', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('385', '102', '2,3', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '32.00', '32.00', '0', '2014-08-29 17:15:43', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:15:43', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('386', '102', '1,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,酱爆鱿鱼', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 17:17:24', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:17:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('387', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-29 17:18:03', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:18:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('388', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-29 17:18:14', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:18:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('389', '102', '2,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,酱爆鱿鱼', '12,12', '13,13', '24.00', '24.00', '0', '2014-08-29 17:18:26', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:18:26', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('390', '102', '1,3', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '30.00', '30.00', '0', '2014-08-29 17:18:40', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:18:40', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('391', '102', '4', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '酱爆鱿鱼', '12', '13', '12.00', '12.00', '0', '2014-08-29 17:18:44', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:18:44', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('392', '102', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-29 17:20:22', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:20:22', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('393', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-29 17:20:27', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:20:27', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('394', '102', '3,29', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,/bg/File/100/image/goods/20140730/Koala.jpg', '啦啦啦有肉冲啊,阿萨德发啊实得分', '目鱼筒骨,新增商品', '10,23', '12,45', '33.00', '33.00', '0', '2014-08-29 17:20:39', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:20:39', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('395', '102', '9,10', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '套餐1,套餐2', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-29 17:21:00', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:21:00', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('396', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-29 17:22:02', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:22:02', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('397', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-29 17:22:05', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:22:05', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('398', '102', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-29 17:22:14', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:22:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('399', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-29 17:22:24', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:22:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('400', '102', '1,2,4', '1,1,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,酱爆鱿鱼', '10,12,12', '12,13,13', '58.00', '58.00', '0', '2014-08-29 17:23:30', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:23:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('401', '102', '2,3,4', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨,酱爆鱿鱼', '12,10,12', '13,12,13', '44.00', '44.00', '0', '2014-08-29 17:24:16', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:24:16', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('402', '102', '1,2,3', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '42.00', '42.00', '0', '2014-08-29 17:24:24', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:24:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('403', '102', '2,4,5,6', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,酱爆鱿鱼,莆田卤面,炒米线', '12,12,10,12', '13,13,12,13', '46.00', '46.00', '0', '2014-08-29 17:24:42', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:24:42', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('404', '102', '1,8,9,10,29', '1,1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,/bg/File/100/image/goods/20140730/Koala.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊,阿萨德发啊实得分', '榨菜肉丝1,馒头,套餐1,套餐2,新增商品', '10,1,10,12,23', '12,1.5,12,13,45', '56.00', '56.00', '0', '2014-08-29 17:24:54', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:24:54', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('405', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-29 17:25:05', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:25:05', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('406', '102', '1,2,3,4', '1,1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '56.00', '56.00', '0', '2014-08-29 17:25:18', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:25:18', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('407', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-29 17:25:30', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:25:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('408', '102', '2,3,4', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨,酱爆鱿鱼', '12,10,12', '13,12,13', '34.00', '34.00', '0', '2014-08-29 17:25:58', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:25:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('409', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-29 17:26:09', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:26:09', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('410', '102', '2,3', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '32.00', '32.00', '0', '2014-08-29 17:31:03', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:31:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('411', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-29 17:31:14', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:31:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('412', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-29 17:32:58', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:32:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('413', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-29 17:33:02', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:33:02', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('414', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-29 17:33:10', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:33:10', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('415', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-29 17:38:29', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:38:29', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('416', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-29 17:38:30', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:38:30', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('417', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-29 17:39:00', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:39:00', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('418', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:39:20', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:39:20', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('419', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-29 17:45:48', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:45:48', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('420', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:47:47', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:47:47', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('421', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:49:10', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:49:10', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('422', '3', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:50:50', '0', '0', '0', '', '0.00', '隔壁', 'wangnima', '11086', '2014-08-29 17:50:50', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('423', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:51:49', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:51:49', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('424', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:55:54', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:55:54', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('425', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-29 17:56:23', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:56:23', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('426', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:05', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:05', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('427', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:06', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:06', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('428', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:06', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:06', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('429', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:07', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:07', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('430', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:08', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:08', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('431', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:08', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:08', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('432', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:09', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:09', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('433', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:09', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:09', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('434', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:10', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:10', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('435', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:10', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:10', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('436', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:11', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:11', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('437', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:11', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:11', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('438', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:11', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:11', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('439', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:11', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:11', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('440', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:12', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:12', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('441', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:12', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:12', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('442', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:12', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:12', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('443', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:12', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:12', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('444', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:13', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('445', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:13', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('446', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:13', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('447', '102', '3,4,5', '1,2,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼,莆田卤面', '10,12,10', '12,13,12', '66.00', '66.00', '0', '2014-08-29 17:57:14', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:57:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('448', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-29 17:59:34', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 17:59:34', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('449', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-29 18:02:45', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 18:02:45', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('450', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-29 18:54:03', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-29 18:54:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('451', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-30 04:53:04', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 04:53:04', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('452', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 04:58:54', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 04:58:54', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('453', '102', '2,3,4', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨,酱爆鱿鱼', '12,10,12', '13,12,13', '34.00', '34.00', '0', '2014-08-30 05:00:12', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:00:12', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('454', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:01:22', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:01:22', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('455', '102', '2,3,4', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨,酱爆鱿鱼', '12,10,12', '13,12,13', '34.00', '34.00', '0', '2014-08-30 05:02:52', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:02:52', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('456', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:05:29', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:05:29', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('457', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-30 05:06:04', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:06:04', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('458', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-30 05:06:58', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:06:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('459', '102', '1,2,3', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '42.00', '42.00', '0', '2014-08-30 05:08:56', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:08:56', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('460', '102', '2,3,4', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨,酱爆鱿鱼', '12,10,12', '13,12,13', '46.00', '46.00', '0', '2014-08-30 05:09:37', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:09:37', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('461', '102', '1,2,3', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '42.00', '42.00', '0', '2014-08-30 05:11:08', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:11:08', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('462', '102', '1,3', '1,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '40.00', '40.00', '0', '2014-08-30 05:13:53', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:13:53', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('463', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:15:21', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:15:21', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('464', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:15:57', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:15:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('465', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:18:15', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:18:15', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('466', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:19:44', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:19:44', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('467', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:20:33', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:20:33', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('468', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:24:59', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:24:59', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('469', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:25:58', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:25:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('470', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:27:01', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:27:01', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('471', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-30 05:29:09', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:29:09', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('472', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:39:52', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:39:52', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('473', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:40:57', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:40:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('474', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-30 05:44:43', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:44:43', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('475', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:54:53', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:54:53', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('476', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 05:56:37', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 05:56:37', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('477', '102', '2,3,4', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨,酱爆鱿鱼', '12,10,12', '13,12,13', '34.00', '34.00', '0', '2014-08-30 06:00:18', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:00:18', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('478', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-30 06:02:11', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:02:11', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('479', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:02:51', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:02:51', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('480', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:04:06', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:04:06', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('481', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:05:41', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:05:41', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('482', '102', '2,3,4', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨,酱爆鱿鱼', '12,10,12', '13,12,13', '34.00', '34.00', '0', '2014-08-30 06:06:19', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:06:19', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('483', '102', '1,3,4', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨,酱爆鱿鱼', '10,10,12', '12,12,13', '32.00', '32.00', '0', '2014-08-30 06:08:12', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:08:12', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('484', '102', '1,2,3', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '44.00', '44.00', '0', '2014-08-30 06:10:02', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:10:02', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('485', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-30 06:12:24', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:12:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('486', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-30 06:12:55', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:12:55', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('487', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-30 06:14:27', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:14:27', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('488', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-30 06:18:57', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:18:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('489', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:19:39', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:19:39', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('490', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:20:07', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:20:07', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('491', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-30 06:22:59', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:22:59', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('492', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '2', '2014-08-30 00:00:00', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:23:31', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('493', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:26:26', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:26:26', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('494', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:32:25', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:32:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('495', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:34:59', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:34:59', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('496', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:36:41', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:36:41', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('497', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-30 06:38:19', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:38:19', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('498', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-30 06:38:20', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:38:20', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('499', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:39:00', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:39:00', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('500', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:40:45', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:40:45', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('501', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-30 06:42:10', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-30 06:42:10', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('502', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 11:07:36', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 11:07:36', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('503', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-31 11:09:23', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 11:09:23', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('504', '102', '1,2,3,4', '1,1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '44.00', '44.00', '0', '2014-08-31 12:49:14', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 12:49:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('505', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '10.80', '12.00', '0', '2014-08-31 12:55:29', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 12:55:29', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('506', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '10.80', '12.00', '0', '2014-08-31 13:40:03', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 13:40:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('507', '130', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '10.80', '12.00', '0', '2014-08-31 13:40:10', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 13:40:10', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('508', '130', '2,5', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,莆田卤面', '12,10', '13,12', '19.80', '22.00', '0', '2014-08-31 13:49:25', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 13:49:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('509', '102', '1,2,3,4', '1,1,2,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨,酱爆鱿鱼', '10,12,10,12', '12,13,12,13', '66.00', '66.00', '0', '2014-08-31 14:01:19', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 14:01:19', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('510', '102', '3,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 14:23:40', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 14:23:40', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('511', '130', '30', '2', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '18.00', '20.00', '0', '2014-08-31 15:55:09', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 15:55:09', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('512', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '2', '2014-08-31 00:00:00', '0', '0', '0', '', '0.00', '人际恐惧呢', '却吐', '15205065475', '2014-08-31 16:42:44', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('513', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 16:43:01', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 16:43:01', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('514', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 17:02:01', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 17:02:01', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('515', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-31 17:09:31', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 17:09:31', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('516', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 17:09:42', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 17:09:42', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('517', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '2', '2014-08-31 00:00:00', '0', '0', '0', '', '0.00', 'i i 刚刚给 v', '轻而', '15205065475', '2014-08-31 17:10:00', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('518', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-31 17:50:07', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 17:50:07', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('519', '130', '30', '2', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '18.00', '20.00', '0', '2014-08-31 17:52:41', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 17:52:41', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('520', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-31 17:52:45', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 17:52:45', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('521', '102', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-31 17:55:07', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 17:55:07', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('522', '102', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '2', '2014-08-31 00:00:00', '0', '0', '0', '', '0.00', '越饿', '企鹅体育', '15205065475', '2014-08-31 17:57:42', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('523', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '1', '2014-07-15 00:00:00', '2', '10', '0', '', '0.00', '福州', '隔壁老王', '15205065475', '2014-08-31 18:02:54', '老王我们一起去吃麻辣烫吧', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('524', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-31 18:21:03', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 18:21:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('525', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '0', '2014-08-31 18:24:15', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 18:24:15', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('526', '130', '30', '2', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '18.00', '20.00', '0', '2014-08-31 18:26:04', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 18:26:04', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('527', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '0', '2014-08-31 18:26:51', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 18:26:51', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('528', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 18:29:56', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 18:29:56', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('529', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-31 18:38:21', '0', '0', '0', '', '0.00', '', '', '15205065475', '2014-08-31 18:38:21', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('530', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-31 18:42:22', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 18:42:22', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('531', '130', '30', '2', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '18.00', '20.00', '0', '2014-08-31 18:43:03', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 18:43:03', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('532', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '0', '2014-08-31 18:45:42', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 18:45:42', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('533', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '0', '2014-08-31 18:56:46', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 18:56:46', '', '-1', '142', '', '10', '0');
INSERT INTO `orders` VALUES ('534', '130', '30', '2', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '18.00', '20.00', '0', '2014-08-31 18:58:35', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 18:58:35', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('535', '130', '30', '2', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '18.00', '20.00', '0', '2014-08-31 18:59:51', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 18:59:51', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('536', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 19:00:27', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:00:27', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('537', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '0', '2014-08-31 19:00:50', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 19:00:50', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('538', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '0', '2014-08-31 19:01:41', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 19:01:41', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('539', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-31 19:02:58', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:02:58', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('540', '102', '4', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '酱爆鱿鱼', '12', '13', '12.00', '12.00', '0', '2014-08-31 19:05:43', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:05:43', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('541', '102', '3,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,酱爆鱿鱼', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 19:10:09', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:10:09', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('542', '102', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-31 19:10:24', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:10:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('543', '102', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-31 19:11:09', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:11:09', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('544', '102', '2', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '12.00', '12.00', '0', '2014-08-31 19:11:14', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:11:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('545', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '1', '2014-08-31 19:13:10', '1', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 19:13:10', '', '1', '142', '', '10', '26');
INSERT INTO `orders` VALUES ('546', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '0', '2014-08-31 19:13:50', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 19:13:50', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('547', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '0', '2014-08-31 19:16:23', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 19:16:23', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('548', '102', '1,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '10,10', '12,12', '20.00', '20.00', '0', '2014-08-31 19:17:23', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:17:23', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('549', '102', '2,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,酱爆鱿鱼', '12,12', '13,13', '24.00', '24.00', '0', '2014-08-31 19:18:27', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:18:27', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('550', '102', '1,2', '1,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '46.00', '46.00', '0', '2014-08-31 19:42:25', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:42:25', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('551', '102', '1,2', '1,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '46.00', '46.00', '0', '2014-08-31 19:42:33', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:42:33', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('552', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-31 19:42:40', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 19:42:40', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('553', '102', '1,2', '1,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '46.00', '46.00', '0', '2014-08-31 20:00:54', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 20:00:54', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('554', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-31 20:01:01', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 20:01:01', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('555', '102', '2', '3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '茄子酱肉', '12', '13', '36.00', '36.00', '0', '2014-08-31 20:05:38', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 20:05:38', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('556', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 20:07:48', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 20:07:48', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('557', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 20:09:23', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 20:09:23', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('558', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 20:14:23', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 20:14:23', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('559', '102', '2,3', '1,3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '42.00', '42.00', '0', '2014-08-31 20:18:43', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 20:18:43', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('560', '102', '1,2', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '32.00', '32.00', '0', '2014-08-31 21:35:24', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 21:35:24', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('561', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '0', '2014-08-31 21:42:25', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 21:42:25', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('562', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '0', '2014-08-31 21:43:48', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 21:43:48', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('563', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 21:44:03', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 21:44:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('564', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-31 21:44:14', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 21:44:14', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('565', '102', '1,2', '1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '34.00', '34.00', '0', '2014-08-31 21:48:51', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 21:48:51', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('566', '102', '3', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊', '目鱼筒骨', '10', '12', '10.00', '10.00', '0', '2014-08-31 21:49:00', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 21:49:00', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('567', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '0', '2014-08-31 21:52:03', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 21:52:03', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('568', '102', '1,2,3', '1,1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '32.00', '32.00', '0', '2014-08-31 21:54:18', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 21:54:18', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('569', '102', '2,3', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,目鱼筒骨', '12,10', '13,12', '22.00', '22.00', '0', '2014-08-31 22:11:38', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 22:11:38', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('570', '130', '30', '1', '/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg', 'asd', 'asdasd', '10', '100', '9.00', '10.00', '0', '2014-08-31 22:12:51', '0', '0', '0', '', '0.00', '', '一点点', '18120807353', '2014-08-31 22:12:51', null, '0', '142', null, '10', '0');
INSERT INTO `orders` VALUES ('571', '102', '1', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '10', '12', '10.00', '10.00', '0', '2014-08-31 22:14:53', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 22:14:53', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('572', '102', '2,4', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '茄子酱肉,酱爆鱿鱼', '12,12', '13,13', '24.00', '24.00', '0', '2014-08-31 22:16:21', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 22:16:21', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('573', '102', '1,2,3', '1,1,2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉,目鱼筒骨', '10,12,10', '12,13,12', '44.00', '44.00', '0', '2014-08-31 22:17:57', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-08-31 22:17:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('574', '102', '1,2', '1,1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,茄子酱肉', '10,12', '12,13', '22.00', '22.00', '2', '2014-09-01 00:00:00', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-01 11:38:28', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('575', '102', '4', '1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_04.png', '啦啦啦有肉冲啊', '酱爆鱿鱼', '12', '13', '12.00', '12.00', '2', '2014-09-01 14:20:40', '1', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-01 14:20:40', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('576', '102', '5', '1', '/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '啦啦啦有肉冲啊', '莆田卤面', '10', '13', '10.00', '10.00', '0', '2014-09-01 21:48:50', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-01 21:48:50', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('577', '102', '1,3', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '17.00', '17.00', '0', '2014-09-01 23:43:56', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-01 23:43:56', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('578', '102', '3,5', '1,1', '/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,莆田卤面', '9,10', '12,13', '19.00', '19.00', '0', '2014-09-02 11:17:41', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 11:17:41', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('579', '102', '3,5', '1,1', '/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,莆田卤面', '9,10', '12,13', '19.00', '19.00', '0', '2014-09-02 11:17:48', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 11:17:48', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('580', '102', '5', '1', '/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '啦啦啦有肉冲啊', '莆田卤面', '10', '13', '10.00', '10.00', '0', '2014-09-02 11:17:59', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 11:17:59', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('581', '102', '1,3,5,31', '1,1,1,2', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼', '榨菜肉丝1,目鱼筒骨,莆田卤面,鸡蛋饼', '8,9,10,22', '11,12,13,26', '58.00', '58.00', '0', '2014-09-02 15:39:20', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 15:39:20', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('582', '3', '1', '3', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '8', '11', '24.00', '24.00', '0', '2014-09-02 18:33:39', '0', '0', '0', '', '0.00', '隔壁', 'wangnima', '11086', '2014-09-02 18:33:39', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('583', '102', '1', '1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '8', '11', '8.00', '8.00', '0', '2014-09-02 20:53:29', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 20:53:29', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('584', '102', '5', '1', '/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '啦啦啦有肉冲啊', '莆田卤面', '10', '13', '10.00', '10.00', '0', '2014-09-02 20:53:41', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 20:53:41', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('585', '102', '3,5', '1,1', '/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,莆田卤面', '9,10', '12,13', '19.00', '19.00', '0', '2014-09-02 20:54:00', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 20:54:00', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('586', '102', '1,3', '1,2', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '25.00', '25.00', '0', '2014-09-02 21:08:41', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 21:08:41', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('587', '102', '1', '1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '8', '11', '8.00', '8.00', '0', '2014-09-02 22:06:08', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 22:06:08', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('588', '102', '1,3', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '17.00', '17.00', '0', '2014-09-02 22:14:28', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 22:14:28', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('589', '102', '3,5', '1,1', '/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,莆田卤面', '9,10', '12,13', '19.00', '19.00', '0', '2014-09-02 22:18:27', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 22:18:27', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('590', '102', '1,3', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '17.00', '17.00', '0', '2014-09-02 22:19:10', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 22:19:10', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('591', '102', '1,3', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '17.00', '17.00', '0', '2014-09-02 22:29:26', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 22:29:26', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('592', '102', '1,3', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '17.00', '17.00', '0', '2014-09-02 22:34:17', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 22:34:17', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('593', '102', '1,3', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '17.00', '17.00', '0', '2014-09-02 22:40:55', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 22:40:55', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('594', '102', '1,3', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '17.00', '17.00', '0', '2014-09-02 22:52:57', '0', '0', '0', null, '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 22:52:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('595', '102', '1,3', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '17.00', '17.00', '0', '2014-09-02 22:52:57', '0', '0', '0', null, '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 22:52:57', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('596', '102', '1,3', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '17.00', '17.00', '0', '2014-09-02 23:34:30', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 23:34:30', '', '0', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('597', '102', '5,31', '1,1', '/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0.jpg', '啦啦啦有肉冲啊,鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼', '莆田卤面,鸡蛋饼', '10,22', '13,26', '32.00', '32.00', '0', '2014-09-02 23:43:06', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 23:43:06', '', '0', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('598', '102', '3,5', '1,2', '/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '啦啦啦有肉冲啊,啦啦啦有肉冲啊', '目鱼筒骨,莆田卤面', '9,10', '12,13', '28.00', '28.00', '0', '2014-09-02 23:47:54', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 23:47:54', '', '0', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('599', '148', '31', '1', '/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0.jpg', '鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼', '鸡蛋饼', '22', '26', '22.00', '22.00', '0', '2014-09-02 23:48:38', '0', '0', '0', null, '0.00', '', '', '13600887930', '2014-09-02 23:48:38', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('600', '102', '1,31', '1,2', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼', '榨菜肉丝1,鸡蛋饼', '8,22', '11,26', '38.00', '38.00', '0', '2014-09-02 23:54:10', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 23:54:10', '', '0', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('601', '102', '1,3,5,31', '1,1,1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊,啦啦啦有肉冲啊,鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼', '榨菜肉丝1,目鱼筒骨,莆田卤面,鸡蛋饼', '8,9,10,22', '11,12,13,26', '49.00', '49.00', '0', '2014-09-02 23:57:20', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-02 23:57:20', '', '0', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('602', '148', '31', '1', '/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0.jpg', '鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼', '鸡蛋饼', '22', '26', '22.00', '22.00', '0', '2014-09-03 00:03:13', '0', '0', '0', null, '0.00', '', '', '13600887930', '2014-09-03 00:03:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('603', '102', '1,3', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '17.00', '17.00', '0', '2014-09-03 00:04:58', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-03 00:04:58', '', '2', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('604', '102', '1,3', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,目鱼筒骨', '8,9', '11,12', '17.00', '17.00', '0', '2014-09-03 00:05:13', '0', '0', '0', null, '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-03 00:05:13', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('605', '148', '31', '1', '/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0.jpg', '鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼', '鸡蛋饼', '22', '26', '22.00', '22.00', '0', '2014-09-03 00:06:18', '0', '0', '0', null, '0.00', '', '', '13600887930', '2014-09-03 00:06:18', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('606', '148', '3', '1', '/bg/File/100/image/goods/20140901/u=20725595.3613037323&fm=21&gp=0.jpg', '啦啦啦有肉冲啊', '目鱼筒骨', '9', '12', '9.00', '9.00', '0', '2014-09-03 00:06:27', '0', '0', '0', '', '0.00', '', '', '13600887930', '2014-09-03 00:06:27', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('607', '148', '1', '1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '8', '11', '8.00', '8.00', '0', '2014-09-03 00:06:33', '0', '0', '0', null, '0.00', '', '', '13600887930', '2014-09-03 00:06:33', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('608', '102', '5', '1', '/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '啦啦啦有肉冲啊', '莆田卤面', '10', '13', '10.00', '10.00', '2', '2014-09-03 23:59:47', '1', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-03 23:59:47', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('609', '102', '5', '1', '/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '啦啦啦有肉冲啊', '莆田卤面', '10', '13', '10.00', '10.00', '2', '2014-09-04 00:00:56', '1', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-04 00:00:56', '', '1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('610', '102', '31', '1', '/bg/File/100/image/goods/20140901/u=3425888035.1983349493&fm=21&gp=0.jpg', '鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼鸡蛋饼', '鸡蛋饼', '22', '26', '22.00', '22.00', '0', '2014-09-04 09:36:40', '0', '0', '0', null, '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-04 09:36:40', null, '0', '100', null, '10', '0');
INSERT INTO `orders` VALUES ('611', '102', '1', '1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉', '榨菜肉丝1', '8', '11', '8.00', '8.00', '0', '2014-09-04 11:17:01', '0', '0', '0', '', '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-04 11:17:01', '', '-1', '100', '', '10', '0');
INSERT INTO `orders` VALUES ('612', '102', '1,5', '1,1', '/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg,/bg/File/100/image/goods/20140901/u=279121271.937951038&fm=21&gp=0.jpg', '啦啦啦有肉冲啊FFs是多少当时都王企鹅王企鹅全文请问但是多少王企鹅去温泉,啦啦啦有肉冲啊', '榨菜肉丝1,莆田卤面', '8,10', '11,13', '18.00', '18.00', '0', '2014-09-04 16:20:55', '0', '0', '0', null, '0.00', '好久哦也纷纷 v', '阿萨德风格', '15205065475', '2014-09-04 16:20:55', null, '0', '100', null, '10', '0');

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
INSERT INTO `param` VALUES ('1', 'PlatformCfg', '{\"PhoneAd\":{\"PicUrl\":\"/bg/File/1/image/goods/20140823/9e3e41d9jw1dz2eb7w384j.jpg\",\"JumpUrl\":\"http://www.baidu.com\"},\"MerchantAdStayTime\":3,\"MerchantAds\":[{\"PicUrl\":\"http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png\",\"JumpUrl\":\"http://www.baidu.com\"},{\"PicUrl\":\"http://182.254.137.180/bg/file/100/image/kulouwenhua_02.png\",\"JumpUrl\":\"http://www.baidu.com\"}],\"SignList\":[{\"Id\":1,\"Name\":\"模式A\",\"Prec\":7.0},{\"Id\":2,\"Name\":\"模式B\",\"Prec\":8.0},{\"Id\":3,\"Name\":\"模式C\",\"Prec\":10.0}]}', '开发方后台设置广告');
INSERT INTO `param` VALUES ('2', 'ExtcreditCfg', '{Charge:1,Share:10,Register:20,Consume:1,Comment:10}', '积分消费及获得');
INSERT INTO `param` VALUES ('3', 'MerchantCfg', '{\"SendPrice\":5,\"FreeSendPrice\":60,\"LoginAdStayTime\":1,\"LoginAdUrl\":\"/bg/File/100/image/goods/20140901/u=1966325563.3781173364&fm=21&gp=0.jpg\",\"WifiAdStayTime\":2,\"WifiAds\":[{\"PicUrl\":\"http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png\",\"JumpUrl\":\"http://www.baidu.com\"},{\"PicUrl\":\"/bg/File/100/image/goods/20140901/APP2副本.jpg\",\"JumpUrl\":\"#\"}]}', '商户配置信息');

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `Id` int(11) NOT NULL auto_increment,
  `SellerId` int(11) default NULL,
  `Name` varchar(50) default NULL COMMENT '名称',
  `Description` varchar(200) default NULL COMMENT '描述',
  `ImgUrl` varchar(200) default '' COMMENT '支付图片url',
  `Account` varchar(100) default '' COMMENT '支付用户账户',
  `PrivateKey` varchar(255) default '' COMMENT '私钥KEY',
  `Pid` varchar(100) default '' COMMENT 'PID',
  `AccountType` int(11) default '1' COMMENT '支付宝账号类型',
  `Status` int(11) default '0' COMMENT '支付状态 0：未启用 1：启用',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of payment
-- ----------------------------
INSERT INTO `payment` VALUES ('1', '100', '余额支付', '账号余额支付', '/bg/File/1/image/goods/20140824/logo3(2).png', 'd', 'd', 'd', '1', '1');
INSERT INTO `payment` VALUES ('2', '100', '支付宝支付', '支持支付宝余额，快捷等多种方式。', '/bg/File/1/image/goods/20140824/logo3.png', 'd', 'okkcs8za7xeuemhmbpmks2kd7agiqu8e', '2088511724484349', '1', '1');
INSERT INTO `payment` VALUES ('3', '100', '银联支付', '安全快捷，支持各大银行支付', '/bg/File/1/image/goods/20140824/logo3.png', 's', 's', 's', '1', '1');

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
  `Id` int(20) NOT NULL auto_increment,
  `ImgUrls` varchar(1000) default NULL,
  `Title` varchar(1000) NOT NULL,
  `Price` float default NULL,
  `Description` varchar(1000) default NULL,
  `Phone` varchar(50) default NULL,
  `Status` int(4) NOT NULL COMMENT '1:已经预定，0：还未预定',
  `SellerId` int(20) NOT NULL,
  `BoxTypeId` int(20) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of position
-- ----------------------------
INSERT INTO `position` VALUES ('1', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('2', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('3', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('4', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('5', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('6', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('7', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('8', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('9', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('10', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('11', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('12', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('13', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('14', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('15', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '1', '100', null);
INSERT INTO `position` VALUES ('16', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '0', '100', null);
INSERT INTO `position` VALUES ('17', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '0', '100', null);
INSERT INTO `position` VALUES ('18', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '0', '100', null);
INSERT INTO `position` VALUES ('19', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '位置测试', '1', 'Description', '1333330000', '0', '100', null);
INSERT INTO `position` VALUES ('20', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '1', 'test', '1333330000', '0', '142', '3');
INSERT INTO `position` VALUES ('21', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '2', null, '1333330000', '0', '142', '4');
INSERT INTO `position` VALUES ('22', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '5');
INSERT INTO `position` VALUES ('23', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '3');
INSERT INTO `position` VALUES ('24', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '3');
INSERT INTO `position` VALUES ('25', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '3');
INSERT INTO `position` VALUES ('26', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '4');
INSERT INTO `position` VALUES ('27', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '4');
INSERT INTO `position` VALUES ('28', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '5');
INSERT INTO `position` VALUES ('29', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '5');
INSERT INTO `position` VALUES ('30', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '5');
INSERT INTO `position` VALUES ('31', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '3');
INSERT INTO `position` VALUES ('32', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '5');
INSERT INTO `position` VALUES ('33', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '4');
INSERT INTO `position` VALUES ('34', 'http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png,http://182.254.137.180/bg/file/100/image/kulouwenhua_01.png', '测试', '100', 'test', '1333330000', '0', '142', '4');

-- ----------------------------
-- Table structure for push
-- ----------------------------
DROP TABLE IF EXISTS `push`;
CREATE TABLE `push` (
  `Id` int(11) NOT NULL auto_increment COMMENT '推送Id',
  `SellerId` int(11) NOT NULL,
  `Title` varchar(1000) NOT NULL COMMENT '推送标题',
  `Content` varchar(1000) default NULL COMMENT '推送内容',
  `PushType` int(11) unsigned zerofill NOT NULL COMMENT '推送类型',
  `TypeId` int(11) unsigned zerofill NOT NULL COMMENT '推送物品的Id',
  `CreateTime` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of push
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sharelog
-- ----------------------------
INSERT INTO `sharelog` VALUES ('1', '3', '0', '0', '', '2014-08-10 17:31:30');
INSERT INTO `sharelog` VALUES ('2', '3', '0', '0', '', '2014-08-11 16:01:37');
INSERT INTO `sharelog` VALUES ('3', '3', '0', '0', '', '2014-08-12 09:46:52');
INSERT INTO `sharelog` VALUES ('4', '3', '0', '0', '', '2014-08-12 09:47:07');

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
) ENGINE=InnoDB AUTO_INCREMENT=607 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shoppingcart
-- ----------------------------
INSERT INTO `shoppingcart` VALUES ('58', '118', '1', '1', '2014-08-02 22:13:51');
INSERT INTO `shoppingcart` VALUES ('59', '118', '2', '1', '2014-08-02 22:13:53');
INSERT INTO `shoppingcart` VALUES ('83', '137', '4', '1', '2014-08-25 21:46:00');
INSERT INTO `shoppingcart` VALUES ('84', '137', '5', '1', '2014-08-25 21:46:03');
INSERT INTO `shoppingcart` VALUES ('85', '0', '9', '1', '2014-08-28 23:05:46');
INSERT INTO `shoppingcart` VALUES ('86', '0', '8', '2', '2014-08-28 23:06:04');
INSERT INTO `shoppingcart` VALUES ('568', '137', '1', '3', '2014-09-02 18:24:40');
INSERT INTO `shoppingcart` VALUES ('606', '149', '3', '1', '2014-09-03 10:43:14');

-- ----------------------------
-- Table structure for temple
-- ----------------------------
DROP TABLE IF EXISTS `temple`;
CREATE TABLE `temple` (
  `Id` int(11) NOT NULL auto_increment,
  `LogoUrl` varchar(200) default '' COMMENT '模板logo',
  `Name` varchar(50) default NULL,
  `TypeId` int(11) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of temple
-- ----------------------------
INSERT INTO `temple` VALUES ('1', '/bg/File/1/image/goods/20140823/90627d01jw1dzlcx64dxcj.jpg', '模板1', '1');
INSERT INTO `temple` VALUES ('2', '/bg/File/1/image/goods/20140823/135460835581456.png', '模板2', '2');
INSERT INTO `temple` VALUES ('3', '/bg/File/1/image/goods/20140823/135460836012943.png', '模板3', '3');
INSERT INTO `temple` VALUES ('4', '/bg/File/1/image/goods/20140823/62037b5ajw1e082gfja81j.jpg', '模板3', '1');

-- ----------------------------
-- Table structure for timeline
-- ----------------------------
DROP TABLE IF EXISTS `timeline`;
CREATE TABLE `timeline` (
  `Id` int(11) NOT NULL auto_increment,
  `BeginTime` datetime NOT NULL,
  `EndTime` datetime NOT NULL,
  `PositionId` int(11) NOT NULL,
  `Title` varchar(1000) NOT NULL,
  `Status` int(11) NOT NULL,
  `SellerId` int(20) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timeline
-- ----------------------------
INSERT INTO `timeline` VALUES ('1', '2014-08-24 15:47:52', '2014-08-25 15:47:52', '19', '时间测试', '0', '142');
INSERT INTO `timeline` VALUES ('2', '2014-08-24 15:47:58', '2014-08-25 15:47:52', '20', '时间测试', '1', '142');

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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usercoupon
-- ----------------------------
INSERT INTO `usercoupon` VALUES ('1', '3', '1', '2014-07-20 17:10:57', '0');
INSERT INTO `usercoupon` VALUES ('2', '3', '2', '2014-07-20 17:11:27', '0');
INSERT INTO `usercoupon` VALUES ('3', '3', '3', '2014-07-21 20:58:13', '1');
INSERT INTO `usercoupon` VALUES ('4', '3', '4', '2014-07-21 20:58:35', '1');
INSERT INTO `usercoupon` VALUES ('5', '3', '5', '2014-07-21 21:02:39', '0');
INSERT INTO `usercoupon` VALUES ('6', '3', '6', '2014-07-21 21:02:41', '0');
INSERT INTO `usercoupon` VALUES ('7', '5', '1', '2014-08-02 22:39:50', '0');
INSERT INTO `usercoupon` VALUES ('8', '10', '1', '2014-08-02 22:39:53', '0');
INSERT INTO `usercoupon` VALUES ('9', '3', '10', '2014-08-07 22:35:50', '0');
INSERT INTO `usercoupon` VALUES ('10', '137', '1', '2014-08-17 12:03:39', '0');
INSERT INTO `usercoupon` VALUES ('11', '138', '1', '2014-08-17 12:06:55', '0');
INSERT INTO `usercoupon` VALUES ('12', '139', '1', '2014-08-17 12:09:56', '0');
INSERT INTO `usercoupon` VALUES ('13', '137', '2', '2014-08-17 12:11:09', '0');
INSERT INTO `usercoupon` VALUES ('14', '137', '3', '2014-08-17 12:11:56', '0');
INSERT INTO `usercoupon` VALUES ('15', '137', '10', '2014-08-17 12:12:07', '0');
INSERT INTO `usercoupon` VALUES ('16', '3', '9', '2014-08-17 14:15:09', '0');
INSERT INTO `usercoupon` VALUES ('17', '106', '1', '2014-08-17 14:15:51', '0');
INSERT INTO `usercoupon` VALUES ('18', '106', '2', '2014-08-17 14:15:53', '1');
INSERT INTO `usercoupon` VALUES ('19', '106', '3', '2014-08-17 14:15:54', '0');
INSERT INTO `usercoupon` VALUES ('20', '137', '4', '2014-08-17 16:13:37', '1');
INSERT INTO `usercoupon` VALUES ('21', '0', '0', '2014-08-17 21:11:18', '0');
INSERT INTO `usercoupon` VALUES ('22', '137', '137', '2014-08-17 21:11:31', '0');
INSERT INTO `usercoupon` VALUES ('23', '137', '120', '2014-08-17 21:16:42', '0');
INSERT INTO `usercoupon` VALUES ('24', '137', '8', '2014-08-17 21:16:49', '0');
INSERT INTO `usercoupon` VALUES ('25', '130', '2', '2014-08-24 21:04:53', '0');
INSERT INTO `usercoupon` VALUES ('26', '130', '4', '2014-08-24 21:04:57', '0');
INSERT INTO `usercoupon` VALUES ('27', '0', '1', '2014-08-30 21:53:03', '0');
INSERT INTO `usercoupon` VALUES ('28', '102', '1', '2014-08-31 12:35:32', '0');
INSERT INTO `usercoupon` VALUES ('29', '102', '2', '2014-08-31 12:36:00', '0');
INSERT INTO `usercoupon` VALUES ('30', '102', '10', '2014-08-31 12:59:42', '0');
INSERT INTO `usercoupon` VALUES ('31', '102', '0', '2014-08-31 13:14:18', '0');

-- ----------------------------
-- Table structure for userlevel
-- ----------------------------
DROP TABLE IF EXISTS `userlevel`;
CREATE TABLE `userlevel` (
  `Id` int(11) unsigned NOT NULL auto_increment,
  `Title` varchar(100) NOT NULL default '',
  `Discount` int(11) NOT NULL COMMENT '折扣',
  `NeedMoney` int(11) NOT NULL COMMENT '所需钱',
  `Level` int(11) default NULL,
  `SellerId` int(11) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userlevel
-- ----------------------------

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
  `Phone` varchar(50) default NULL,
  `CreateTime` datetime default NULL,
  `Message` varchar(20) default NULL COMMENT '留言',
  `PayId` int(11) NOT NULL,
  `TimeId` int(11) default NULL,
  `Status` int(11) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userposition
-- ----------------------------
INSERT INTO `userposition` VALUES ('1', '20', '0', null, '142', '1333330000', '2014-08-24 16:21:34', null, '0', null, '0');
INSERT INTO `userposition` VALUES ('2', '20', '0', null, '142', '1333330000', '2014-08-24 16:24:05', null, '0', null, '0');
INSERT INTO `userposition` VALUES ('3', '20', '0', null, '142', '1333330000', '2014-08-24 16:25:56', null, '0', null, '0');
INSERT INTO `userposition` VALUES ('4', '20', '0', null, '142', '1333330000', '2014-08-24 16:26:50', null, '0', null, '0');
INSERT INTO `userposition` VALUES ('5', '0', '0', null, '0', '0', '2014-09-03 22:22:37', null, '0', null, '0');
INSERT INTO `userposition` VALUES ('6', '0', '0', null, '0', '0', '2014-09-03 22:22:48', null, '0', null, '0');
INSERT INTO `userposition` VALUES ('7', '0', '0', null, '0', '0', '2014-09-03 22:22:55', null, '0', null, '0');
INSERT INTO `userposition` VALUES ('8', '0', '0', null, '0', '0', '2014-09-03 22:23:30', null, '0', null, '0');
INSERT INTO `userposition` VALUES ('9', '0', '0', null, '0', '0', '2014-09-03 22:25:57', null, '0', null, '0');
INSERT INTO `userposition` VALUES ('10', '0', '0', null, '0', '0', '2014-09-03 22:31:32', null, '0', null, '0');
INSERT INTO `userposition` VALUES ('11', '0', '0', null, '0', '0', '2014-09-03 22:32:00', null, '0', null, '0');
INSERT INTO `userposition` VALUES ('12', '0', '0', null, '0', '0', '2014-09-03 22:32:04', null, '0', null, '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userwifi
-- ----------------------------
INSERT INTO `userwifi` VALUES ('1', '100', 'a6c651c2306df4999e7920c50500126e', '8', '2014-08-01 15:30:18');
INSERT INTO `userwifi` VALUES ('2', '100', '493322', '0', '2014-09-05 17:42:01');
INSERT INTO `userwifi` VALUES ('3', '100', '553406', '3', '2014-08-19 23:52:16');
INSERT INTO `userwifi` VALUES ('4', '0', '94404554781be4122edebfc0e6fa8c13', '3', '2014-08-01 22:58:58');
INSERT INTO `userwifi` VALUES ('5', '100', '409025', '5', '2014-08-17 10:18:11');

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of verificationcode
-- ----------------------------
INSERT INTO `verificationcode` VALUES ('1', '100', '13559165564', '562477', '2014-08-31 18:26:25', '0');
INSERT INTO `verificationcode` VALUES ('2', '100', '15205065475', '942896', '2014-07-21 20:54:35', '0');
INSERT INTO `verificationcode` VALUES ('3', '100', '18120807353', '227199', '2014-08-03 09:43:17', '0');
INSERT INTO `verificationcode` VALUES ('4', '100', '13959137940', '472352', '2014-07-27 12:46:13', '103');
INSERT INTO `verificationcode` VALUES ('5', '100', '155 6902089', '169831', '2014-07-27 15:43:22', '0');
INSERT INTO `verificationcode` VALUES ('6', '100', '15506902089', '516286', '2014-07-27 15:44:09', '0');
INSERT INTO `verificationcode` VALUES ('7', '100', '15980207996', '827636', '2014-07-27 21:51:21', '0');
INSERT INTO `verificationcode` VALUES ('8', '100', '13600887930', '128759', '2014-09-03 00:17:41', '0');
INSERT INTO `verificationcode` VALUES ('9', '100', '13276036517', '461713', '2014-07-27 22:35:18', '0');
INSERT INTO `verificationcode` VALUES ('10', '100', '18650390820', '226971', '2014-07-28 00:56:14', '105');
INSERT INTO `verificationcode` VALUES ('11', '100', '18650390820', '552546', '2014-07-28 01:04:48', '105');
INSERT INTO `verificationcode` VALUES ('12', '100', '18650390820', '615846', '2014-07-28 21:59:08', '105');
INSERT INTO `verificationcode` VALUES ('13', '100', '18650390820', '276659', '2014-07-28 21:59:33', '105');
INSERT INTO `verificationcode` VALUES ('14', '100', '18650390820', '745565', '2014-07-28 22:00:29', '105');
INSERT INTO `verificationcode` VALUES ('15', '100', '18650390820', '634132', '2014-07-28 22:00:29', '105');
INSERT INTO `verificationcode` VALUES ('16', '100', '18650390820', '495464', '2014-07-28 22:57:17', '105');
INSERT INTO `verificationcode` VALUES ('17', '100', '15205065475', '421489', '2014-07-28 23:35:56', '102');
INSERT INTO `verificationcode` VALUES ('18', '100', '13799800887', '997356', '2014-08-10 14:46:25', '0');
INSERT INTO `verificationcode` VALUES ('19', '100', '18950454890', '249428', '2014-09-02 18:02:51', '0');
INSERT INTO `verificationcode` VALUES ('20', '3', '15159372333', '947214', '2014-08-12 17:38:40', '3');
INSERT INTO `verificationcode` VALUES ('21', '100', '18050283546', '524338', '2014-08-14 22:32:46', '0');
INSERT INTO `verificationcode` VALUES ('22', '142', '13600887930', '655857', '2014-08-24 23:25:45', '0');

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
