# mybatis-learning

>
> MyBatis 个人学习笔记 温故而知新<br/><br/>
> doc:https://mybatis.org/mybatis-3/zh/getting-started.html <br/>
> idea插件：MyBatisX
>

### Mybatis
1. <a target="_blank" href="https://github.com/why168/mybatis-learning/blob/main/01Mybatis实战技巧.md">01Mybatis实战技巧</a>
2. <a target="_blank" href="https://github.com/why168/mybatis-learning/blob/main/02MyBatis缓存技术.md">02MyBatis缓存技术</a>
3. <a target="_blank" href="https://github.com/why168/mybatis-learning/blob/main/03MyBatis逆向工程.md">03MyBatis逆向工程</a>
4. <a target="_blank" href="https://github.com/why168/mybatis-learning/blob/main/04Mybatis分页插件.md">04MyBatis分页插件</a>

### Mybatis-Plus
1. <a target="_blank" href="https://github.com/why168/mybatis-learning/blob/main/mybatis_plus_doc/01Mybatis-Plus增删改查.md">01Mybatis-Plus增删改查</a>
2. <a target="_blank" href="https://github.com/why168/mybatis-learning/blob/main/mybatis_plus_doc/02Mybatis-Plus常用注解.md">02Mybatis-Plus常用注解</a>
3. <a target="_blank" href="https://github.com/why168/mybatis-learning/blob/main/mybatis_plus_doc/03Mybatis-Plus调节构造器.md">03Mybatis-Plus调节构造器</a>
4. <a target="_blank" href="https://github.com/why168/mybatis-learning/blob/main/mybatis_plus_doc/04Mybatis-Plus常用插件.md">04Mybatis-Plus常用插件</a>
4. <a target="_blank" href="https://github.com/why168/mybatis-learning/blob/main/mybatis_plus_doc/05Mybatis-Plus通用枚举.md">05Mybatis-Plus通用枚举</a>
4. <a target="_blank" href="https://github.com/why168/mybatis-learning/blob/main/mybatis_plus_doc/06Mybatis-Plus多数据.md">06Mybatis-Plus多数据</a>


## Mybatis简介

#### MyBatis历史

1. MyBatis最初是Apache的一个开源项目iBatis, 2010年6月这个项目由Apache Software Foundation迁移到了Google Code。随着开发团队转投Google
  Code旗下，iBatis3.x正式更名为MyBatis。代码于2013年11月迁移到Github
2. `iBatis`一词来源于`internet`和`abatis`的组合，是一个基于Java的持久层框架。iBatis提供的持久层框架包括SQL Maps和Data Access Objects（DAO）

#### MyBatis特性

1. MyBatis 是支持定制化 SQL、存储过程以及高级映射的优秀的持久层框架
2. MyBatis 避免了几乎所有的 JDBC 代码和手动设置参数以及获取结果集
3. MyBatis可以使用简单的XML或注解用于配置和原始映射，将接口和Java的POJO（Plain Old Java Objects，普通的Java对象）映射成数据库中的记录
4. MyBatis 是一个 半自动的ORM（Object Relation Mapping）框架

#### 各类持久化层技术对比

1. JDBC

- SQL 夹杂在Java代码中耦合度高，导致硬编码内伤
- 维护不易且实际开发需求中 SQL 有变化，频繁修改的情况多见
- 代码冗长，开发效率低

2. Hibernate 和 JPA

- 操作简便，开发效率高
- 程序中的长难复杂 SQL 需要绕过框架
- 内部自动生产的 SQL，不容易做特殊优化
- 基于全映射的全自动框架，大量字段的 POJO 进行部分映射时比较困难。
- 反射操作太多，导致数据库性能下降

3. MyBatis

- 轻量级，性能出色
- SQL 和 Java 编码分开，功能边界清晰。Java代码专注业务、SQL语句专注数据
- 开发效率稍逊于HIbernate，但是完全能够接受

#### 开发环境

- IDE：IntelliJ IDEA 2021.3.3 (Ultimate Edition)
- 构建工具：maven 3.8.6
- MySQL版本：MySQL 5.7.37, for osx10.17 (x86_64)
- MyBatis版本：MyBatis 3.5.10
- JDK 1.8

```shell
openjdk version "1.8.0_332"
OpenJDK Runtime Environment (Zulu 8.62.0.19-CA-macos-aarch64) (build 1.8.0_332-b09)
OpenJDK 64-Bit Server VM (Zulu 8.62.0.19-CA-macos-aarch64) (build 25.332-b09, mixed mode)
```

* maven

```shell
Apache Maven 3.8.6 (84538c9988a25aec085021c365c560670ad80f63)
Maven home: /Users/edwin/opt/maven/apache-maven-3.8.6
Java version: 1.8.0_332, vendor: Azul Systems, Inc., runtime: /Users/edwin/opt/jdk/zulu8.62.0.19-ca-jdk8.0.332-macosx_aarch64/zulu-8.jdk/Contents/Home/jre
Default locale: zh_CN, platform encoding: UTF-8
OS name: "mac os x", version: "12.4", arch: "aarch64", family: "mac"
```

*

```shell
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.5.10</version>
</dependency>
<dependency>
    <groupId>org.mybatis.caches</groupId>
    <artifactId>mybatis-ehcache</artifactId>
    <version>1.2.2</version>
</dependency>
```

##### MyBatis核心标签配置的的顺序：

mybatis-mapper.xml

1. `<properties> ... </properties>`
2. `<settings> ... </settings>`
3. `<typeAliases> ... </typeAliases>`
4. `<typeHandlers> ... </typeHandlers>`
5. `<objectFactory> ... </objectFactory>`
6. `<objectWrapperFactory> ... </objectWrapperFactory>`
7. `<reflectorFactory> ... </reflectorFactory>`
8. `<plugins> ... </plugins>`
9. `<environments> ... </environments>`
10. `<databaseIdProvider> ... </databaseIdProvider>`
11. `<mappers> ... </mappers>`
