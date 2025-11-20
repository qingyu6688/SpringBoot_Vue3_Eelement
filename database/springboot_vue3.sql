/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50711 (5.7.11)
 Source Host           : localhost:3306
 Source Schema         : springboot_vue3

 Target Server Type    : MySQL
 Target Server Version : 50711 (5.7.11)
 File Encoding         : 65001

 Date: 20/11/2025 21:09:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典名称 (如: 性别)',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典类型 (如: sys_user_sex)',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典码 (如: 1)',
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典值 (如: 男)',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, '用户性别', 'sys_user_sex', '1', '男', 1, NULL);
INSERT INTO `sys_dict` VALUES (2, '用户性别', 'sys_user_sex', '2', '女', 2, NULL);
INSERT INTO `sys_dict` VALUES (3, '用户性别', 'sys_user_sex', '0', '未知', 3, NULL);

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件名',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小(kb)',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '下载链接',
  `md5` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件MD5(防重复上传)',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (1, 'b_e7b6cbb08f6f34b3777f024d4f7a54a4.jpg', 'jpg', 99, 'http://localhost:8080/bda3a3d715f0443083a09995fbe30ebd.jpg', 'd4f493c2235ea4868154dbad5fa3d794', 0, 1, '2025-11-20 19:42:14');
INSERT INTO `sys_file` VALUES (2, 'logo.png', 'PNG', 459, 'http://localhost:8080/99585cb46f9a424ea28bd71b3646dc8a.PNG', 'e687c9de50f567096603361c8760dfa7', 0, 1, '2025-11-20 19:59:06');
INSERT INTO `sys_file` VALUES (3, '1panel.txt', 'txt', 0, 'http://localhost:8080/551d468bed784d8ea8d1e54b2d23847c.txt', '96f09dbe9e4055f3c99df2b3311d1e1e', 0, 1, '2025-11-20 20:01:52');
INSERT INTO `sys_file` VALUES (4, 'dbb44aed2e738bd4412592c1ab8b87d6277ff93e.png', 'png', 50, 'http://localhost:8080/dda78289c1294386953142573e6441a3.png', '5f11a3f08bb7bbddbef41f7fcd5f0a19', 0, 1, '2025-11-20 20:18:41');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父菜单ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由名称 (Vue Route Name)',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单标题 (显示名称)',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由路径',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径 (views/...)',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标 (Element Plus Icon)',
  `sort_num` int(11) NULL DEFAULT 0 COMMENT '排序',
  `type` tinyint(1) NULL DEFAULT 1 COMMENT '类型 1:菜单 2:按钮',
  `perm_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识 (user:list)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, NULL, 'Dashboard', '首页', '/dashboard', 'dashboard/index', 'HomeFilled', 1, 1, NULL);
INSERT INTO `sys_menu` VALUES (2, NULL, 'System', '系统管理', '/system', 'Layout', 'Setting', 100, 1, NULL);
INSERT INTO `sys_menu` VALUES (3, NULL, 'Data', '数据管理', '/data', 'Layout', 'DataLine', 200, 1, NULL);
INSERT INTO `sys_menu` VALUES (4, 2, 'User', '用户管理', 'user', 'system/user/index', 'User', 101, 1, 'system:user:list');
INSERT INTO `sys_menu` VALUES (5, 2, 'Role', '角色管理', 'role', 'system/role/index', 'Avatar', 102, 1, 'system:role:list');
INSERT INTO `sys_menu` VALUES (6, 2, 'Menu', '菜单管理', 'menu', 'system/menu/index', 'Menu', 103, 1, 'system:menu:list');
INSERT INTO `sys_menu` VALUES (7, 4, NULL, '用户新增', NULL, NULL, NULL, 1, 2, 'system:user:add');
INSERT INTO `sys_menu` VALUES (8, 4, NULL, '用户修改', NULL, NULL, NULL, 2, 2, 'system:user:edit');
INSERT INTO `sys_menu` VALUES (9, 4, NULL, '用户删除', NULL, NULL, NULL, 3, 2, 'system:user:delete');
INSERT INTO `sys_menu` VALUES (10, 3, 'File', '文件管理', 'file', 'data/file/index', 'Folder', 201, 1, 'data:file:list');
INSERT INTO `sys_menu` VALUES (11, 3, 'Dict', '字典管理', 'dict', 'data/dict/index', 'Collection', 202, 1, 'data:dict:list');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色唯一编码 (ROLE_ADMIN)',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'ROLE_ADMIN', '拥有所有权限');
INSERT INTO `sys_role` VALUES (2, '普通用户', 'ROLE_USER', '仅拥有基本查看权限');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1);
INSERT INTO `sys_role_menu` VALUES (1, 2);
INSERT INTO `sys_role_menu` VALUES (1, 3);
INSERT INTO `sys_role_menu` VALUES (1, 4);
INSERT INTO `sys_role_menu` VALUES (1, 5);
INSERT INTO `sys_role_menu` VALUES (1, 6);
INSERT INTO `sys_role_menu` VALUES (1, 7);
INSERT INTO `sys_role_menu` VALUES (1, 8);
INSERT INTO `sys_role_menu` VALUES (1, 9);
INSERT INTO `sys_role_menu` VALUES (1, 10);
INSERT INTO `sys_role_menu` VALUES (1, 11);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID (关联 sys_role)',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态 1:启用 0:禁用',
  `last_login_time` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '最后登录IP地址',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username`) USING BTREE,
  INDEX `idx_role_id`(`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$1taPYWP0GrOcBLrQqHWvY.ldsgx3U.QqU.OZWqJvkSJ9vhWKLNS06', '超级管理员', 1, 'maorongkang@gmail.com', '17666540336', 'http://localhost:8080/bda3a3d715f0443083a09995fbe30ebd.jpg', '2025-11-20 16:00:35', 1, '2025-11-20 21:08:06', '127.0.0.1');
INSERT INTO `sys_user` VALUES (2, 'test', '$2a$10$KkTkTGf.qxiL1iHSwXK2SuZU.spBVHozVJ4lBXKnkGbdQg1rnO4rO', '普通用户', 2, NULL, NULL, NULL, '2025-11-20 16:00:35', 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (3, 'mrk', '$2a$10$sOVZsfPs6C32SJW/bT73Ne5fsw1.4ONsaPLgE6/jqEuX086ImRdz.', 'mrk', 2, '2661462026@qq.com', '17654321867', 'http://localhost:8080/bda3a3d715f0443083a09995fbe30ebd.jpg', '2025-11-20 17:27:15', 1, '2025-11-20 20:37:00', '127.0.0.1');
INSERT INTO `sys_user` VALUES (4, 'wzj', '$2a$10$nbaUytzzeSbXTb/Nyil7VeCvXJqWqtMsbdmA2kCd0cGvH69BosUwS', 'wzj', 2, 'wzj@qq.com', '', NULL, '2025-11-20 18:03:37', 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (5, 'mxx', '', 'mxx', 2, 'mxx@qq.com', NULL, 'http://localhost:8080/bda3a3d715f0443083a09995fbe30ebd.jpg', '2025-11-20 18:55:45', 1, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
