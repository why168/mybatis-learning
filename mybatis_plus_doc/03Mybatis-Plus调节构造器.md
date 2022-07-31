# Mybatis-Plus调节构造器

## 1.Wrapper介绍

![image-20220521092812125](https://image-bed-vz.oss-cn-hangzhou.aliyuncs.com/MyBatis-Plus/image-20220521092812125.png)

- `Wrapper` ： 条件构造抽象类，最顶端父类

    - `AbstractWrapper `： 用于查询条件封装，生成 sql 的 where 条件

        - `QueryWrapper `： 查询条件封装

        - `UpdateWrapper `： Update 条件封装

        - `AbstractLambdaWrapper `： 使用Lambda 语法

            - `LambdaQueryWrapper `：用于Lambda语法使用的查询Wrapper

            - `LambdaUpdateWrapper `： Lambda 更新封装Wrapper



## 2.QueryWrapper

- **组装查询条件**

  > **执行SQL：**SELECT uid AS id,username AS name,age,email,is_deleted FROM t_user WHERE is_deleted=0 AND (username LIKE ? AND age BETWEEN ? AND ? AND email IS NOT NULL)

  ```java
  public void test01(){
      //查询用户名包含a，年龄在20到30之间，邮箱信息不为null的用户信息
      QueryWrapper<User> queryWrapper = new QueryWrapper<>();
      queryWrapper.like("username","a").between("age",20,30).isNotNull("email");
      List<User> users = userMapper.selectList(queryWrapper);
      users.forEach(System.out::println);
  }
  ```

- **组装排序条件**

  > **执行SQL：**SELECT uid AS id,username AS name,age,email,is_deleted FROM t_user WHERE is_deleted=0 ORDER BY age DESC,id ASC

  ```java
  public void test02(){
      //查询用户信息，按照年龄的降序排序，若年龄相同，则按照id升序排序
      QueryWrapper<User> queryWrapper = new QueryWrapper<>();
      queryWrapper.orderByDesc("age").orderByAsc("id");
      List<User> users = userMapper.selectList(queryWrapper);
      users.forEach(System.out::println);
  }
  ```

- **组装删除条件**

  > **执行SQL：**UPDATE t_user SET is_deleted=1 WHERE is_deleted=0 AND (email IS NULL)

  ```java
  public void test03(){
      //删除邮箱地址为null的用户信息
      QueryWrapper<User> queryWrapper = new QueryWrapper<>();
      queryWrapper.isNull("email");
      int result = userMapper.delete(queryWrapper);
      System.out.println(result > 0 ? "删除成功！" : "删除失败！");
      System.out.println("受影响的行数为：" + result);
  }
  ```

- **条件的优先级**

  > **执行SQL：**UPDATE t_user SET user_name=?, email=? WHERE is_deleted=0 AND (age > ? AND user_name LIKE ? OR email IS NULL)

  ```java
  public void test04(){
      //将（年龄大于20并且用户名中包含有a）或邮箱为null的用户信息修改
      UpdateWrapper<User> updateWrapper = new UpdateWrapper<>();
      updateWrapper.gt("age",20).like("username","a").or().isNull("email");
      User user = new User();
      user.setName("Oz");
      user.setEmail("test@oz6.com");
  
      int result = userMapper.update(user, updateWrapper);
      System.out.println(result > 0 ? "修改成功！" : "修改失败！");
      System.out.println("受影响的行数为：" + result);
  }
  ```

  > **执行SQL：**UPDATE t_user SET username=?, email=? WHERE is_deleted=0 AND (username LIKE ? AND (age > ? OR email IS NULL))

  ```java
  public void test05(){
      //将用户名中包含有a并且（年龄大于20或邮箱为null）的用户信息修改
      UpdateWrapper<User> updateWrapper = new UpdateWrapper<>();
      updateWrapper.like("username","a").and(i->i.gt("age",20).or().isNull("email"));
      User user = new User();
      user.setName("Vz7797");
      user.setEmail("test@ss8o.com");
  
      int result = userMapper.update(user, updateWrapper);
      System.out.println(result > 0 ? "修改成功！" : "修改失败！");
      System.out.println("受影响的行数为：" + result);
  }
  ```

- **组装select子句**

  > **执行SQL：**SELECT username,age,email FROM t_user WHERE is_deleted=0

  ```java
  public void test06(){
      //查询用户的用户名、年龄、邮箱信息
      QueryWrapper<User> queryWrapper = new QueryWrapper<>();
      queryWrapper.select("username","age","email");
      List<Map<String, Object>> maps = userMapper.selectMaps(queryWrapper);
      maps.forEach(System.out::println);
  }
  ```

- **实现子查询**

  > **执行SQL：**SELECT uid AS id,user_name AS name,age,email,is_deleted FROM t_user WHERE is_deleted=0 AND (uid IN (select uid from t_user where uid <= 100))

  ```java
  public void test07(){
      //查询id小于等于100的用户信息
      QueryWrapper<User> queryWrapper = new QueryWrapper<>();
      queryWrapper.inSql("uid", "select uid from t_user where uid <= 100");
      List<User> list = userMapper.selectList(queryWrapper);
      list.forEach(System.out::println);
  }
  ```



## 3.UpdateWrapper

> UpdateWrapper不仅拥有QueryWrapper的组装条件功能，还提供了set方法进行修改对应条件的数据库信息

```java
public void test08(){
    //将用户名中包含有a并且（年龄大于20或邮箱为null）的用户信息修改
    UpdateWrapper<User> updateWrapper = new UpdateWrapper<>();
    updateWrapper.like("username","a").and( i -> i.gt("age",20).or().isNull("email")).set("email","svip@qq.com");
    int result = userMapper.update(null, updateWrapper);
    System.out.println(result > 0 ? "修改成功！" : "修改失败！");
    System.out.println("受影响的行数为：" + result);
}
```



## 4.condition

> 在真正开发的过程中，组装条件是常见的功能，而这些条件数据来源于用户输入，是可选的，因此我们在组装这些条件时，必须先判断用户是否选择了这些条件，若选择则需要组装该条件，若没有选择则一定不能组装，以免影响SQL执行的结果



- **思路一**

  > **执行SQL：**SELECT uid AS id,user_name AS name,age,email,is_deleted FROM t_user WHERE is_deleted=0 AND (user_name LIKE ? AND age <= ?)

  ```java
   public void test09(){
       String username = "a";
       Integer ageBegin = null;
       Integer ageEnd = 30;
       QueryWrapper<User> queryWrapper = new QueryWrapper<>();
       if(StringUtils.isNotBlank(username)){
           //isNotBlank判断某个字符创是否不为空字符串、不为null、不为空白符
           queryWrapper.like("user_name", username);
       }
       if(ageBegin != null){
           queryWrapper.ge("age", ageBegin);
       }
       if(ageEnd != null){
           queryWrapper.le("age", ageEnd);
       }
       List<User> list = userMapper.selectList(queryWrapper);
       list.forEach(System.out::println);
   }
  ```

- **思路二**

  > 上面的实现方案没有问题，但是代码比较复杂，我们可以使用带condition参数的重载方法构建查询条件，简化代码的编写

  ```java
  public void test10(){
      String username = "a";
      Integer ageBegin = null;
      Integer ageEnd = 30;
      QueryWrapper<User> queryWrapper = new QueryWrapper<>();
      queryWrapper.like(StringUtils.isNotBlank(username), "user_name", username)
          .ge(ageBegin != null, "age", ageBegin)
          .le(ageEnd != null, "age", ageEnd);
      List<User> list = userMapper.selectList(queryWrapper);
      list.forEach(System.out::println);
  }
  ```



## 5.LambdaQueryWrapper

> 功能等同于QueryWrapper，提供了Lambda表达式的语法可以避免填错列名。

```java
public void test11(){
    String username = "a";
    Integer ageBegin = null;
    Integer ageEnd = 30;
    LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
    queryWrapper.like(StringUtils.isNotBlank(username), User::getName, username)
        .ge(ageBegin != null, User::getAge, ageBegin)
        .le(ageEnd != null, User::getAge, ageEnd);
    List<User> list = userMapper.selectList(queryWrapper);
    list.forEach(System.out::println);
}
```



## 6.LambdaUpdateWrapper

> 功能等同于UpdateWrapper，提供了Lambda表达式的语法可以避免填错列名。

```java
public void test12(){
    //将用户名中包含有a并且（年龄大于20或邮箱为null）的用户信息修改
    LambdaUpdateWrapper<User> updateWrapper = new LambdaUpdateWrapper<>();
    updateWrapper.like(User::getName, "a")
        .and(i -> i.gt(User::getAge, 20).or().isNull(User::getEmail));
    updateWrapper.set(User::getName, "小黑").set(User::getEmail,"abc@atguigu.com");
    int result = userMapper.update(null, updateWrapper);
    System.out.println("result："+result);
}
```
