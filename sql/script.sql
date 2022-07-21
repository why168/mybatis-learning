create schema test collate utf8_general_ci;

create table if not exists test.t_dept
(
    did       int auto_increment
        primary key,
    dept_name varchar(64) null
);

create table if not exists test.t_emp
(
    eid      int auto_increment
        primary key,
    emp_name varchar(16) null,
    age      int         null,
    sex      char        null,
    email    varchar(32) null,
    did      int         null
);

create table if not exists test.t_user
(
    id       int auto_increment
        primary key,
    username varchar(255) null,
    password varchar(255) null,
    age      int          null,
    sex      varchar(255) null,
    email    varchar(255) null
);

create table if not exists test.user
(
    id   int auto_increment
        primary key,
    name varchar(32) default '' not null,
    age  smallint    default 1  null
)
    charset = utf8mb4;

