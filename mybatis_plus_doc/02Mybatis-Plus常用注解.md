# Mybatis-Plus常用注解

> MyBatis-Plus提供的注解可以帮我们解决一些数据库与实体之间相互映射的问题。



## 1.@TableName

> 经过以上的测试，在使用MyBatis-Plus实现基本的CRUD时，我们并没有指定要操作的表，只是在Mapper接口继承BaseMapper时，设置了泛型User，而操作的表为user表，由此得出结论，MyBatis-Plus在确定操作的表时，由BaseMapper的泛型决定，即实体类型决定，且默认操作的表名和实体类型的类名一致。



### 1.1	引出问题

---

> **若实体类类型的类名和要操作的表的表名不一致，会出现什么问题？**

- 我们将表`user`更名为`t_user`，测试查询功能

  ![image-20220520093844842](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220520093844842.png)

- 程序抛出异常，**Table 'mybatis_plus.user' doesn't exist**，因为现在的表名为`t_user`，而默认操作的表名和实体类型的类名一致，即`user`表

  ![image-20220520094126411](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220520094126411.png)



### 1.2	解决问题

---



#### a、使用注解解决问题

> **在实体类类型上添加`@TableName("t_user")`，标识实体类对应的表，即可成功执行SQL语句**

```java
@Data
@TableName("t_user")
public class User {
    private Long id;
    private String name;
    private Integer age;
    private String email;
}
```



#### b、使用全局配置解决问题

> **在开发的过程中，我们经常遇到以上的问题，即实体类所对应的表都有固定的前缀，例如 `t_` 或 `tbl_` 此时，可以使用MyBatis-Plus提供的全局配置，为实体类所对应的表名设置默认的前缀，那么就不需要在每个实体类上通过@TableName标识实体类对应的表**

```yml
mybatis-plus:
  global-config:
    db-config:
      # 设置实体类所对应的表的统一前缀
      table-prefix: t_
```





## 2.@TableId

> **经过以上的测试，MyBatis-Plus在实现CRUD时，会默认将id作为主键列，并在插入数据时，默认基于雪花算法的策略生成id**



### 2.1	引出问题

---

> **若实体类和表中表示主键的不是id，而是其他字段，例如uid，MyBatis-Plus会自动识别uid为主键列吗？**

- 我们实体类中的属性`id`改为`uid`，将表中的字段`id`也改为`uid`，测试添加功能

  ![image-20220520100939157](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220520100939157.png)

  ![image-20220520100715109](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220520100715109.png)

- 程序抛出异常，**Field 'uid' doesn't have a default value**，说明MyBatis-Plus没有将`uid`作为主键赋值

  ![image-20220520101317761](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220520101317761.png)



### 2.2	解决问题

---

> **在实体类中uid属性上通过`@TableId`将其标识为主键，即可成功执行SQL语句**

```java
@Date
public class User {
    @TableId
    private Long uid;
    private String name;
    private Integer age;
    private String email;
}
```



### 2.3	@TableId的value属性

---

> 若实体类中主键对应的属性为id，而表中表示主键的字段为uid，此时若只在属性id上添加注解@TableId，则抛出异常**Unknown column 'id' in 'field list'**，即MyBatis-Plus仍然会将id作为表的主键操作，而表中表示主键的是字段uid此时需要通过@TableId注解的value属性，指定表中的主键字段，`@TableId("uid")`或`@TableId(value="uid")`

![image-20220520103030977](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220520103030977.png)



### 2.4	@TableId的type属性

---

> **type属性用来定义主键策略：默认雪花算法**

**常用的主键策略：**

|            值            |                             描述                             |
| :----------------------: | :----------------------------------------------------------: |
| IdType.ASSIGN_ID（默认） |   基于雪花算法的策略生成数据id，与数据库id是否设置自增无关   |
|       IdType.AUTO        | 使用数据库的自增策略，注意，该类型请确保数据库设置了id自增， |



**配置全局主键策略：**

```yml
#MyBatis-Plus相关配置
mybatis-plus:
  configuration:
    #配置日志
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
  global-config:
    db-config:
      #配置mp的主键策略为自增
      id-type: auto
      # 设置实体类所对应的表的统一前缀
      table-prefix: t_
```



## 3.@TbaleField

> 经过以上的测试，我们可以发现，MyBatis-Plus在执行SQL语句时，要保证实体类中的属性名和表中的字段名一致
>
> 如果实体类中的属性名和字段名不一致的情况，会出现什么问题呢？



### 3.1	情况一

---

若实体类中的属性使用的是驼峰命名风格，而表中的字段使用的是下划线命名风格

例如实体类属性`userName`，表中字段`user_name`

此时MyBatis-Plus会自动将下划线命名风格转化为驼峰命名风格

相当于在MyBatis中配置



### 3.2	情况二

---

> 若实体类中的属性和表中的字段不满足情况1
>
> 例如实体类属性`name`，表中字段`username`
>
> 此时需要在实体类属性上使用`@TableField("username")`设置属性所对应的字段名

```java
public class User {
    @TableId("uid")
    private Long id;
    @TableField("username")
    private String name;
    private Integer age;
    private String email;
}
```



## 4.@TableLogic



### 4.1	逻辑删除

---

> 物理删除：真实删除，将对应数据从数据库中删除，之后查询不到此条被删除的数据
>
> 逻辑删除：假删除，将对应数据中代表是否被删除字段的状态修改为“被删除状态”，之后在数据库中仍旧能看到此条数据记录
>
> 使用场景：可以进行数据恢复



### 4.2	实现逻辑删除

---

- **数据库中创建逻辑删除状态列，设置默认值为0**

  ![image-20220520134529809](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220520134529809.png)

- **实体类中添加逻辑删除属性**

  ![image-20220520134636112](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220520134636112.png)

- **测试删除功能，真正执行的是修改**

  ```java
  public void testDeleteById(){
      int result = userMapper.deleteById(1527472864163348482L);
      System.out.println(result > 0 ? "删除成功！" : "删除失败！");
      System.out.println("受影响的行数为：" + result);
  }
  ```

  ![image-20220520135637388](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220520135637388.png)

- **此时执行查询方法，查询的结果为自动添加条件`is_deleted=0`**

  ![image-20220520140036445](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220520140036445.png)