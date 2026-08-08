-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: 
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!50606 SET @OLD_INNODB_STATS_AUTO_RECALC=@@INNODB_STATS_AUTO_RECALC */;
/*!50606 SET GLOBAL INNODB_STATS_AUTO_RECALC=OFF */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `jzo2o-customer`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jzo2o-customer` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `jzo2o-customer`;

--
-- Table structure for table `address_book`
--

DROP TABLE IF EXISTS `address_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address_book` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '电话',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '省份',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '市级',
  `county` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '区/县',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '详细地址',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `is_default` int NOT NULL DEFAULT '0' COMMENT '是否为默认地址，0：否，1：是',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否已删除，0：未删除，1：已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='地址薄';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agency_certification`
--

DROP TABLE IF EXISTS `agency_certification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agency_certification` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '机构id',
  `name` varchar(50) DEFAULT NULL COMMENT '企业名称',
  `id_number` varchar(50) DEFAULT NULL COMMENT '统一社会信用代码',
  `legal_person_name` varchar(50) DEFAULT NULL COMMENT '法人姓名',
  `legal_person_id_card_no` varchar(50) DEFAULT NULL COMMENT '法人身份证号',
  `business_license` varchar(100) DEFAULT NULL COMMENT '营业执照',
  `certification_status` int NOT NULL DEFAULT '0' COMMENT '认证状态，0：初始态，1：认证中，2：认证成功，3认证失败',
  `certification_time` datetime DEFAULT NULL COMMENT '认证时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1716434046437146627 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='机构认证信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agency_certification_audit`
--

DROP TABLE IF EXISTS `agency_certification_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agency_certification_audit` (
  `id` bigint NOT NULL COMMENT '主键',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '机构id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '企业名称',
  `id_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '统一社会信用代码',
  `legal_person_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '法人姓名',
  `legal_person_id_card_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '法人身份证号',
  `business_license` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '营业执照',
  `audit_status` int NOT NULL DEFAULT '0' COMMENT '审核状态，0：未审核，1：已审核',
  `auditor_id` bigint DEFAULT NULL COMMENT '审核人id',
  `auditor_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '审核人姓名',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `certification_status` int NOT NULL DEFAULT '1' COMMENT '认证状态，1：认证中，2：认证成功，3：认证失败',
  `reject_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '驳回原因',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='机构认证审核表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bank_account`
--

DROP TABLE IF EXISTS `bank_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_account` (
  `id` bigint DEFAULT NULL COMMENT '服务人员/机构id',
  `type` int DEFAULT NULL COMMENT '类型，2：服务人员，3：服务机构',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '户名',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '银行名称',
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `district` varchar(50) DEFAULT NULL COMMENT '区',
  `branch` varchar(50) DEFAULT NULL COMMENT '网点',
  `account` varchar(50) DEFAULT NULL COMMENT '银行账号',
  `account_certification` varchar(100) DEFAULT NULL COMMENT '开户证明',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='银行账户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `common_user`
--

DROP TABLE IF EXISTS `common_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `common_user` (
  `id` bigint NOT NULL COMMENT '用户id',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态，0：正常，1：冻结',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '昵称',
  `phone` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '电话',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像',
  `open_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `account_lock_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '账号冻结原因',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fail_msg`
--

DROP TABLE IF EXISTS `fail_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fail_msg` (
  `id` bigint NOT NULL COMMENT '消息id',
  `exchange` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '交换机',
  `routing_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '路由key',
  `msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '消息',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '原因',
  `delay_msg_execute_time` int NOT NULL COMMENT '延迟消息执行时间',
  `next_fetch_time` int DEFAULT NULL COMMENT '下次拉取时间',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='rabbitm发送失败消息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `institution_staff`
--

DROP TABLE IF EXISTS `institution_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institution_staff` (
  `id` bigint NOT NULL COMMENT '主键',
  `institution_id` bigint DEFAULT NULL COMMENT '服务机构id',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '名称',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '电话',
  `id_card_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份证号',
  `certification_imgs` json DEFAULT NULL COMMENT '证明资料列表',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否已删除，0：未删除，1：已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='机构下属服务人员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_provider`
--

DROP TABLE IF EXISTS `serve_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_provider` (
  `id` bigint NOT NULL COMMENT '主键',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '编号',
  `type` int NOT NULL COMMENT '类型，2：服务人员，3：服务机构',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) NOT NULL COMMENT '电话',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像',
  `status` int NOT NULL COMMENT '状态，0：正常，1：冻结',
  `settings_status` int DEFAULT '0' COMMENT '首次设置状态，0：未完成设置，1：已完成设置',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构登录密码',
  `account_lock_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '账号冻结原因',
  `score` double DEFAULT NULL COMMENT '综合评分',
  `good_level_rate` varchar(50) DEFAULT NULL COMMENT '好评率',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否已删除，0：未删除，1：已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `serve_provider_phone_type_uindex` (`phone`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务人员/机构表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_provider_settings`
--

DROP TABLE IF EXISTS `serve_provider_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_provider_settings` (
  `id` bigint NOT NULL COMMENT '服务人员/机构id',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '城市码',
  `city_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市名称',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `intention_scope` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '意向单范围',
  `have_skill` int DEFAULT '0' COMMENT '是否有技能',
  `can_pick_up` int DEFAULT '-1' COMMENT '是否可以接单，-0：关闭接单，1：开启接单',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` int DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务人员/机构附属信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_provider_sync`
--

DROP TABLE IF EXISTS `serve_provider_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_provider_sync` (
  `id` bigint NOT NULL COMMENT '服务人员或机构同步表',
  `serve_item_ids` json DEFAULT NULL COMMENT '技能列表',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务人员，3：机构人员',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市编码',
  `pick_up` int DEFAULT NULL COMMENT '接单开关1，：接单开启，0：接单关闭',
  `evaluation_score` double DEFAULT '50' COMMENT '评分,默认50分',
  `setting_status` int DEFAULT NULL COMMENT '首次设置状态，0：未完成，1：已完成设置',
  `status` int NOT NULL COMMENT '状态，0：正常，1：冻结',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务提供者同步表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_skill`
--

DROP TABLE IF EXISTS `serve_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_skill` (
  `id` bigint NOT NULL COMMENT '主键',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人员/机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '类型，2：服务人员，3：服务机构',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) DEFAULT NULL COMMENT '服务项名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` int NOT NULL DEFAULT '0' COMMENT '是否已删除，0：未删除，1：已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务技能表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `worker_certification`
--

DROP TABLE IF EXISTS `worker_certification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `worker_certification` (
  `id` bigint NOT NULL DEFAULT '0' COMMENT '服务人员id',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `id_card_no` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `front_img` varchar(100) DEFAULT NULL COMMENT '身份证正面',
  `back_img` varchar(100) DEFAULT NULL COMMENT '身份证反面',
  `certification_material` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '证明资料',
  `certification_status` int NOT NULL DEFAULT '0' COMMENT '认证状态，0：初始态，1：认证中，2：认证成功，3认证失败',
  `certification_time` datetime DEFAULT NULL COMMENT '认证时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务人员认证信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `worker_certification_audit`
--

DROP TABLE IF EXISTS `worker_certification_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `worker_certification_audit` (
  `id` bigint NOT NULL COMMENT '主键',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人员id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '姓名',
  `id_card_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '身份证号',
  `front_img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '身份证正面',
  `back_img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '身份证反面',
  `certification_material` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '证明资料',
  `audit_status` int DEFAULT '0' COMMENT '审核状态，0：未审核，1：已审核',
  `auditor_id` bigint DEFAULT NULL COMMENT '审核人id',
  `auditor_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '审核人姓名',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `certification_status` int DEFAULT '1' COMMENT '认证状态，1：认证中，2：认证成功，3认证失败',
  `reject_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '驳回原因',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务人员认证审核表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jzo2o-customer'
--

--
-- Dumping routines for database 'jzo2o-customer'
--

--
-- Current Database: `jzo2o-customer-backup`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jzo2o-customer-backup` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `jzo2o-customer-backup`;

--
-- Table structure for table `address_book`
--

DROP TABLE IF EXISTS `address_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address_book` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '电话',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '省份',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '市级',
  `county` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '区/县',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '详细地址',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `is_default` int NOT NULL DEFAULT '0' COMMENT '是否为默认地址，0：否，1：是',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否已删除，0：未删除，1：已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='地址薄';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agency_certification`
--

DROP TABLE IF EXISTS `agency_certification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agency_certification` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '机构id',
  `name` varchar(50) DEFAULT NULL COMMENT '企业名称',
  `id_number` varchar(50) DEFAULT NULL COMMENT '统一社会信用代码',
  `legal_person_name` varchar(50) DEFAULT NULL COMMENT '法人姓名',
  `legal_person_id_card_no` varchar(50) DEFAULT NULL COMMENT '法人身份证号',
  `business_license` varchar(100) DEFAULT NULL COMMENT '营业执照',
  `certification_status` int NOT NULL DEFAULT '0' COMMENT '认证状态，0：初始态，1：认证中，2：认证成功，3认证失败',
  `certification_time` datetime DEFAULT NULL COMMENT '认证时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1716434046437146627 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='机构认证信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agency_certification_audit`
--

DROP TABLE IF EXISTS `agency_certification_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agency_certification_audit` (
  `id` bigint NOT NULL COMMENT '主键',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '机构id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '企业名称',
  `id_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '统一社会信用代码',
  `legal_person_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '法人姓名',
  `legal_person_id_card_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '法人身份证号',
  `business_license` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '营业执照',
  `audit_status` int NOT NULL DEFAULT '0' COMMENT '审核状态，0：未审核，1：已审核',
  `auditor_id` bigint DEFAULT NULL COMMENT '审核人id',
  `auditor_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '审核人姓名',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `certification_status` int NOT NULL DEFAULT '1' COMMENT '认证状态，1：认证中，2：认证成功，3：认证失败',
  `reject_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '驳回原因',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='机构认证审核表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bank_account`
--

DROP TABLE IF EXISTS `bank_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_account` (
  `id` bigint DEFAULT NULL COMMENT '服务人员/机构id',
  `type` int DEFAULT NULL COMMENT '类型，2：服务人员，3：服务机构',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '户名',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '银行名称',
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `district` varchar(50) DEFAULT NULL COMMENT '区',
  `branch` varchar(50) DEFAULT NULL COMMENT '网点',
  `account` varchar(50) DEFAULT NULL COMMENT '银行账号',
  `account_certification` varchar(100) DEFAULT NULL COMMENT '开户证明',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='银行账户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `common_user`
--

DROP TABLE IF EXISTS `common_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `common_user` (
  `id` bigint NOT NULL COMMENT '用户id',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态，0：正常，1：冻结',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '昵称',
  `phone` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '电话',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像',
  `open_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `account_lock_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '账号冻结原因',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fail_msg`
--

DROP TABLE IF EXISTS `fail_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fail_msg` (
  `id` bigint NOT NULL COMMENT '消息id',
  `exchange` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '交换机',
  `routing_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '路由key',
  `msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '消息',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '原因',
  `delay_msg_execute_time` int NOT NULL COMMENT '延迟消息执行时间',
  `next_fetch_time` int DEFAULT NULL COMMENT '下次拉取时间',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='rabbitm发送失败消息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `institution_staff`
--

DROP TABLE IF EXISTS `institution_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institution_staff` (
  `id` bigint NOT NULL COMMENT '主键',
  `institution_id` bigint DEFAULT NULL COMMENT '服务机构id',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '名称',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '电话',
  `id_card_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份证号',
  `certification_imgs` json DEFAULT NULL COMMENT '证明资料列表',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否已删除，0：未删除，1：已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='机构下属服务人员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_provider`
--

DROP TABLE IF EXISTS `serve_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_provider` (
  `id` bigint NOT NULL COMMENT '主键',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '编号',
  `type` int NOT NULL COMMENT '类型，2：服务人员，3：服务机构',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) NOT NULL COMMENT '电话',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像',
  `status` int NOT NULL COMMENT '状态，0：正常，1：冻结',
  `settings_status` int DEFAULT '0' COMMENT '首次设置状态，0：未完成设置，1：已完成设置',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构登录密码',
  `account_lock_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '账号冻结原因',
  `score` double DEFAULT NULL COMMENT '综合评分',
  `good_level_rate` varchar(50) DEFAULT NULL COMMENT '好评率',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否已删除，0：未删除，1：已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `serve_provider_phone_type_uindex` (`phone`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务人员/机构表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_provider_settings`
--

DROP TABLE IF EXISTS `serve_provider_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_provider_settings` (
  `id` bigint NOT NULL COMMENT '服务人员/机构id',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '城市码',
  `city_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市名称',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `intention_scope` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '意向单范围',
  `have_skill` int DEFAULT '0' COMMENT '是否有技能',
  `can_pick_up` int DEFAULT '-1' COMMENT '是否可以接单，-0：关闭接单，1：开启接单',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` int DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务人员/机构附属信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_provider_sync`
--

DROP TABLE IF EXISTS `serve_provider_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_provider_sync` (
  `id` bigint NOT NULL COMMENT '服务人员或机构同步表',
  `serve_item_ids` json DEFAULT NULL COMMENT '技能列表',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务人员，3：机构人员',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市编码',
  `pick_up` int DEFAULT NULL COMMENT '接单开关1，：接单开启，0：接单关闭',
  `evaluation_score` double DEFAULT '50' COMMENT '评分,默认50分',
  `setting_status` int DEFAULT NULL COMMENT '首次设置状态，0：未完成，1：已完成设置',
  `status` int NOT NULL COMMENT '状态，0：正常，1：冻结',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='评分同步列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_skill`
--

DROP TABLE IF EXISTS `serve_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_skill` (
  `id` bigint NOT NULL COMMENT '主键',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人员/机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '类型，2：服务人员，3：服务机构',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) DEFAULT NULL COMMENT '服务项名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` int NOT NULL DEFAULT '0' COMMENT '是否已删除，0：未删除，1：已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务技能表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `worker_certification`
--

DROP TABLE IF EXISTS `worker_certification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `worker_certification` (
  `id` bigint NOT NULL DEFAULT '0' COMMENT '服务人员id',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `id_card_no` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `front_img` varchar(100) DEFAULT NULL COMMENT '身份证正面',
  `back_img` varchar(100) DEFAULT NULL COMMENT '身份证反面',
  `certification_material` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '证明资料',
  `certification_status` int NOT NULL DEFAULT '0' COMMENT '认证状态，0：初始态，1：认证中，2：认证成功，3认证失败',
  `certification_time` datetime DEFAULT NULL COMMENT '认证时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务人员认证信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `worker_certification_audit`
--

DROP TABLE IF EXISTS `worker_certification_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `worker_certification_audit` (
  `id` bigint NOT NULL COMMENT '主键',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人员id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '姓名',
  `id_card_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '身份证号',
  `front_img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '身份证正面',
  `back_img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '身份证反面',
  `certification_material` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '证明资料',
  `audit_status` int DEFAULT '0' COMMENT '审核状态，0：未审核，1：已审核',
  `auditor_id` bigint DEFAULT NULL COMMENT '审核人id',
  `auditor_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '审核人姓名',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `certification_status` int DEFAULT '1' COMMENT '认证状态，1：认证中，2：认证成功，3认证失败',
  `reject_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '驳回原因',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务人员认证审核表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jzo2o-customer-backup'
--

--
-- Dumping routines for database 'jzo2o-customer-backup'
--

--
-- Current Database: `jzo2o-foundations`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jzo2o-foundations` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `jzo2o-foundations`;

--
-- Table structure for table `city_directory`
--

DROP TABLE IF EXISTS `city_directory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city_directory` (
  `parent_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '上级归属',
  `type` int DEFAULT NULL COMMENT '类型，1：省，2：市',
  `city_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市名称',
  `city_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市编码',
  `sort_num` int DEFAULT NULL COMMENT '排序字段',
  `pinyin_initial` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市名称拼音首字母',
  `id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='城市编码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config_region`
--

DROP TABLE IF EXISTS `config_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_region` (
  `id` bigint NOT NULL COMMENT '区域id',
  `city_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '城市编码',
  `staff_receive_order_max` int DEFAULT '10' COMMENT '（个体）接单量限制',
  `institution_receive_order_max` int DEFAULT '100' COMMENT '（企业）接单量限制值',
  `staff_serve_radius` int DEFAULT '50' COMMENT '（个体）服务范围半径',
  `institution_serve_radius` int DEFAULT '200' COMMENT '（企业）服务范围半径',
  `diversion_interval` int DEFAULT NULL COMMENT '分流间隔（单位分钟），即下单时间与服务预计开始时间的间隔',
  `seize_timeout_interval` int DEFAULT NULL COMMENT '抢单超时时间间隔（单位分钟），从支付成功进入抢单后超过当前时间抢单派单同步进行',
  `dispatch_strategy` int DEFAULT NULL COMMENT '派单策略，1：距离优先策略，2：评分优先策略，3：接单量优先策略',
  `dispatch_per_round_interval` int DEFAULT NULL COMMENT '派单每轮时间间隔',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='区域业务配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operator`
--

DROP TABLE IF EXISTS `operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operator` (
  `id` bigint DEFAULT NULL,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` bigint DEFAULT NULL,
  `update_by` bigint DEFAULT NULL,
  `is_deleted` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `region` (
  `id` bigint NOT NULL COMMENT '区域id',
  `city_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '区域名称',
  `manager_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '负责人名称',
  `manager_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '负责人电话',
  `active_status` int NOT NULL DEFAULT '0' COMMENT '是否启用，0草稿,1禁用，2启用',
  `sort_num` int NOT NULL DEFAULT '0' COMMENT '排序字段',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `城市编码唯一` (`city_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='区域表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve`
--

DROP TABLE IF EXISTS `serve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve` (
  `id` bigint NOT NULL COMMENT '服务id',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `region_id` bigint NOT NULL COMMENT '区域id',
  `city_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `sale_status` int NOT NULL DEFAULT '0' COMMENT '售卖状态，0：草稿，1下架，2上架',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `is_hot` int NOT NULL DEFAULT '0' COMMENT '是否为热门，0非热门，1热门',
  `hot_time_stamp` bigint DEFAULT NULL COMMENT '更新为热门的时间戳',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `区域id` (`region_id`) USING BTREE,
  KEY `服务id` (`serve_item_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_item`
--

DROP TABLE IF EXISTS `serve_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_item` (
  `id` bigint NOT NULL COMMENT '服务项id',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务类型id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务名称',
  `serve_item_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务图标',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务图片',
  `unit` int NOT NULL COMMENT '服务数量单位',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务描述',
  `detail_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详图',
  `reference_price` decimal(10,2) NOT NULL COMMENT '参考价格',
  `sort_num` int DEFAULT NULL COMMENT '排序字段',
  `active_status` int NOT NULL DEFAULT '0' COMMENT '活动状态，0：草稿，1禁用，2启用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `名称唯一` (`name`),
  KEY `类型id` (`serve_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务项表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_sync`
--

DROP TABLE IF EXISTS `serve_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_sync` (
  `id` bigint NOT NULL COMMENT '服务id',
  `serve_item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项名称',
  `serve_type_id` bigint NOT NULL COMMENT '服务类型id',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市编码',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `is_hot` int DEFAULT NULL COMMENT '是否为热门，0非热门，1热门',
  `hot_time_stamp` bigint DEFAULT NULL COMMENT '更新为热门的时间戳',
  `serve_item_sort_num` int DEFAULT NULL COMMENT '服务项排序字段',
  `serve_type_sort_num` int DEFAULT NULL COMMENT '服务类型排序字段',
  `serve_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_type_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型图片',
  `serve_type_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型icon',
  `unit` int DEFAULT NULL COMMENT '服务数量单位',
  `detail_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项详情图片',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `serve_item_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务同步表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_type`
--

DROP TABLE IF EXISTS `serve_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_type` (
  `id` bigint NOT NULL COMMENT '服务类型id',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务类型编码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务类型名称',
  `serve_type_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务类型图标',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务类型图片',
  `sort_num` int DEFAULT NULL COMMENT '排序字段',
  `active_status` int NOT NULL DEFAULT '0' COMMENT '是否启用，0草稿,1禁用，2启用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `名称唯一` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jzo2o-foundations'
--

--
-- Dumping routines for database 'jzo2o-foundations'
--

--
-- Current Database: `jzo2o-health`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jzo2o-health` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `jzo2o-health`;

--
-- Table structure for table `checkgroup`
--

DROP TABLE IF EXISTS `checkgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checkgroup` (
  `id` bigint NOT NULL DEFAULT '0' COMMENT '主键',
  `code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '检查组编码',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '检查组名称',
  `help_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '检查组助记码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '性别，0：不限，1：男，2：女',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '检查组说明',
  `attention` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '检查组注意事项',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='检查组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checkgroup_checkitem`
--

DROP TABLE IF EXISTS `checkgroup_checkitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checkgroup_checkitem` (
  `checkgroup_id` bigint NOT NULL DEFAULT '0' COMMENT '检查组id',
  `checkitem_id` bigint NOT NULL DEFAULT '0' COMMENT '检查项id',
  PRIMARY KEY (`checkgroup_id`,`checkitem_id`) USING BTREE,
  KEY `item_id` (`checkitem_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='检查组与检查项关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checkitem`
--

DROP TABLE IF EXISTS `checkitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checkitem` (
  `id` bigint NOT NULL DEFAULT '0' COMMENT '主键',
  `code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '检查项编码',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '检查项名称',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '性别，0：不限，1：男，2：女',
  `age` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '检查项适用年龄',
  `price` float(10,2) DEFAULT NULL COMMENT '检查项单价',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '查检项类型,分为检查和检验两种',
  `attention` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '检查项注意事项',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '检查项说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='检查项表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` bigint NOT NULL COMMENT '主键',
  `nickname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '昵称',
  `phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '头像',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` int NOT NULL DEFAULT '0' COMMENT '是否已删除，0：未删除，1：已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='普通用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL COMMENT '订单id',
  `order_status` int NOT NULL COMMENT '订单状态，0：未支付，100：待体检，200：已体检，300：已关闭，400：已取消',
  `pay_status` int NOT NULL COMMENT '支付状态，0：未支付，1：已支付，2：退款中，3：退款成功，4：退款失败',
  `setmeal_id` bigint NOT NULL DEFAULT '0' COMMENT '套餐id',
  `setmeal_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐名称',
  `setmeal_sex` int NOT NULL COMMENT '套餐适用性别，0：不限，1：男，2：女',
  `setmeal_age` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐适用年龄',
  `setmeal_img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐图片',
  `setmeal_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐说明',
  `setmeal_price` decimal(10,2) NOT NULL COMMENT '套餐价格',
  `reservation_date` date NOT NULL COMMENT '预约日期，格式：yyyy-MM',
  `checkup_person_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '体检人姓名',
  `checkup_person_sex` int NOT NULL COMMENT '体检人性别，0：不限，1：男，2女',
  `checkup_person_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '体检人电话',
  `checkup_person_idcard` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '体检人身份证号',
  `member_id` bigint NOT NULL COMMENT '用户id',
  `member_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户电话',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `trading_channel` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '支付渠道',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第三方支付的退款单号',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（取创建时间的时间戳）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order_status_member_id_sort_by` (`order_status`,`member_id`,`sort_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_cancelled`
--

DROP TABLE IF EXISTS `orders_cancelled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_cancelled` (
  `id` bigint NOT NULL COMMENT '订单id',
  `canceller_id` bigint DEFAULT NULL COMMENT '取消人',
  `canceller_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消人名称',
  `canceller_type` int DEFAULT NULL COMMENT '取消人类型，1：普通用户，4管理员',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单取消表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_refund`
--

DROP TABLE IF EXISTS `orders_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_refund` (
  `id` bigint NOT NULL COMMENT '订单id',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `real_pay_amount` decimal(10,2) DEFAULT NULL COMMENT '实付金额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单退款表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_setting`
--

DROP TABLE IF EXISTS `reservation_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_setting` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_date` date NOT NULL COMMENT '预约日期',
  `number` int NOT NULL COMMENT '可预约人数',
  `reservations` int NOT NULL DEFAULT '0' COMMENT '已预约人数',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `order_date` (`order_date`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='预约设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `setmeal`
--

DROP TABLE IF EXISTS `setmeal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setmeal` (
  `id` bigint NOT NULL DEFAULT '0' COMMENT '套餐id',
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '套餐名称',
  `code` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '套餐编码',
  `help_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '套餐助记码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '性别，0：不限，1：男，2：女',
  `age` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '套餐适用年龄',
  `price` float(10,2) DEFAULT NULL COMMENT '套餐价格',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '套餐说明',
  `attention` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '套餐注意事项',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '套餐图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='套餐表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `setmeal_checkgroup`
--

DROP TABLE IF EXISTS `setmeal_checkgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setmeal_checkgroup` (
  `setmeal_id` bigint NOT NULL DEFAULT '0' COMMENT '套餐id',
  `checkgroup_id` bigint NOT NULL DEFAULT '0' COMMENT '检查组id',
  PRIMARY KEY (`setmeal_id`,`checkgroup_id`) USING BTREE,
  KEY `checkgroup_key` (`checkgroup_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='套餐与检查组关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL COMMENT '主键',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '管理员姓名',
  `phone` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '手机号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '账户状态：0-禁用 1-正常',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建者id',
  `update_by` bigint DEFAULT '0' COMMENT '更新者id',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除，默认0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='管理员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jzo2o-health'
--

--
-- Dumping routines for database 'jzo2o-health'
--

--
-- Current Database: `jzo2o-market`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jzo2o-market` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `jzo2o-market`;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity` (
  `id` bigint NOT NULL COMMENT '活动id',
  `name` varchar(100) NOT NULL DEFAULT '0' COMMENT '活动名称',
  `type` int NOT NULL COMMENT '优惠券类型，1：满减，2：折扣',
  `amount_condition` decimal(10,2) NOT NULL COMMENT '使用条件，0：表示无门槛，其他值：最低消费金额',
  `discount_rate` int NOT NULL DEFAULT '0' COMMENT '折扣率，折扣类型的折扣率，8折就是存80',
  `discount_amount` decimal(10,2) DEFAULT NULL COMMENT '优惠金额，满减或无门槛的优惠金额',
  `validity_days` int NOT NULL DEFAULT '0' COMMENT '优惠券有效期天数，0：表示有效期是指定有效期的',
  `distribute_start_time` datetime NOT NULL COMMENT '发放开始时间',
  `distribute_end_time` datetime NOT NULL COMMENT '发放结束时间',
  `status` int NOT NULL COMMENT '活动状态，1：待生效，2：进行中，3：已失效 4：作废',
  `total_num` int NOT NULL DEFAULT '0' COMMENT '发放数量，0：表示无限量，其他正数表示最大发放量',
  `stock_num` int NOT NULL DEFAULT '0' COMMENT '库存',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coupon`
--

DROP TABLE IF EXISTS `coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon` (
  `id` bigint NOT NULL COMMENT '优惠券id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '优惠券名称',
  `user_id` bigint NOT NULL COMMENT '优惠券的拥有者',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户姓名',
  `user_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户手机号',
  `activity_id` bigint NOT NULL COMMENT '活动id',
  `type` int NOT NULL COMMENT '使用类型，1：满减，2：折扣',
  `discount_rate` int DEFAULT '0' COMMENT '折扣',
  `discount_amount` decimal(10,2) DEFAULT NULL COMMENT '优惠金额',
  `amount_condition` decimal(10,2) NOT NULL COMMENT '满减金额',
  `validity_time` datetime DEFAULT NULL COMMENT '有效期',
  `use_time` datetime DEFAULT NULL COMMENT '使用时间',
  `status` tinyint NOT NULL COMMENT '优惠券状态，1:未使用，2:已使用，3:已过期',
  `orders_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '订单id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_my_query_index` (`user_id`,`status`) USING BTREE COMMENT '用户查询我的优惠券快捷索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coupon_use_back`
--

DROP TABLE IF EXISTS `coupon_use_back`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_use_back` (
  `id` bigint NOT NULL COMMENT '回退记录id',
  `coupon_id` bigint NOT NULL COMMENT '优惠券id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `use_back_time` datetime NOT NULL COMMENT '回退时间',
  `write_off_time` datetime DEFAULT NULL COMMENT '核销时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='优惠券使用回退记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coupon_write_off`
--

DROP TABLE IF EXISTS `coupon_write_off`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_write_off` (
  `id` bigint NOT NULL,
  `coupon_id` bigint NOT NULL COMMENT '优惠券id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `orders_id` bigint NOT NULL COMMENT '核销时使用的订单号',
  `activity_id` bigint NOT NULL COMMENT '活动id',
  `write_off_time` datetime NOT NULL COMMENT '核销时间',
  `write_off_man_phone` varchar(20) DEFAULT NULL COMMENT '核销人手机号',
  `write_off_man_name` varchar(50) DEFAULT NULL COMMENT '核销人姓名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='优惠券核销表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `branch_id` bigint NOT NULL,
  `xid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `context` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  `ext` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jzo2o-market'
--

--
-- Dumping routines for database 'jzo2o-market'
--

--
-- Current Database: `jzo2o-orders`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jzo2o-orders` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `jzo2o-orders`;

--
-- Table structure for table `biz_snapshot`
--

DROP TABLE IF EXISTS `biz_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1731974598947311617 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `breach_record`
--

DROP TABLE IF EXISTS `breach_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `breach_record` (
  `id` bigint NOT NULL COMMENT '违约id',
  `serve_provider_id` bigint NOT NULL COMMENT '违约机构或师傅',
  `serve_provider_type` int NOT NULL COMMENT '类型，2：师傅、3：机构',
  `behavior_type` int NOT NULL COMMENT '行为类型，1：待分配时取消，2：待服务时取消，3：服务中取消，4：派单拒绝，5：派单超时',
  `breach_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '违约原因',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项名称',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `orders_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务编码',
  `served_user_id` bigint NOT NULL COMMENT '被服务人',
  `served_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '被服务人员手机号，脱敏',
  `breach_time` datetime NOT NULL COMMENT '违约时间',
  `breach_day` int NOT NULL COMMENT '违约日，格式例如20200512,2020年5月12日',
  `orders_id` bigint NOT NULL COMMENT '违约单订单id',
  `orders_serve_id` bigint DEFAULT NULL COMMENT '服务单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='违约记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_orders_serve_sync`
--

DROP TABLE IF EXISTS `history_orders_serve_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders_serve_sync` (
  `id` bigint NOT NULL COMMENT '服务单id，和',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `institution_staff_name` varchar(50) DEFAULT NULL COMMENT '机构服务人员名称',
  `institution_name` varchar(100) DEFAULT NULL COMMENT '机构名称',
  `orders_origin_type` int DEFAULT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `contacts_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户姓名',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户电话',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务地址',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务分裂名称',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务图片',
  `serve_status` int DEFAULT NULL COMMENT '服务单状态，3：服务完成，4：订单关闭',
  `serve_provider_staff_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `canceler_name` varchar(50) DEFAULT NULL COMMENT '取消人姓名',
  `cancel_time` datetime DEFAULT NULL COMMENT '退款时间',
  `cancel_reason` varchar(50) DEFAULT NULL COMMENT '退款原因',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `serve_num` int DEFAULT NULL COMMENT '服务数量',
  `unit` int DEFAULT NULL COMMENT '单位',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `is_deleted` int DEFAULT '0' COMMENT '是否是逻辑删除',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `sort_time` datetime DEFAULT NULL COMMENT '排序时间，服务单状态为服务完成，该字段是完成时间；服务单状态为订单关闭，该时间为退款时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `list_query_index` (`serve_provider_id`,`sort_time`,`serve_status`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_orders_sync`
--

DROP TABLE IF EXISTS `history_orders_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders_sync` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务人类型，2：服务人员，3：机构',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `orders_status` int NOT NULL COMMENT '订单状态，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，1：支付成功，2：已关闭',
  `refund_status` int DEFAULT NULL COMMENT '退款状态',
  `trade_finish_time` datetime DEFAULT NULL COMMENT '订单完成时间',
  `trading_channel` varchar(255) DEFAULT NULL COMMENT '支付渠道，ALI_PAY：支付宝，WECHAT_PAY：微信',
  `third_order_id` varchar(50) DEFAULT NULL COMMENT '支付流水',
  `dispatch_time` datetime DEFAULT NULL COMMENT '派单时间',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `third_refund_order_id` varchar(50) DEFAULT NULL COMMENT '退款流水',
  `canceler_name` varchar(50) DEFAULT NULL COMMENT '取消人姓名',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_provider_staff_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `institution_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构名称',
  `institution_phone` varchar(20) DEFAULT NULL COMMENT '机构电话',
  `place_order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `serve_end_time` datetime DEFAULT NULL COMMENT '服务结束时间',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务结束时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务开始图片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务开始说明',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务完成图片',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务完成说明',
  `payment_timeout` datetime DEFAULT NULL COMMENT '支付超时时间，该时间只对待支付有意义',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消/被退单时间',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消/被退单原因',
  `year` int DEFAULT NULL COMMENT '下单年份,格式：yyyy',
  `month` int DEFAULT NULL COMMENT '下单月份,格式：yyyyMM',
  `day` int DEFAULT NULL COMMENT '下单所在日,格式：yyyyMMdd',
  `hour` int DEFAULT NULL COMMENT '下单所在小时，格式：yyyyMMddHH',
  `sort_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '排序时间字段',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sync` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='历史订单完成15天后同步到历史订单同步表中，通过canal同步到历史订单库中；1天后删除（删除条件当天数据和历史订单库中的订单数据数量一致）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，2：待支付，4：支付成功',
  `refund_status` int DEFAULT NULL COMMENT '退款状态 1退款中 2退款成功 3退款失败',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_canceled`
--

DROP TABLE IF EXISTS `orders_canceled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_canceled` (
  `id` bigint NOT NULL COMMENT '订单id',
  `canceller_id` bigint DEFAULT NULL COMMENT '取消人',
  `canceler_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消人名称',
  `canceller_type` int DEFAULT NULL COMMENT '取消人类型，1：普通用户，4：运营人员',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单取消表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_dispatch`
--

DROP TABLE IF EXISTS `orders_dispatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_dispatch` (
  `id` bigint NOT NULL COMMENT '订单id',
  `orders_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '订单id',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务名称',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务分类名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项目图片',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pur_num` int NOT NULL COMMENT '服务数量',
  `is_transfer_manual` int DEFAULT '0' COMMENT '是否转人工',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='派单池';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_refund`
--

DROP TABLE IF EXISTS `orders_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_refund` (
  `id` bigint NOT NULL COMMENT '订单id',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `real_pay_amount` decimal(10,2) DEFAULT NULL COMMENT '实付金额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单退款表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_seize`
--

DROP TABLE IF EXISTS `orders_seize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_seize` (
  `id` bigint NOT NULL COMMENT '订单id',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务名称',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务分类名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项目图片',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单总金额',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `pay_success_time` datetime DEFAULT NULL COMMENT '订单支付成功时间，用于计算是否进入派单',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pur_num` int NOT NULL COMMENT '服务数量',
  `is_time_out` int DEFAULT '0' COMMENT '抢单是否超时',
  `sort_by` bigint DEFAULT NULL COMMENT '抢单列表排序字段',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sort_by_index` (`sort_by`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='抢单池';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve`
--

DROP TABLE IF EXISTS `orders_serve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint NOT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_provider_sync`
--

DROP TABLE IF EXISTS `serve_provider_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_provider_sync` (
  `id` bigint NOT NULL,
  `serve_times` json DEFAULT NULL COMMENT '服务时间段',
  `acceptance_num` int DEFAULT NULL COMMENT '接单数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `state_persister`
--

DROP TABLE IF EXISTS `state_persister`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state_persister` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `唯一索引` (`state_machine_name`,`biz_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1731974587215843331 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='状态机持久化表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jzo2o-orders'
--

--
-- Dumping routines for database 'jzo2o-orders'
--

--
-- Current Database: `jzo2o-orders-0`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jzo2o-orders-0` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `jzo2o-orders-0`;

--
-- Table structure for table `biz_snapshot`
--

DROP TABLE IF EXISTS `biz_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1705863040399958017 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_snapshot_0`
--

DROP TABLE IF EXISTS `biz_snapshot_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot_0` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1726522810064453633 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_snapshot_1`
--

DROP TABLE IF EXISTS `biz_snapshot_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot_1` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_snapshot_2`
--

DROP TABLE IF EXISTS `biz_snapshot_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot_2` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `breach_record`
--

DROP TABLE IF EXISTS `breach_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `breach_record` (
  `id` bigint NOT NULL COMMENT '违约id',
  `serve_provider_id` bigint NOT NULL COMMENT '违约机构或师傅',
  `serve_provider_type` int NOT NULL COMMENT '类型，2：师傅、3：机构',
  `behavior_type` int NOT NULL COMMENT '行为类型，1：待分配时取消，2：待服务时取消，3：服务中取消，4：派单拒绝，5：派单超时',
  `breach_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '违约原因',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项名称',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `orders_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务编码',
  `served_user_id` bigint NOT NULL COMMENT '被服务人',
  `served_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '被服务人员手机号，脱敏',
  `breach_time` datetime NOT NULL COMMENT '违约时间',
  `breach_day` int NOT NULL COMMENT '违约日，格式例如20200512,2020年5月12日',
  `orders_id` bigint NOT NULL COMMENT '违约单订单id',
  `orders_serve_id` bigint DEFAULT NULL COMMENT '服务单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='违约记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_orders_serve_sync`
--

DROP TABLE IF EXISTS `history_orders_serve_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders_serve_sync` (
  `id` bigint NOT NULL COMMENT '服务单id，和',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `institution_staff_name` varchar(50) DEFAULT NULL COMMENT '机构服务人员名称',
  `institution_name` varchar(100) DEFAULT NULL COMMENT '机构名称',
  `orders_origin_type` int DEFAULT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `contacts_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户姓名',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户电话',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务地址',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务分裂名称',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务图片',
  `serve_status` int DEFAULT NULL COMMENT '服务单状态，3：服务完成，4：订单关闭',
  `serve_provider_staff_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `canceler_name` varchar(50) DEFAULT NULL COMMENT '取消人姓名',
  `cancel_time` datetime DEFAULT NULL COMMENT '退款时间',
  `cancel_reason` varchar(50) DEFAULT NULL COMMENT '退款原因',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `serve_num` int DEFAULT NULL COMMENT '服务数量',
  `unit` int DEFAULT NULL COMMENT '单位',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `is_deleted` int DEFAULT '0' COMMENT '是否是逻辑删除',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `sort_time` datetime DEFAULT NULL COMMENT '排序时间，服务单状态为服务完成，该字段是完成时间；服务单状态为订单关闭，该时间为退款时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `list_query_index` (`serve_provider_id`,`sort_time`,`serve_status`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_orders_sync`
--

DROP TABLE IF EXISTS `history_orders_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders_sync` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务人类型，2：服务人员，3：机构',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `orders_status` int NOT NULL COMMENT '订单状态，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，1：支付成功，2：已关闭',
  `refund_status` int DEFAULT NULL COMMENT '退款状态',
  `trade_finish_time` datetime DEFAULT NULL COMMENT '订单完成时间',
  `trading_channel` varchar(255) DEFAULT NULL COMMENT '支付渠道，ALI_PAY：支付宝，WECHAT_PAY：微信',
  `third_order_id` varchar(50) DEFAULT NULL COMMENT '支付流水',
  `dispatch_time` datetime DEFAULT NULL COMMENT '派单时间',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `third_refund_order_id` varchar(50) DEFAULT NULL COMMENT '退款流水',
  `canceler_name` varchar(50) DEFAULT NULL COMMENT '取消人姓名',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_provider_staff_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `institution_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构名称',
  `institution_phone` varchar(20) DEFAULT NULL COMMENT '机构电话',
  `place_order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `serve_end_time` datetime DEFAULT NULL COMMENT '服务结束时间',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务结束时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务开始图片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务开始说明',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务完成图片',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务完成说明',
  `payment_timeout` datetime DEFAULT NULL COMMENT '支付超时时间，该时间只对待支付有意义',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消/被退单时间',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消/被退单原因',
  `year` int DEFAULT NULL COMMENT '下单年份,格式：yyyy',
  `month` int DEFAULT NULL COMMENT '下单月份,格式：yyyyMM',
  `day` int DEFAULT NULL COMMENT '下单所在日,格式：yyyyMMdd',
  `hour` int DEFAULT NULL COMMENT '下单所在小时，格式：yyyyMMddHH',
  `sort_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '排序时间字段',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sync` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='历史订单完成15天后同步到历史订单同步表中，通过canal同步到历史订单库中；1天后删除（删除条件当天数据和历史订单库中的订单数据数量一致）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，0：待支付，1：支付成功，2：已关闭，3：退款成功',
  `refund_status` int DEFAULT NULL COMMENT '退款状态 1退款中 2退款成功 3退款失败',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC),
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_0`
--

DROP TABLE IF EXISTS `orders_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_0` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，2：待支付，4：支付成功',
  `refund_status` int DEFAULT NULL COMMENT '退款状态 1退款中 2退款成功 3退款失败',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC),
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC,`serve_item_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_1`
--

DROP TABLE IF EXISTS `orders_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_1` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，2：待支付，4：支付成功',
  `refund_status` int DEFAULT NULL COMMENT '退款状态 1退款中 2退款成功 3退款失败',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC),
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_2`
--

DROP TABLE IF EXISTS `orders_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_2` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，2：待支付，4：支付成功',
  `refund_status` int DEFAULT NULL COMMENT '退款状态 1退款中 2退款成功 3退款失败',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC),
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_canceled`
--

DROP TABLE IF EXISTS `orders_canceled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_canceled` (
  `id` bigint NOT NULL COMMENT '订单id',
  `canceller_id` bigint DEFAULT NULL COMMENT '取消人',
  `canceler_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消人名称',
  `canceller_type` int DEFAULT NULL COMMENT '取消人类型，1：普通用户，4：运营人员',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单取消表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_dispatch`
--

DROP TABLE IF EXISTS `orders_dispatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_dispatch` (
  `id` bigint NOT NULL COMMENT '订单id',
  `orders_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '订单id',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务名称',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务分类名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项目图片',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pur_num` int NOT NULL COMMENT '服务数量',
  `is_transfer_manual` int DEFAULT '0' COMMENT '是否转人工',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='派单池';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_refund`
--

DROP TABLE IF EXISTS `orders_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_refund` (
  `id` bigint NOT NULL COMMENT '订单id',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `real_pay_amount` decimal(10,2) DEFAULT NULL COMMENT '实付金额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单退款表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_seize`
--

DROP TABLE IF EXISTS `orders_seize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_seize` (
  `id` bigint NOT NULL COMMENT '订单id',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务名称',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务分类名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项目图片',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单总金额',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `pay_success_time` datetime DEFAULT NULL COMMENT '订单支付成功时间，用于计算是否进入派单',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pur_num` int NOT NULL COMMENT '服务数量',
  `is_time_out` int DEFAULT '0' COMMENT '抢单是否超时',
  `sort_by` bigint DEFAULT NULL COMMENT '抢单列表排序字段',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sort_by_index` (`sort_by`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='抢单池';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve`
--

DROP TABLE IF EXISTS `orders_serve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint NOT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve_0`
--

DROP TABLE IF EXISTS `orders_serve_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve_0` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint DEFAULT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve_1`
--

DROP TABLE IF EXISTS `orders_serve_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve_1` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint DEFAULT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve_2`
--

DROP TABLE IF EXISTS `orders_serve_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve_2` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint DEFAULT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_provider_sync`
--

DROP TABLE IF EXISTS `serve_provider_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_provider_sync` (
  `id` bigint NOT NULL,
  `serve_times` json DEFAULT NULL COMMENT '服务时间段',
  `acceptance_num` int DEFAULT NULL COMMENT '接单数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `state_persister`
--

DROP TABLE IF EXISTS `state_persister`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state_persister` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `唯一索引` (`state_machine_name`,`biz_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1733125153612165122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='状态机持久化表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `branch_id` bigint NOT NULL,
  `xid` varchar(100) NOT NULL,
  `context` varchar(128) NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  `ext` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jzo2o-orders-0'
--

--
-- Dumping routines for database 'jzo2o-orders-0'
--

--
-- Current Database: `jzo2o-orders-1`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jzo2o-orders-1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `jzo2o-orders-1`;

--
-- Table structure for table `biz_snapshot`
--

DROP TABLE IF EXISTS `biz_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1705863040399958017 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_snapshot_0`
--

DROP TABLE IF EXISTS `biz_snapshot_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot_0` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1733125162183688193 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_snapshot_1`
--

DROP TABLE IF EXISTS `biz_snapshot_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot_1` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_snapshot_2`
--

DROP TABLE IF EXISTS `biz_snapshot_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot_2` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `breach_record`
--

DROP TABLE IF EXISTS `breach_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `breach_record` (
  `id` bigint NOT NULL COMMENT '违约id',
  `serve_provider_id` bigint NOT NULL COMMENT '违约机构或师傅',
  `serve_provider_type` int NOT NULL COMMENT '类型，2：师傅、3：机构',
  `behavior_type` int NOT NULL COMMENT '行为类型，1：待分配时取消，2：待服务时取消，3：服务中取消，4：派单拒绝，5：派单超时',
  `breach_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '违约原因',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项名称',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `orders_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务编码',
  `served_user_id` bigint NOT NULL COMMENT '被服务人',
  `served_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '被服务人员手机号，脱敏',
  `breach_time` datetime NOT NULL COMMENT '违约时间',
  `breach_day` int NOT NULL COMMENT '违约日，格式例如20200512,2020年5月12日',
  `orders_id` bigint NOT NULL COMMENT '违约单订单id',
  `orders_serve_id` bigint DEFAULT NULL COMMENT '服务单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='违约记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_orders_serve_sync`
--

DROP TABLE IF EXISTS `history_orders_serve_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders_serve_sync` (
  `id` bigint NOT NULL COMMENT '服务单id，和',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `institution_staff_name` varchar(50) DEFAULT NULL COMMENT '机构服务人员名称',
  `institution_name` varchar(100) DEFAULT NULL COMMENT '机构名称',
  `orders_origin_type` int DEFAULT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `contacts_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户姓名',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户电话',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务地址',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务分裂名称',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务图片',
  `serve_status` int DEFAULT NULL COMMENT '服务单状态，3：服务完成，4：订单关闭',
  `serve_provider_staff_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `canceler_name` varchar(50) DEFAULT NULL COMMENT '取消人姓名',
  `cancel_time` datetime DEFAULT NULL COMMENT '退款时间',
  `cancel_reason` varchar(50) DEFAULT NULL COMMENT '退款原因',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `serve_num` int DEFAULT NULL COMMENT '服务数量',
  `unit` int DEFAULT NULL COMMENT '单位',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `is_deleted` int DEFAULT '0' COMMENT '是否是逻辑删除',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `sort_time` datetime DEFAULT NULL COMMENT '排序时间，服务单状态为服务完成，该字段是完成时间；服务单状态为订单关闭，该时间为退款时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `list_query_index` (`serve_provider_id`,`sort_time`,`serve_status`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_orders_sync`
--

DROP TABLE IF EXISTS `history_orders_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders_sync` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务人类型，2：服务人员，3：机构',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `orders_status` int NOT NULL COMMENT '订单状态，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，1：支付成功，2：已关闭',
  `refund_status` int DEFAULT NULL COMMENT '退款状态',
  `trade_finish_time` datetime DEFAULT NULL COMMENT '订单完成时间',
  `trading_channel` varchar(255) DEFAULT NULL COMMENT '支付渠道，ALI_PAY：支付宝，WECHAT_PAY：微信',
  `third_order_id` varchar(50) DEFAULT NULL COMMENT '支付流水',
  `dispatch_time` datetime DEFAULT NULL COMMENT '派单时间',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `third_refund_order_id` varchar(50) DEFAULT NULL COMMENT '退款流水',
  `canceler_name` varchar(50) DEFAULT NULL COMMENT '取消人姓名',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_provider_staff_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `institution_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构名称',
  `institution_phone` varchar(20) DEFAULT NULL COMMENT '机构电话',
  `place_order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `serve_end_time` datetime DEFAULT NULL COMMENT '服务结束时间',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务结束时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务开始图片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务开始说明',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务完成图片',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务完成说明',
  `payment_timeout` datetime DEFAULT NULL COMMENT '支付超时时间，该时间只对待支付有意义',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消/被退单时间',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消/被退单原因',
  `year` int DEFAULT NULL COMMENT '下单年份,格式：yyyy',
  `month` int DEFAULT NULL COMMENT '下单月份,格式：yyyyMM',
  `day` int DEFAULT NULL COMMENT '下单所在日,格式：yyyyMMdd',
  `hour` int DEFAULT NULL COMMENT '下单所在小时，格式：yyyyMMddHH',
  `sort_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '排序时间字段',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sync` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='历史订单完成15天后同步到历史订单同步表中，通过canal同步到历史订单库中；1天后删除（删除条件当天数据和历史订单库中的订单数据数量一致）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，0：待支付，1：支付成功，2：已关闭，3：退款成功',
  `refund_status` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC),
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_0`
--

DROP TABLE IF EXISTS `orders_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_0` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，2：待支付，4：支付成功',
  `refund_status` int DEFAULT NULL COMMENT '退款状态 1退款中 2退款成功 3退款失败',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC) COMMENT '我的订单列表查询索引',
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_1`
--

DROP TABLE IF EXISTS `orders_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_1` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，2：待支付，4：支付成功',
  `refund_status` int DEFAULT NULL COMMENT '退款状态 1退款中 2退款成功 3退款失败',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC),
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_2`
--

DROP TABLE IF EXISTS `orders_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_2` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，2：待支付，4：支付成功',
  `refund_status` int DEFAULT NULL COMMENT '退款状态 1退款中 2退款成功 3退款失败',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC),
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_canceled`
--

DROP TABLE IF EXISTS `orders_canceled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_canceled` (
  `id` bigint NOT NULL COMMENT '订单id',
  `canceller_id` bigint DEFAULT NULL COMMENT '取消人',
  `canceler_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消人名称',
  `canceller_type` int DEFAULT NULL COMMENT '取消人类型，1：普通用户，4：运营人员',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单取消表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_dispatch`
--

DROP TABLE IF EXISTS `orders_dispatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_dispatch` (
  `id` bigint NOT NULL COMMENT '订单id',
  `orders_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '订单id',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务名称',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务分类名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项目图片',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pur_num` int NOT NULL COMMENT '服务数量',
  `is_transfer_manual` int DEFAULT '0' COMMENT '是否转人工',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='派单池';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_refund`
--

DROP TABLE IF EXISTS `orders_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_refund` (
  `id` bigint NOT NULL COMMENT '订单id',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `real_pay_amount` decimal(10,2) DEFAULT NULL COMMENT '实付金额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单退款表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_seize`
--

DROP TABLE IF EXISTS `orders_seize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_seize` (
  `id` bigint NOT NULL COMMENT '订单id',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务名称',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务分类名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项目图片',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单总金额',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `pay_success_time` datetime DEFAULT NULL COMMENT '订单支付成功时间，用于计算是否进入派单',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pur_num` int NOT NULL COMMENT '服务数量',
  `is_time_out` int DEFAULT '0' COMMENT '抢单是否超时',
  `sort_by` bigint DEFAULT NULL COMMENT '抢单列表排序字段',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sort_by_index` (`sort_by`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='抢单池';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve`
--

DROP TABLE IF EXISTS `orders_serve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint NOT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve_0`
--

DROP TABLE IF EXISTS `orders_serve_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve_0` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint DEFAULT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve_1`
--

DROP TABLE IF EXISTS `orders_serve_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve_1` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint DEFAULT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve_2`
--

DROP TABLE IF EXISTS `orders_serve_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve_2` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint DEFAULT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_provider_sync`
--

DROP TABLE IF EXISTS `serve_provider_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_provider_sync` (
  `id` bigint NOT NULL,
  `serve_times` json DEFAULT NULL COMMENT '服务时间段',
  `acceptance_num` int DEFAULT NULL COMMENT '接单数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `state_persister`
--

DROP TABLE IF EXISTS `state_persister`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state_persister` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(255) DEFAULT NULL COMMENT '业务id',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `唯一索引` (`state_machine_name`,`biz_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1733125153612165122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='状态机持久化表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `branch_id` bigint NOT NULL,
  `xid` varchar(100) NOT NULL,
  `context` varchar(128) NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  `ext` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jzo2o-orders-1'
--

--
-- Dumping routines for database 'jzo2o-orders-1'
--

--
-- Current Database: `jzo2o-orders-2`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jzo2o-orders-2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `jzo2o-orders-2`;

--
-- Table structure for table `biz_snapshot`
--

DROP TABLE IF EXISTS `biz_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1705863040399958017 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_snapshot_0`
--

DROP TABLE IF EXISTS `biz_snapshot_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot_0` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_snapshot_1`
--

DROP TABLE IF EXISTS `biz_snapshot_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot_1` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biz_snapshot_2`
--

DROP TABLE IF EXISTS `biz_snapshot_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_snapshot_2` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务id',
  `db_shard_id` bigint DEFAULT NULL COMMENT '分库键',
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态代码',
  `biz_data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务数据',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务数据快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `breach_record`
--

DROP TABLE IF EXISTS `breach_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `breach_record` (
  `id` bigint NOT NULL COMMENT '违约id',
  `serve_provider_id` bigint NOT NULL COMMENT '违约机构或师傅',
  `serve_provider_type` int NOT NULL COMMENT '类型，2：师傅、3：机构',
  `behavior_type` int NOT NULL COMMENT '行为类型，1：待分配时取消，2：待服务时取消，3：服务中取消，4：派单拒绝，5：派单超时',
  `breach_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '违约原因',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项名称',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `orders_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务编码',
  `served_user_id` bigint NOT NULL COMMENT '被服务人',
  `served_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '被服务人员手机号，脱敏',
  `breach_time` datetime NOT NULL COMMENT '违约时间',
  `breach_day` int NOT NULL COMMENT '违约日，格式例如20200512,2020年5月12日',
  `orders_id` bigint NOT NULL COMMENT '违约单订单id',
  `orders_serve_id` bigint DEFAULT NULL COMMENT '服务单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='违约记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_orders_serve_sync`
--

DROP TABLE IF EXISTS `history_orders_serve_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders_serve_sync` (
  `id` bigint NOT NULL COMMENT '服务单id，和',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `institution_staff_name` varchar(50) DEFAULT NULL COMMENT '机构服务人员名称',
  `institution_name` varchar(100) DEFAULT NULL COMMENT '机构名称',
  `orders_origin_type` int DEFAULT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `contacts_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户姓名',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户电话',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务地址',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务分裂名称',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务图片',
  `serve_status` int DEFAULT NULL COMMENT '服务单状态，3：服务完成，4：订单关闭',
  `serve_provider_staff_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `canceler_name` varchar(50) DEFAULT NULL COMMENT '取消人姓名',
  `cancel_time` datetime DEFAULT NULL COMMENT '退款时间',
  `cancel_reason` varchar(50) DEFAULT NULL COMMENT '退款原因',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `serve_num` int DEFAULT NULL COMMENT '服务数量',
  `unit` int DEFAULT NULL COMMENT '单位',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `is_deleted` int DEFAULT '0' COMMENT '是否是逻辑删除',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `sort_time` datetime DEFAULT NULL COMMENT '排序时间，服务单状态为服务完成，该字段是完成时间；服务单状态为订单关闭，该时间为退款时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `list_query_index` (`serve_provider_id`,`sort_time`,`serve_status`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_orders_sync`
--

DROP TABLE IF EXISTS `history_orders_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders_sync` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务人类型，2：服务人员，3：机构',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `orders_status` int NOT NULL COMMENT '订单状态，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，1：支付成功，2：已关闭',
  `refund_status` int DEFAULT NULL COMMENT '退款状态',
  `trade_finish_time` datetime DEFAULT NULL COMMENT '订单完成时间',
  `trading_channel` varchar(255) DEFAULT NULL COMMENT '支付渠道，ALI_PAY：支付宝，WECHAT_PAY：微信',
  `third_order_id` varchar(50) DEFAULT NULL COMMENT '支付流水',
  `dispatch_time` datetime DEFAULT NULL COMMENT '派单时间',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `third_refund_order_id` varchar(50) DEFAULT NULL COMMENT '退款流水',
  `canceler_name` varchar(50) DEFAULT NULL COMMENT '取消人姓名',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_provider_staff_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `institution_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构名称',
  `institution_phone` varchar(20) DEFAULT NULL COMMENT '机构电话',
  `place_order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `serve_end_time` datetime DEFAULT NULL COMMENT '服务结束时间',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务结束时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务开始图片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务开始说明',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务完成图片',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务完成说明',
  `payment_timeout` datetime DEFAULT NULL COMMENT '支付超时时间，该时间只对待支付有意义',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消/被退单时间',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消/被退单原因',
  `year` int DEFAULT NULL COMMENT '下单年份,格式：yyyy',
  `month` int DEFAULT NULL COMMENT '下单月份,格式：yyyyMM',
  `day` int DEFAULT NULL COMMENT '下单所在日,格式：yyyyMMdd',
  `hour` int DEFAULT NULL COMMENT '下单所在小时，格式：yyyyMMddHH',
  `sort_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '排序时间字段',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sync` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='历史订单完成15天后同步到历史订单同步表中，通过canal同步到历史订单库中；1天后删除（删除条件当天数据和历史订单库中的订单数据数量一致）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，0：待支付，1：支付成功，2：已关闭，3：退款成功',
  `refund_status` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC),
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_0`
--

DROP TABLE IF EXISTS `orders_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_0` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，2：待支付，4：支付成功',
  `refund_status` int DEFAULT NULL COMMENT '退款状态 1退款中 2退款成功 3退款失败',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC),
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_1`
--

DROP TABLE IF EXISTS `orders_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_1` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，2：待支付，4：支付成功',
  `refund_status` int DEFAULT NULL COMMENT '退款状态 1退款中 2退款成功 3退款失败',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC),
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_2`
--

DROP TABLE IF EXISTS `orders_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_2` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `orders_status` int NOT NULL COMMENT '订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，2：待支付，4：支付成功',
  `refund_status` int DEFAULT NULL COMMENT '退款状态 1退款中 2退款成功 3退款失败',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_status` int NOT NULL DEFAULT '0' COMMENT '评价状态 0:未评价  1:已评价',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的交易号',
  `refund_no` bigint DEFAULT NULL COMMENT '支付服务退款单号',
  `refund_id` varchar(50) DEFAULT NULL COMMENT '第三方支付的退款单号',
  `trading_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段，serve_start_time秒级时间戳+订单id后六位',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `query_index_1` (`user_id`,`display`,`sort_by` DESC),
  KEY `query_index_0` (`orders_status`,`user_id`,`display`,`sort_by` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_canceled`
--

DROP TABLE IF EXISTS `orders_canceled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_canceled` (
  `id` bigint NOT NULL COMMENT '订单id',
  `canceller_id` bigint DEFAULT NULL COMMENT '取消人',
  `canceler_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消人名称',
  `canceller_type` int DEFAULT NULL COMMENT '取消人类型，1：普通用户，4：运营人员',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单取消表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_dispatch`
--

DROP TABLE IF EXISTS `orders_dispatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_dispatch` (
  `id` bigint NOT NULL COMMENT '订单id',
  `orders_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '订单id',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务名称',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务分类名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项目图片',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pur_num` int NOT NULL COMMENT '服务数量',
  `is_transfer_manual` int DEFAULT '0' COMMENT '是否转人工',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='派单池';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_refund`
--

DROP TABLE IF EXISTS `orders_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_refund` (
  `id` bigint NOT NULL COMMENT '订单id',
  `trading_order_no` bigint DEFAULT NULL COMMENT '支付服务交易单号',
  `real_pay_amount` decimal(10,2) DEFAULT NULL COMMENT '实付金额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单退款表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_seize`
--

DROP TABLE IF EXISTS `orders_seize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_seize` (
  `id` bigint NOT NULL COMMENT '订单id',
  `city_code` varchar(50) NOT NULL DEFAULT '' COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务名称',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务分类名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项目图片',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单总金额',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `pay_success_time` datetime DEFAULT NULL COMMENT '订单支付成功时间，用于计算是否进入派单',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pur_num` int NOT NULL COMMENT '服务数量',
  `is_time_out` int DEFAULT '0' COMMENT '抢单是否超时',
  `sort_by` bigint DEFAULT NULL COMMENT '抢单列表排序字段',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='抢单池';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve`
--

DROP TABLE IF EXISTS `orders_serve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint NOT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve_0`
--

DROP TABLE IF EXISTS `orders_serve_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve_0` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint DEFAULT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve_1`
--

DROP TABLE IF EXISTS `orders_serve_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve_1` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint DEFAULT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_serve_2`
--

DROP TABLE IF EXISTS `orders_serve_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_serve_2` (
  `id` bigint NOT NULL COMMENT '任务id',
  `user_id` bigint DEFAULT NULL COMMENT '属于哪个用户',
  `serve_provider_id` bigint NOT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `orders_id` bigint DEFAULT NULL COMMENT '订单id',
  `orders_origin_type` int NOT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_id` bigint NOT NULL COMMENT '服务分类id',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_status` int NOT NULL COMMENT '任务状态',
  `settlement_status` int NOT NULL DEFAULT '0' COMMENT '结算状态，0：不可结算，1：待结算，2：结算完成',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_item_img` varchar(255) DEFAULT NULL,
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间,可以是退单，可以是取消时间',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sort_by` bigint DEFAULT NULL COMMENT '排序字段（serve_start_time（秒级时间戳）+订单id（后6位））',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serve_provider_sync`
--

DROP TABLE IF EXISTS `serve_provider_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serve_provider_sync` (
  `id` bigint NOT NULL,
  `serve_times` json DEFAULT NULL COMMENT '服务时间段',
  `acceptance_num` int DEFAULT NULL COMMENT '接单数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='服务状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `state_persister`
--

DROP TABLE IF EXISTS `state_persister`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state_persister` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state_machine_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态机名称',
  `biz_id` varchar(255) DEFAULT NULL COMMENT '业务id',
  `state` varchar(255) DEFAULT NULL COMMENT '状态',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `唯一索引` (`state_machine_name`,`biz_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1733125153612165122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='状态机持久化表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `branch_id` bigint NOT NULL,
  `xid` varchar(100) NOT NULL,
  `context` varchar(128) NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  `ext` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jzo2o-orders-2'
--

--
-- Dumping routines for database 'jzo2o-orders-2'
--

--
-- Current Database: `jzo2o-orders-history`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jzo2o-orders-history` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `jzo2o-orders-history`;

--
-- Table structure for table `history_orders`
--

DROP TABLE IF EXISTS `history_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务人类型，2：服务人员，3：机构',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `orders_status` int NOT NULL COMMENT '订单状态，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，1：支付成功，2：已关闭',
  `refund_status` int DEFAULT NULL COMMENT '退款状态',
  `trade_finish_time` datetime DEFAULT NULL COMMENT '订单完成时间',
  `trading_channel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '支付渠道',
  `third_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '三方支付渠道',
  `dispatch_time` datetime DEFAULT NULL COMMENT '派单时间',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `third_refund_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '三方退款流水',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `canceler_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消人',
  `serve_provider_staff_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `institution_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构名称',
  `institution_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构电话',
  `place_order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `serve_end_time` datetime DEFAULT NULL COMMENT '服务结束时间',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务结束时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务开始图片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务开始说明',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务完成图片',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务完成说明',
  `payment_timeout` datetime DEFAULT NULL COMMENT '支付超时时间，该时间只对待支付有意义',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消/被退单时间',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消/被退单原因',
  `year` int DEFAULT NULL COMMENT '完结年份，格式yyyy',
  `month` int DEFAULT NULL COMMENT '完结月份，格式yyyyMM',
  `day` int DEFAULT NULL COMMENT '完结日，格式yyyyMMdd',
  `hour` int DEFAULT NULL COMMENT '完结小时，格式yyyyMMddHH',
  `evaluation_time` datetime DEFAULT NULL COMMENT '评价时间',
  `evaluation_score` double(10,2) DEFAULT NULL COMMENT '评分',
  `display` int DEFAULT '1' COMMENT '用户端是否展示，1：展示，0：隐藏',
  `sort_time` datetime NOT NULL COMMENT '排序时间字段',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `serve_provider_id_index` (`serve_provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_orders_serve`
--

DROP TABLE IF EXISTS `history_orders_serve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders_serve` (
  `id` bigint NOT NULL COMMENT '服务单id，和',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `institution_staff_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构服务人员名称',
  `institution_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构名称',
  `orders_origin_type` int DEFAULT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `contacts_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户姓名',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户电话',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务地址',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务分裂名称',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务图片',
  `serve_status` int DEFAULT NULL COMMENT '服务单状态，3：服务完成，4：订单关闭',
  `serve_provider_staff_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `canceler_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消人姓名',
  `cancel_time` datetime DEFAULT NULL COMMENT '退款时间',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '退款原因',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `refund_time` datetime DEFAULT NULL COMMENT '退款时间',
  `refund_reason` varchar(200) DEFAULT NULL COMMENT '退款原因',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `serve_num` int DEFAULT NULL COMMENT '服务数量',
  `unit` int DEFAULT NULL COMMENT '单位',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `is_deleted` int DEFAULT '0' COMMENT '是否是逻辑删除',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `sort_time` datetime DEFAULT NULL COMMENT '排序时间，服务单状态为服务完成，该字段是完成时间；服务单状态为订单关闭，该时间为退款时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `list_query_index` (`serve_provider_id`,`sort_time`,`serve_status`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_orders_serve_sync`
--

DROP TABLE IF EXISTS `history_orders_serve_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders_serve_sync` (
  `id` bigint NOT NULL COMMENT '服务单id，和',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人员或服务机构id',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务者类型，2：服务端服务，3：机构端服务',
  `institution_staff_id` bigint DEFAULT NULL COMMENT '机构服务人员id',
  `institution_staff_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构服务人员名称',
  `institution_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构名称',
  `orders_origin_type` int DEFAULT NULL COMMENT '订单来源类型，1：抢单，2：派单',
  `contacts_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户姓名',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户电话',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务地址',
  `city_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市编码',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务分类id',
  `serve_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务分裂名称',
  `serve_start_time` datetime DEFAULT NULL COMMENT '预约时间',
  `serve_item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_id` bigint DEFAULT NULL COMMENT '服务项id',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务图片',
  `serve_status` int DEFAULT NULL COMMENT '服务单状态，3：服务完成，4：订单关闭',
  `serve_provider_staff_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `canceler_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消人姓名',
  `cancel_time` datetime DEFAULT NULL COMMENT '退款时间',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '退款原因',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务完结时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务前照片',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务后照片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务前说明',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务后说明',
  `orders_amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `pur_num` int DEFAULT NULL COMMENT '购买数量',
  `serve_num` int DEFAULT NULL COMMENT '服务数量',
  `unit` int DEFAULT NULL COMMENT '单位',
  `display` int DEFAULT '1' COMMENT '服务端/机构端是否展示，1：展示，0：隐藏',
  `is_deleted` int DEFAULT '0' COMMENT '是否是逻辑删除',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `sort_time` datetime DEFAULT NULL COMMENT '排序时间，服务单状态为服务完成，该字段是完成时间；服务单状态为订单关闭，该时间为退款时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `list_query_index` (`serve_provider_id`,`sort_time`,`serve_status`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_orders_sync`
--

DROP TABLE IF EXISTS `history_orders_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_orders_sync` (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '订单所属人',
  `serve_type_id` bigint DEFAULT NULL COMMENT '服务类型id',
  `serve_provider_id` bigint DEFAULT NULL COMMENT '服务人',
  `serve_provider_type` int DEFAULT NULL COMMENT '服务人类型，2：服务人员，3：机构',
  `serve_item_id` bigint NOT NULL COMMENT '服务项id',
  `serve_id` bigint NOT NULL COMMENT '服务id',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '城市编码',
  `serve_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务类型名称',
  `serve_item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项名称',
  `serve_item_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务项图片',
  `unit` int DEFAULT NULL COMMENT '服务单位',
  `orders_status` int NOT NULL COMMENT '订单状态，500：订单完成，600：已取消，700：已关闭',
  `pay_status` int DEFAULT NULL COMMENT '支付状态，1：支付成功，2：已关闭',
  `refund_status` int DEFAULT NULL,
  `trade_finish_time` datetime DEFAULT NULL COMMENT '订单完成时间',
  `trading_channel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '支付渠道，ALI_PAY：支付宝，WECHAT_PAY：微信',
  `third_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '支付流水',
  `dispatch_time` datetime DEFAULT NULL COMMENT '派单时间',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `pur_num` int NOT NULL DEFAULT '1' COMMENT '购买数量',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `real_pay_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `third_refund_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '退款流水',
  `canceler_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消人姓名',
  `discount_amount` decimal(10,2) NOT NULL COMMENT '优惠金额',
  `serve_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务详细地址',
  `contacts_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人手机号',
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系人姓名',
  `serve_provider_staff_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人姓名',
  `serve_provider_staff_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务人手机号',
  `institution_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机构名称',
  `institution_phone` varchar(20) DEFAULT NULL COMMENT '机构电话',
  `place_order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `serve_start_time` datetime NOT NULL COMMENT '服务开始时间',
  `serve_end_time` datetime DEFAULT NULL COMMENT '服务结束时间',
  `real_serve_start_time` datetime DEFAULT NULL COMMENT '实际服务开始时间',
  `real_serve_end_time` datetime DEFAULT NULL COMMENT '实际服务结束时间',
  `serve_before_imgs` json DEFAULT NULL COMMENT '服务开始图片',
  `serve_before_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务开始说明',
  `serve_after_imgs` json DEFAULT NULL COMMENT '服务完成图片',
  `serve_after_illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '服务完成说明',
  `payment_timeout` datetime DEFAULT NULL COMMENT '支付超时时间，该时间只对待支付有意义',
  `lon` double(10,5) DEFAULT NULL COMMENT '经度',
  `lat` double(10,5) DEFAULT NULL COMMENT '纬度',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消/被退单时间',
  `cancel_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消/被退单原因',
  `year` int DEFAULT NULL COMMENT '下单年份,格式：yyyy',
  `month` int DEFAULT NULL COMMENT '下单月份,格式：yyyyMM',
  `day` int DEFAULT NULL COMMENT '下单所在日,格式：yyyyMMdd',
  `hour` int DEFAULT NULL COMMENT '下单所在小时，格式：yyyyMMddHH',
  `sort_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '排序时间字段',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='历史订单完成15天后同步到历史订单同步表中，通过canal同步到历史订单库中；1天后删除（删除条件当天数据和历史订单库中的订单数据数量一致）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stat_day`
--

DROP TABLE IF EXISTS `stat_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stat_day` (
  `id` bigint NOT NULL,
  `stat_time` int NOT NULL COMMENT '统计日期，格式：yyyyMMdd',
  `effective_order_num` int NOT NULL DEFAULT '0' COMMENT '有效订单数',
  `cancel_order_num` int NOT NULL DEFAULT '0' COMMENT '取消订单数',
  `close_order_num` int NOT NULL DEFAULT '0' COMMENT '关闭订单数',
  `effective_order_total_amount` decimal(10,2) NOT NULL COMMENT '有效总金额',
  `real_pay_average_price` decimal(10,2) NOT NULL COMMENT '实付订单均价',
  `total_order_num` int NOT NULL DEFAULT '0' COMMENT '订单总数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='日统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stat_hour`
--

DROP TABLE IF EXISTS `stat_hour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stat_hour` (
  `id` bigint NOT NULL,
  `stat_time` int NOT NULL COMMENT '统计日期，格式：yyyyMMdd',
  `effective_order_num` int NOT NULL DEFAULT '0' COMMENT '有效订单数',
  `cancel_order_num` int NOT NULL DEFAULT '0' COMMENT '取消订单数',
  `close_order_num` int NOT NULL DEFAULT '0' COMMENT '关闭订单数',
  `effective_order_total_amount` decimal(10,2) NOT NULL COMMENT '有效总金额',
  `real_pay_average_price` decimal(10,2) NOT NULL COMMENT '实付订单均价',
  `total_order_num` int NOT NULL DEFAULT '0' COMMENT '订单总数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='小时统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jzo2o-orders-history'
--

--
-- Dumping routines for database 'jzo2o-orders-history'
--

--
-- Current Database: `jzo2o-trade`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jzo2o-trade` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `jzo2o-trade`;

--
-- Table structure for table `pay_channel`
--

DROP TABLE IF EXISTS `pay_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pay_channel` (
  `id` bigint NOT NULL COMMENT '主键',
  `channel_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '通道名称',
  `channel_label` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '通道唯一标记',
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '域名',
  `app_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '商户appid',
  `public_key` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '支付公钥',
  `merchant_private_key` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '商户私钥',
  `other_config` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '其他配置',
  `encrypt_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'AES混淆密钥',
  `remark` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '说明',
  `notify_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回调地址',
  `enable_flag` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否有效',
  `enterprise_id` bigint DEFAULT NULL COMMENT '商户ID【系统内部识别使用】',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='交易渠道表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `refund_record`
--

DROP TABLE IF EXISTS `refund_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refund_record` (
  `id` bigint NOT NULL COMMENT '主键',
  `trading_order_no` bigint NOT NULL COMMENT '交易系统订单号【对于三方来说：商户订单】',
  `product_app_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '业务系统应用标识',
  `product_order_no` bigint NOT NULL COMMENT '业务系统订单号',
  `refund_no` bigint NOT NULL COMMENT '本次退款订单号',
  `refund_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '第三方支付的退款单号',
  `enterprise_id` bigint NOT NULL COMMENT '商户号',
  `trading_channel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '退款渠道【支付宝、微信、现金】',
  `refund_status` int NOT NULL COMMENT '退款状态：0-发起退款,1-退款中，2-成功, 3-失败',
  `refund_code` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '返回编码',
  `refund_msg` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '返回信息',
  `memo` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注【订单门店，桌台信息】',
  `refund_amount` decimal(12,2) NOT NULL COMMENT '本次退款金额',
  `total` decimal(12,2) NOT NULL COMMENT '原订单金额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `refund_no` (`refund_no`),
  KEY `refund_status` (`refund_status`) USING BTREE,
  KEY `created` (`create_time`) USING BTREE,
  KEY `trading_order_no` (`trading_order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='退款记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading`
--

DROP TABLE IF EXISTS `trading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trading` (
  `id` bigint NOT NULL COMMENT '主键',
  `product_app_id` varchar(50) NOT NULL COMMENT '业务系统应用标识',
  `product_order_no` bigint NOT NULL COMMENT '业务系统订单号',
  `trading_order_no` bigint NOT NULL COMMENT '交易系统订单号【对于三方来说：商户订单】',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '第三方支付交易号',
  `trading_channel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付渠道【支付宝、微信、现金、免单挂账】',
  `trading_type` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '交易类型【付款、退款、免单、挂账】',
  `trading_state` int NOT NULL COMMENT '交易单状态【2-付款中,3-付款失败,4-已结算,5-取消订单,6-免单,7-挂账】',
  `payee_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收款人姓名',
  `payee_id` bigint DEFAULT NULL COMMENT '收款人账户ID',
  `payer_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '付款人姓名',
  `payer_id` bigint DEFAULT NULL COMMENT '付款人Id',
  `trading_amount` decimal(22,2) NOT NULL COMMENT '交易金额，单位：元',
  `refund` decimal(12,2) DEFAULT NULL COMMENT '退款金额【付款后，单位：元',
  `is_refund` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '是否有退款：YES，NO',
  `result_code` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '第三方交易返回编码【最终确认交易结果】',
  `result_msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '第三方交易返回提示消息【最终确认交易信息】',
  `result_json` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '第三方交易返回信息json【分析交易最终信息】',
  `place_order_code` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '统一下单返回编码',
  `place_order_msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '统一下单返回信息',
  `place_order_json` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '统一下单返回信息json【用于生产二维码、Android ios唤醒支付等】',
  `enterprise_id` bigint NOT NULL COMMENT '商户号',
  `memo` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注【订单门店，桌台信息】',
  `qr_code` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '二维码base64数据',
  `open_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'open_id标识',
  `enable_flag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否有效',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `trading_order_no` (`trading_order_no`) COMMENT '支付订单号',
  KEY `index_order_id` (`product_order_no`) USING BTREE,
  KEY `index_tpptrs` (`trading_channel`) USING BTREE,
  KEY `trading_state` (`trading_state`) USING BTREE,
  KEY `enable_flag` (`enable_flag`) USING BTREE,
  KEY `created` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='交易订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log` (
  `branch_id` bigint NOT NULL COMMENT 'branch transaction id',
  `xid` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'global transaction id',
  `context` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'undo_log context,such as serialization',
  `rollback_info` longblob NOT NULL COMMENT 'rollback info',
  `log_status` int NOT NULL COMMENT '0:normal status,1:defense status',
  `log_created` datetime(6) NOT NULL COMMENT 'create datetime',
  `log_modified` datetime(6) NOT NULL COMMENT 'modify datetime',
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='AT transaction mode undo table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jzo2o-trade'
--

--
-- Dumping routines for database 'jzo2o-trade'
--


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!50606 SET GLOBAL INNODB_STATS_AUTO_RECALC=@OLD_INNODB_STATS_AUTO_RECALC */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-08 17:03:29
