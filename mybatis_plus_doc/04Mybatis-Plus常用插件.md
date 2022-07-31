# Mybatis-Plus常用插件

## 1.分页插件

> MyBatis Plus自带分页插件，只要简单的配置即可实现分页功能

- **添加配置类`MyBatisPlusConfig`**

  ```java
  @Configuration
  @MapperScan("com.atguigu.mybatisplus.mapper")
  public class MyBatisPlusConfig {
      @Bean
      public MybatisPlusInterceptor mybatisPlusInterceptor(){
          MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
          //添加分页插件
          interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));
          return interceptor;
      }
  }
  ```

- **编写测试方法**

  ```java
  @Test
  public void testPage(){
      //new Page()中的两个参数分别是当前页码，每页显示数量
      Page<User> page = userMapper.selectPage(new Page<>(1, 2), null);
      List<User> users = page.getRecords();
      users.forEach(System.out::println);
  }
  ```



## 2.自定义分页

> 上面调用的是MyBatis-Plus提供的带有分页的方法，那么我们自己定义的方法如何实现分页呢？

- **在`UserMapper`接口中定义一个方法**

  ```java
  /**
    * 根据年龄查询用户列表，分页显示 
    * @param page 分页对象,xml中可以从里面进行取值,传递参数 Page 即自动分页,必须放在第一位 
    * @param age 年龄 
    * @return 
    */
  Page<User> selectPageVo(@Param("page") Page<User> page,@Param("age") Integer age);
  ```

- **在`UserMapper.xml`中编写SQL实现该方法**

  ```xml
  <select id="selectPageVo" resultType="User">
      select id,username as name,age,email from t_user where age > #{age}
  </select>
  ```

- **编写测试方法**

  ```java
  @Test
  public void testPageVo(){
      Page<User> page = userMapper.selectPageVo(new Page<User>(1,2), 20);
      List<User> users = page.getRecords();
      users.forEach(System.out::println);
  }
  ```



## 3.乐观锁

> **作用：当要更新一条记录的时候，希望这条记录没有被别人更新**

乐观锁的实现方式：

- 取出记录时，获取当前 version
- 更新时，带上这个 version
- 执行更新时， set version = newVersion where version = oldVersion
- 如果 version 不对，就更新失败



### 3.1	场景

---

- 一件商品，成本价是80元，售价是100元。老板先是通知小李，说你去把商品价格增加50元。小李正在玩游戏，耽搁了一个小时。正好一个小时后，老板觉得商品价格增加到150元，价格太高，可能会影响销量。又通知小王，你把商品价格降低30元。
- 此时，小李和小王同时操作商品后台系统。小李操作的时候，系统先取出商品价格100元；小王也在操作，取出的商品价格也是100元。小李将价格加了50元，并将100+50=150元存入了数据库；小王将商品减了30元，并将100-30=70元存入了数据库。是的，如果没有锁，小李的操作就完全被小王的覆盖了。
- 现在商品价格是70元，比成本价低10元。几分钟后，这个商品很快出售了1千多件商品，老板亏1万多。



### 3.2	乐观锁与悲观锁

---

- 上面的故事，如果是乐观锁，小王保存价格前，会检查下价格是否被人修改过了。如果被修改过了，则重新取出的被修改后的价格，150元，这样他会将120元存入数据库。
- 如果是悲观锁，小李取出数据后，小王只能等小李操作完之后，才能对价格进行操作，也会保证最终的价格是120元。



### 3.3	模拟修改冲突

---

- **数据库中增加商品表**

  ```sql
  CREATE TABLE t_product ( 
      id BIGINT(20) NOT NULL COMMENT '主键ID', 
      NAME VARCHAR(30) NULL DEFAULT NULL COMMENT '商品名称', 
      price INT(11) DEFAULT 0 COMMENT '价格', 
      VERSION INT(11) DEFAULT 0 COMMENT '乐观锁版本号', 
      PRIMARY KEY (id) 
  );
  ```

- **添加一条数据**

  ```sql
  INSERT INTO t_product (id, NAME, price) VALUES (1, '外星人笔记本', 100);
  ```

- **添加一个实体类`Product`**

  ```java
  @Data
  public class Product {
      private Long id;
      private String name;
      private Integer price;
      private Integer version;
  }
  ```

- **添加一个Mapper接口`ProductMapper`**

  ```java
  public interface ProductMapper extends BaseMapper<Product> {}
  ```

- **测试方法**

  ```java
  @Test
  public void testProduct01(){
      //1.小李获取商品价格
      Product productLi = productMapper.selectById(1);
      System.out.println("小李获取的商品价格为：" + productLi.getPrice());
  
      //2.小王获取商品价格
      Product productWang = productMapper.selectById(1);
      System.out.println("小李获取的商品价格为：" + productWang.getPrice());
  
      //3.小李修改商品价格+50
      productLi.setPrice(productLi.getPrice()+50);
      productMapper.updateById(productLi);
  
      //4.小王修改商品价格-30
      productWang.setPrice(productWang.getPrice()-30);
      productMapper.updateById(productWang);
  
      //5.老板查询商品价格
      Product productBoss = productMapper.selectById(1);
      System.out.println("老板获取的商品价格为：" + productBoss.getPrice());
  }
  ```

- **执行结果**

  ![image-20220521225803162](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220521225803162.png)



### 3.4	乐观锁解决问题

---

- **实体类`version`字段添加注解`@Version`**

  ```java
  @Data
  public class Product {
      private Long id;
      private String name;
      private Integer price;
      @Version
      private Integer version;
  }
  ```

- **添加乐观锁插件配置**

  ```java
  @Bean
  public MybatisPlusInterceptor mybatisPlusInterceptor(){
      MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
      //添加分页插件
      interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));
      //添加乐观锁插件
      interceptor.addInnerInterceptor(new OptimisticLockerInnerInterceptor());
      return interceptor;
  }
  ```

- **再次执行测试方法**

  > 小李查询商品信息：
  >
  > ​	SELECT id,name,price,version FROM t_product WHERE id=?
  >
  > 小王查询商品信息：
  >
  > ​	SELECT id,name,price,version FROM t_product WHERE id=?
  >
  > 小李修改商品价格，自动将version+1
  >
  > ​	UPDATE t_product SET name=?, price=?, version=? WHERE id=? AND version=?
  >
  > ​	Parameters: 外星人笔记本(String), 150(Integer), 1(Integer), 1(Long), 0(Integer)
  >
  > 小王修改商品价格，此时version已更新，条件不成立，修改失败
  >
  > ​	UPDATE t_product SET name=?, price=?, version=? WHERE id=? AND version=?
  >
  > ​	Parameters: 外星人笔记本(String), 70(Integer), 1(Integer), 1(Long), 0(Integer)
  >
  > 最终，小王修改失败，查询价格：150
  >
  > ​	SELECT id,name,price,version FROM t_product WHERE id=?

- **优化执行流程**

  ```java
  @Test
  public void testProduct01(){
      //1.小李获取商品价格
      Product productLi = productMapper.selectById(1);
      System.out.println("小李获取的商品价格为：" + productLi.getPrice());
  
      //2.小王获取商品价格
      Product productWang = productMapper.selectById(1);
      System.out.println("小李获取的商品价格为：" + productWang.getPrice());
  
      //3.小李修改商品价格+50
      productLi.setPrice(productLi.getPrice()+50);
      productMapper.updateById(productLi);
  
      //4.小王修改商品价格-30
      productWang.setPrice(productWang.getPrice()-30);
      int result = productMapper.updateById(productWang);
      if(result == 0){
          //操作失败，重试
          Product productNew = productMapper.selectById(1);
          productNew.setPrice(productNew.getPrice()-30);
          productMapper.updateById(productNew);
      }
  
      //5.老板查询商品价格
      Product productBoss = productMapper.selectById(1);
      System.out.println("老板获取的商品价格为：" + productBoss.getPrice());
  }
  ```

  ![image-20220521230448577](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220521230448577.png)
