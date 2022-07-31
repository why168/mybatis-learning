create schema test collate utf8_general_ci;
user test;

CREATE TABLE `t_dept`
(
    `did`       int(11) NOT NULL AUTO_INCREMENT,
    `dept_name` varchar(64) DEFAULT NULL,
    PRIMARY KEY (`did`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `t_emp`
(
    `eid`      int(11) NOT NULL AUTO_INCREMENT,
    `emp_name` varchar(16) DEFAULT NULL,
    `age`      int(11) DEFAULT NULL,
    `sex`      char(1)     DEFAULT NULL,
    `email`    varchar(32) DEFAULT NULL,
    `did`      int(11) DEFAULT NULL,
    PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

CREATE TABLE `t_user`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT,
    `username` varchar(255) DEFAULT NULL,
    `password` varchar(255) DEFAULT NULL,
    `age`      int(11) DEFAULT NULL,
    `sex`      varchar(255) DEFAULT NULL,
    `email`    varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

CREATE TABLE `user`
(
    `id`   bigint(20) NOT NULL AUTO_INCREMENT,
    `name` varchar(32) NOT NULL DEFAULT '',
    `age`  smallint(6) DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user_plus`
(
    `uid`        bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_name`  varchar(30) DEFAULT NULL COMMENT '姓名',
    `age`        int(11) DEFAULT NULL COMMENT '年龄',
    `email`      varchar(50) DEFAULT NULL COMMENT '邮箱',
    `is_deleted` int(11) DEFAULT '0' COMMENT '0:未删除',
    PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `product_plus`
(
    `id`      bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `NAME`    varchar(30) DEFAULT NULL COMMENT '商品名称',
    `price`   int(11) DEFAULT '0' COMMENT '价格',
    `VERSION` int(11) DEFAULT '0' COMMENT '乐观锁版本号',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



INSERT INTO product_plus (id, NAME, price)
VALUES (1, '外星人笔记本', 100);