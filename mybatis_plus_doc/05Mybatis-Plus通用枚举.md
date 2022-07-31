# Mybatis-Plus通用枚举

> 表中的有些字段值是固定的，例如性别（男或女），此时我们可以使用MyBatis-Plus的通用枚举来实现

- **数据库表添加字段`sex`**

  ![image-20220521231317777](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220521231317777.png)

- **创建通用枚举类型**

  ```java
  @Getter
  public enum SexEnum {
      MALE(1, "男"),
      FEMALE(2, "女");
  
      @EnumValue //将注解所标识的属性的值存储到数据库中
      private int sex;
      private String sexName;
  
      SexEnum(Integer sex, String sexName) {
          this.sex = sex;
          this.sexName = sexName;
      }
  }
  ```

- **User实体类中添加属性sex**

  ```java
  public class User {
      private Long id;
      @TableField("username")
      private String name;
      private Integer age;
      private String email;
  
      @TableLogic
      private int isDeleted;  //逻辑删除
  
      private SexEnum sex;
  }
  ```

- **配置扫描通用枚举**

  ```yml
  #MyBatis-Plus相关配置
  mybatis-plus:
    #指定mapper文件所在的地址
    mapper-locations: classpath:mapper/*.xml
    configuration:
      #配置日志
      log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
    global-config:
      banner: off
      db-config:
        #配置mp的主键策略为自增
        id-type: auto
        # 设置实体类所对应的表的统一前缀
        table-prefix: t_
    #配置类型别名所对应的包
    type-aliases-package: com.atguigu.mybatisplus.pojo
    # 扫描通用枚举的包
    type-enums-package: com.atguigu.mybatisplus.enums
  ```

- **执行测试方法**

  ```java
  @Test
  public void test(){
      User user = new User();
      user.setName("admin");
      user.setAge(33);
      user.setSex(SexEnum.MALE);
      int result = userMapper.insert(user);
      System.out.println("result:"+result);
  }
  ```
