--首页表名更改
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `bcm_menu`
-- ----------------------------
DROP TABLE IF EXISTS `bcm_menu`;
CREATE TABLE `index_menu` (
  `id` varchar(64) NOT NULL COMMENT '自定义菜单id',
  `menu_id` varchar(200) NOT NULL COMMENT '菜单id(关联菜单)',
  `menu_show` varchar(2) DEFAULT NULL COMMENT '默认显示',
  `menu_show_type` varchar(2) DEFAULT NULL COMMENT '是否显示',
  `menu_expand_type` varchar(2) DEFAULT NULL COMMENT '是否放大',
  `menu_reload_type` varchar(2) DEFAULT NULL COMMENT '是否刷新',
  `menu_hide_type` varchar(2) DEFAULT NULL COMMENT '是否收缩',
  `menu_close_type` varchar(2) DEFAULT NULL COMMENT '是否关闭',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='首页自定义';

-- ----------------------------
-- Records of bcm_menu
-- ----------------------------
INSERT INTO `index_menu` VALUES ('0640ad7e9e4d4bbeab91bc1ebb0a5f15', '95778b8b90ec45f984743a6bbeb02336', '1', null, '1', '1', '1', '1', '1', '2015-03-30 17:13:11', '1', '2015-03-30 17:13:11', '');
INSERT INTO `index_menu` VALUES ('436994d1e69245babdcee93bae50fc66', '3662f60683e444b28a2fbe7967f3cc47', '1', null, '1', '1', '1', '1', '1', '2015-03-30 17:10:52', '1', '2015-03-30 17:10:52', '');
INSERT INTO `index_menu` VALUES ('b0daca7b56b148799b82ef78a7b662e2', '95778b8b90ec45f984743a6bbeb02336', '1', null, '1', '1', '1', '1', '1', '2015-03-31 17:41:29', '1', '2015-03-31 17:41:29', '');


--首页自定义表名更改
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `bcm_menu_user`
-- ----------------------------
DROP TABLE IF EXISTS `bcm_menu_user`;
CREATE TABLE `index_menu_user` (
  `menu_id` varchar(64) NOT NULL COMMENT '自定义菜单id',
  `user_id` varchar(64) NOT NULL COMMENT '用户编号id',
  `menu_show` varchar(2) DEFAULT NULL COMMENT '默认显示',
  `menu_show_type` varchar(2) DEFAULT NULL COMMENT '是否显示',
  `menu_expand_type` varchar(2) DEFAULT NULL COMMENT '是否放大',
  `menu_reload_type` varchar(2) DEFAULT NULL COMMENT '是否刷新',
  `menu_hide_type` varchar(2) DEFAULT NULL COMMENT '是否收缩',
  `menu_close_type` varchar(2) DEFAULT NULL COMMENT '是否关闭',
  `column_type` int(2) DEFAULT NULL COMMENT '类别',
  `row_typw` int(5) DEFAULT NULL COMMENT '行别',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户首页自定义';

-- ----------------------------
-- Records of bcm_menu_user
-- ----------------------------
INSERT INTO `index_menu_user` VALUES ('3662f60683e444b28a2fbe7967f3cc47', '1', null, null, null, null, null, null, '1', '1', '1', '2015-04-01 13:32:50', '1', '2015-04-01 13:32:50', null);
INSERT INTO `index_menu_user` VALUES ('95778b8b90ec45f984743a6bbeb02336', '1', null, null, null, null, null, null, '2', '1', '1', '2015-04-01 13:32:51', '1', '2015-04-01 13:32:51', null);