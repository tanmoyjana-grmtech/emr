use sc_component;


CREATE TABLE `ctMaster`
(
  `uuid` char
(36) NOT NULL,
  `tag` varchar
(255) DEFAULT NULL,
  `name` varchar
(255) DEFAULT NULL,
  `recordChangedByUuid` CHAR
(36) NOT NULL,
  `recordChangedFromIPAddress` varchar
(20) NOT NULL,
  PRIMARY KEY
(`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
WITH SYSTEM VERSIONING;


CREATE TABLE `ctAllowedToAccessByEachUserRole`
(
  `uuid` char
(36) NOT NULL ,
  `roleUuid` char
(36) NOT NULL,
  `componentUuid` char
(36) NOT NULL,
  `msvlImportance` float NOT NULL COMMENT 'higher comes up on page',
  `csvlImportance` float NOT NULL
  `recordChangedByUuid` char
(36) NOT NULL,
  `recordChangedFromIPAddress` varchar
(255) DEFAULT NULL,
  PRIMARY KEY
(`uuid`)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1
WITH SYSTEM VERSIONING;

CREATE TABLE `search`
(
  `uuid` char
(36) NOT NULL,
  `componentUuid` char
(36) DEFAULT NULL,
  `searchText` varchar
(255) DEFAULT NULL,
  `action` varchar
(255) NOT NULL,
  `recordChangedByUuid` char
(36) NOT NULL,
  `recordChangedFromIPAddress` varchar
(20) NOT NULL
  PRIMARY KEY
(`uuid`)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1
WITH SYSTEM VERSIONING;


