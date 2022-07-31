# Mybatis-Plus多数据

> 适用于多种场景：纯粹多库、 读写分离、 一主多从、 混合模式等

场景说明：

我们创建两个库，分别为：`mybatis_plus`（以前的库不动）与`mybatis_plus_1`（新建），将mybatis_plus库的`product`表移动到mybatis_plus_1库，这样每个库一张表，通过一个测试用例分别获取用户数据与商品数据，如果获取到说明多库模拟成功



## 1.创建数据库及表

- **创建数据库`mybatis_plus_1`和表`product**

  ```sql
  CREATE DATABASE `mybatis_plus_1` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
  use `mybatis_plus_1`; 
  CREATE TABLE product ( 
      id BIGINT(20) NOT NULL COMMENT '主键ID', 
      name VARCHAR(30) NULL DEFAULT NULL COMMENT '商品名称', 
      price INT(11) DEFAULT 0 COMMENT '价格', 
      version INT(11) DEFAULT 0 COMMENT '乐观锁版本号', 
      PRIMARY KEY (id) 
  );
  ```

- **添加测试数据**

  ```sql
  INSERT INTO product (id, NAME, price) VALUES (1, '外星人笔记本', 100);
  ```

- **删除`mybatis_plus`库中的`product`表**

  ```sql
  use mybatis_plus; 
  DROP TABLE IF EXISTS product;
  ```



## 2.新建工程引入依赖

> **自行新建一个Spring Boot工程并选择MySQL驱动及Lombok依赖**

**引入MyBaits-Plus的依赖及多数据源的依赖**

```xml
<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-boot-starter</artifactId>
    <version>3.5.1</version>
</dependency>

<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>dynamic-datasource-spring-boot-starter</artifactId>
    <version>3.5.0</version>
</dependency>
```



## 3.编写配置文件

```yml
spring:
  # 配置数据源信息
  datasource:
    dynamic:
      # 设置默认的数据源或者数据源组,默认值即为master
      primary: master
      # 严格匹配数据源,默认false.true未匹配到指定数据源时抛异常,false使用默认数据源
      strict: false
      datasource:
        master:
          url: jdbc:mysql://localhost:3306/mybatis_plus?characterEncoding=utf-8&useSSL=false
          driver-class-name: com.mysql.cj.jdbc.Driver
          username: root
          password: 132537
        slave_1:
          url: jdbc:mysql://localhost:3306/mybatis_plus_1?characterEncoding=utf-8&useSSL=false
          driver-class-name: com.mysql.cj.jdbc.Driver
          username: root
          password: 132537
```



## 4.创建实体类

- 新建一个`User`实体类（如果数据库表名有t_前缀记得配置）

  ```java
  @Data
  public class User {
      private Long id;
      private String name;
      private Integer age;
      private String email;
  }
  ```

- 新建一个实体类`Product`

  ```java
  @Data
  public class Product {
      private Long id;
      private String name;
      private Integer price;
      private Integer version;
  }
  ```



## 5.创建Mapper及Service

- 新建接口`UserMapper`

  ```java
  public interface UserMapper extends BaseMapper<User> {}
  ```

- 新建接口`ProductMapper`

  ```java
  public interface ProductMapper extends BaseMapper<Product> {}
  ```

- 新建Service接口`UserService`指定操作的数据源

  ```java
  @DS("master") //指定操作的数据源，master为user表
  public interface UserService extends IService<User> {}
  ```

- 新建Service接口`ProductService`指定操作的数据源

  ```java
  @DS("slave_1")
  public interface ProductService extends IService<Product> {}
  ```

- 自行建立Service的实现类

  ```java
  ...
  ```



## 6.编写测试方法

> **记得在启动类中添加注解`@MapperScan()`**

```java
class TestDatasourceApplicationTests {
	@Resource
	UserService userService;

	@Resource
	ProductService productService;

	@Test
	void contextLoads() {
		User user = userService.getById(1L);
		Product product = productService.getById(1L);
		System.out.println("User = " + user);
		System.out.println("Product = " + product);
	}

}
```

![image-20220522113049945](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220522113049945.png)
