# mybatis-learning

>
> myBatis 个人学习笔记 温故而知新<br/><br/>
> doc:https://mybatis.org/mybatis-3/zh/getting-started.html <br/>
> idea插件：MyBatisX
>
>

## Build

* JDK

```shell
openjdk version "17.0.3" 2022-04-19 LTS
OpenJDK Runtime Environment Zulu17.34+19-CA (build 17.0.3+7-LTS)
OpenJDK 64-Bit Server VM Zulu17.34+19-CA (build 17.0.3+7-LTS, mixed mode, sharing)
```

* maven

```shell
Apache Maven 3.8.6 (84538c9988a25aec085021c365c560670ad80f63)
Maven home: /Users/edwin/opt/maven/apache-maven-3.8.6
Java version: 1.8.0_332, vendor: Azul Systems, Inc., runtime: /Users/edwin/opt/jdk/zulu8.62.0.19-ca-jdk8.0.332-macosx_aarch64/zulu-8.jdk/Contents/Home/jre
Default locale: zh_CN, platform encoding: UTF-8
OS name: "mac os x", version: "12.4", arch: "aarch64", family: "mac"
```

* library

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

#### MyBatis标签配置的的顺序：

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
