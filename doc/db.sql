CREATE TABLE `tbl_admin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ACCOUNT` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `USER_NAME` varchar(50) NOT NULL,
  `MOBILE` varchar(50) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `IS_DELETE` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User table';

CREATE TABLE `tbl_resource` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) NOT NULL,
  `DESCRIPTION` varchar(500) DEFAULT NULL,
  `ACCESS_ENTRY` varchar(500) DEFAULT NULL,
  `RESOURCE_TYPE` int(11) NOT NULL,
  `PARENT_ID` int(11) DEFAULT NULL,
  `IS_DELETE` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_resource_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RESOURCE_ID` int(11) NOT NULL,
  `ROLE_ID` int(11) NOT NULL,
  `ASSIGN_TIME` datetime NOT NULL,
  `ASSIGN_ADMIN_ID` int(11) NOT NULL,
  `IS_DELETE` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(45) NOT NULL,
  `DESCRIPTION` varchar(45) DEFAULT NULL,
  `PARENT_ID` int(11) DEFAULT NULL,
  `IS_DELETE` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_role_admin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ADMIN_ID` int(11) NOT NULL,
  `ROLE_ID` int(11) NOT NULL,
  `AUTH_TIME` datetime NOT NULL,
  `AUTH_ADMIN_ID` int(11) NOT NULL,
  `IS_DELETE` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_admin_of_role` AS select distinct `_admin`.`ID` AS `ID`,`_admin`.`ACCOUNT` AS `ACCOUNT`,`_admin`.`PASSWORD` AS `PASSWORD`,`_admin`.`USER_NAME` AS `USER_NAME`,`_admin`.`MOBILE` AS `MOBILE`,`_admin`.`EMAIL` AS `EMAIL`,`_admin`.`IS_DELETE` AS `IS_DELETE` from (`vw_available_admin` `_admin` left join `vw_available_role_admin` `_roleadmin` on((`_admin`.`ID` = `_roleadmin`.`ADMIN_ID`)));


CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_available_admin` AS select `tbl_admin`.`ID` AS `ID`,`tbl_admin`.`ACCOUNT` AS `ACCOUNT`,`tbl_admin`.`PASSWORD` AS `PASSWORD`,`tbl_admin`.`USER_NAME` AS `USER_NAME`,`tbl_admin`.`MOBILE` AS `MOBILE`,`tbl_admin`.`EMAIL` AS `EMAIL`,`tbl_admin`.`IS_DELETE` AS `IS_DELETE` from `tbl_admin` where (`tbl_admin`.`IS_DELETE` = 0);


CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_available_resource` AS select `tbl_resource`.`ID` AS `ID`,`tbl_resource`.`NAME` AS `NAME`,`tbl_resource`.`DESCRIPTION` AS `DESCRIPTION`,`tbl_resource`.`ACCESS_ENTRY` AS `ACCESS_ENTRY`,`tbl_resource`.`RESOURCE_TYPE` AS `RESOURCE_TYPE`,`tbl_resource`.`PARENT_ID` AS `PARENT_ID`,`tbl_resource`.`IS_DELETE` AS `IS_DELETE` from `tbl_resource` where (`tbl_resource`.`IS_DELETE` = 0);


CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_available_resource_role` AS select `tbl_resource_role`.`ID` AS `ID`,`tbl_resource_role`.`RESOURCE_ID` AS `RESOURCE_ID`,`tbl_resource_role`.`ROLE_ID` AS `ROLE_ID`,`tbl_resource_role`.`ASSIGN_TIME` AS `ASSIGN_TIME`,`tbl_resource_role`.`ASSIGN_ADMIN_ID` AS `ASSIGN_ADMIN_ID`,`tbl_resource_role`.`IS_DELETE` AS `IS_DELETE` from `tbl_resource_role` where (`tbl_resource_role`.`IS_DELETE` = 0);


CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_available_role` AS select `tbl_role`.`ID` AS `ID`,`tbl_role`.`NAME` AS `NAME`,`tbl_role`.`DESCRIPTION` AS `DESCRIPTION`,`tbl_role`.`PARENT_ID` AS `PARENT_ID`,`tbl_role`.`IS_DELETE` AS `IS_DELETE` from `tbl_role` where (`tbl_role`.`IS_DELETE` = 0);


CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_available_role_admin` AS select `tbl_role_admin`.`ID` AS `ID`,`tbl_role_admin`.`ADMIN_ID` AS `ADMIN_ID`,`tbl_role_admin`.`ROLE_ID` AS `ROLE_ID`,`tbl_role_admin`.`AUTH_TIME` AS `AUTH_TIME`,`tbl_role_admin`.`AUTH_ADMIN_ID` AS `AUTH_ADMIN_ID`,`tbl_role_admin`.`IS_DELETE` AS `IS_DELETE` from `tbl_role_admin` where (`tbl_role_admin`.`IS_DELETE` = 0);


CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_resource_of_admin` AS select distinct `_resource`.`ID` AS `ID`,`_resource`.`NAME` AS `NAME`,`_resource`.`DESCRIPTION` AS `DESCRIPTION`,`_resource`.`ACCESS_ENTRY` AS `ACCESS_ENTRY`,`_resource`.`RESOURCE_TYPE` AS `RESOURCE_TYPE`,`_resource`.`PARENT_ID` AS `PARENT_ID`,`_resource`.`IS_DELETE` AS `IS_DELETE` from ((`vw_available_resource` `_resource` left join `vw_available_resource_role` `_resourcerole` on((`_resource`.`ID` = `_resourcerole`.`RESOURCE_ID`))) left join `vw_available_role_admin` `_roleadmin` on((`_resourcerole`.`ROLE_ID` = `_roleadmin`.`ROLE_ID`)));


CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_role_of_admin` AS select `_role`.`ID` AS `ID`,`_role`.`NAME` AS `NAME`,`_role`.`DESCRIPTION` AS `DESCRIPTION`,`_role`.`PARENT_ID` AS `PARENT_ID`,`_role`.`IS_DELETE` AS `IS_DELETE` from ((`vw_available_admin` `_admin` left join `vw_available_role_admin` `_roleadmin` on((`_roleadmin`.`ADMIN_ID` = `_admin`.`ID`))) left join `vw_available_role` `_role` on((`_roleadmin`.`ROLE_ID` = `_role`.`ID`)));


CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_role_of_resource` AS select `_role`.`ID` AS `ID`,`_role`.`NAME` AS `NAME`,`_role`.`DESCRIPTION` AS `DESCRIPTION`,`_role`.`PARENT_ID` AS `PARENT_ID`,`_role`.`IS_DELETE` AS `IS_DELETE` from (`vw_available_role` `_role` left join `vw_available_resource_role` `_resourcerole` on((`_role`.`ID` = `_resourcerole`.`ROLE_ID`)));

