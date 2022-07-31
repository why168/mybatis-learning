# Mybatis-Plus增删改查

## 1.BaseMapper&lt;T&gt;

> 说明:
>
>- 通用 CRUD 封装BaseMapper 接口，为 `Mybatis-Plus` 启动时自动解析实体表关系映射转换为 `Mybatis` 内部对象注入容器
>- 泛型 `T` 为任意实体对象
>- 参数 `Serializable` 为任意类型主键 `Mybatis-Plus` 不推荐使用复合主键约定每一张表都有自己的唯一 `id` 主键
>- 对象 `Wrapper` 为条件构造器

MyBatis-Plus中的基本CRUD在内置的BaseMapper中都已得到了实现，因此我们继承该接口以后可以直接使用。

本次演示的CRUD操作不包含参数带有条件构造器的方法，关于条件构造器将单独在一个章节进行演示。

---

> **BaseMapper中提供的CRUD方法：**

- **增加：Insert**

  ```java
  // 插入一条记录
  int insert(T entity);
  ```

- **删除：Delete**

  ```java
  // 根据 entity 条件，删除记录
  int delete(@Param(Constants.WRAPPER) Wrapper<T> wrapper);
  // 删除（根据ID 批量删除）
  int deleteBatchIds(@Param(Constants.COLLECTION) Collection<? extends Serializable> idList);
  // 根据 ID 删除
  int deleteById(Serializable id);
  // 根据 columnMap 条件，删除记录
  int deleteByMap(@Param(Constants.COLUMN_MAP) Map<String, Object> columnMap);
  ```

- **修改：Update**

  ```java
  // 根据 whereWrapper 条件，更新记录
  int update(@Param(Constants.ENTITY) T updateEntity, @Param(Constants.WRAPPER) Wrapper<T> whereWrapper);
  // 根据 ID 修改
  int updateById(@Param(Constants.ENTITY) T entity);
  ```

- **查询：Selete**

  ```java
  // 根据 ID 查询
  T selectById(Serializable id);
  // 根据 entity 条件，查询一条记录
  T selectOne(@Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
  
  // 查询（根据ID 批量查询）
  List<T> selectBatchIds(@Param(Constants.COLLECTION) Collection<? extends Serializable> idList);
  // 根据 entity 条件，查询全部记录
  List<T> selectList(@Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
  // 查询（根据 columnMap 条件）
  List<T> selectByMap(@Param(Constants.COLUMN_MAP) Map<String, Object> columnMap);
  // 根据 Wrapper 条件，查询全部记录
  List<Map<String, Object>> selectMaps(@Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
  // 根据 Wrapper 条件，查询全部记录。注意： 只返回第一个字段的值
  List<Object> selectObjs(@Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
  
  // 根据 entity 条件，查询全部记录（并翻页）
  IPage<T> selectPage(IPage<T> page, @Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
  // 根据 Wrapper 条件，查询全部记录（并翻页）
  IPage<Map<String, Object>> selectMapsPage(IPage<T> page, @Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
  // 根据 Wrapper 条件，查询总记录数
  Integer selectCount(@Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
  ```

## 2.调用Mapper层实现CRUD

### 2.1	插入

---

> **最终执行的结果，所获取的id为1527206783590903810**
>
> **这是因为MyBatis-Plus在实现插入数据时，会默认基于雪花算法的策略生成id**

```java
/**
 * 测试插入一条数据
 * MyBatis-Plus在实现插入数据时，会默认基于雪花算法的策略生成id
 */
@Test
public void testInsert(){
        User user=new User();
        user.setName("Vz");
        user.setAge(21);
        user.setEmail("vz@oz6.cn");
        int result=userMapper.insert(user);
        System.out.println(result>0?"添加成功！":"添加失败！");
        System.out.println("受影响的行数为："+result);
        //1527206783590903810（当前 id 为雪花算法自动生成的id）
        System.out.println("id自动获取"+user.getId());
        }
```

### 2.2	删除

---

#### a、根据ID删除数据

> **调用方法：int deleteById(Serializable id);**

```java
/**
 * 测试根据id删除一条数据
 */
@Test
public void testDeleteById(){
        int result=userMapper.deleteById(1527206783590903810L);
        System.out.println(result>0?"删除成功！":"删除失败！");
        System.out.println("受影响的行数为："+result);
        }
```

#### b、根据ID批量删除数据

> **调用方法：int deleteBatchIds(@Param(Constants.COLLECTION) Collection<? extends Serializable> idList);**

```java
/**
 * 测试通过id批量删除数据
 */
@Test
public void testDeleteBatchIds(){
        List<Long> ids=Arrays.asList(6L,7L,8L);
        int result=userMapper.deleteBatchIds(ids);
        System.out.println(result>0?"删除成功！":"删除失败！");
        System.out.println("受影响的行数为："+result);
        }
```

#### c、根据Map条件删除数据

> **调用方法：int deleteByMap(@Param(Constants.COLUMN_MAP) Map<String, Object> columnMap);**

```java
/**
 * 测试根据Map集合中所设置的条件删除数据
 */
@Test
public void testDeleteByMap(){
        //当前演示为根据name和age删除数据
        //执行SQL为：DELETE FROM user WHERE name = ? AND age = ?
        Map<String, Object> map=new HashMap<>();
        map.put("name","Vz");
        map.put("age",21);
        int result=userMapper.deleteByMap(map);
        System.out.println(result>0?"删除成功！":"删除失败！");
        System.out.println("受影响的行数为："+result);
        }
```

### 2.3	修改

> **调用方法：int updateById(@Param(Constants.ENTITY) T entity);**

```java
/**
 * 测试根据id修改用户信息
 */
@Test
public void testUpdateById(){
        //执行SQL为： UPDATE user SET name=?, age=?, email=? WHERE id=?
        User user=new User();
        user.setId(6L);
        user.setName("VzUpdate");
        user.setAge(18);
        user.setEmail("Vz@sina.com");
        int result=userMapper.updateById(user);
        System.out.println(result>0?"修改成功！":"修改失败！");
        System.out.println("受影响的行数为："+result);
        }
```

### 2.4	查询

---

#### a、根据ID查询用户信息

> **调用方法：T selectById(Serializable id);**

```java
/**
 * 测试根据id查询用户数据
 */
@Test
public void testSelectById(){
        User user=userMapper.selectById(1L);
        System.out.println(user);
        }
```

#### b、根据多个ID查询多个用户信息

> **调用方法：List<T> selectBatchIds(@Param(Constants.COLLECTION) Collection<? extends Serializable> idList);**

```java
/**
 * 根据多个id查询用户数据
 */
@Test
public void testSelectBatchIds(){
        //执行SQL为：SELECT id,name,age,email FROM user WHERE id IN ( ? , ? , ? )
        List<Long> ids=Arrays.asList(1L,2L,3L);
        List<User> users=userMapper.selectBatchIds(ids);
        users.forEach(System.out::println);
        }
```

#### c、根据Map条件查询用户信息

> **调用方法：List<T> selectByMap(@Param(Constants.COLUMN_MAP) Map<String, Object> columnMap);**

```java
/**
 * 根据Map所设置的条件查询用户
 */
@Test
public void testSelectByMap(){
        //执行SQL为：SELECT id,name,age,email FROM user WHERE age = ?
        Map<String, Object> map=new HashMap<>();
        map.put("age",18);
        List<User> users=userMapper.selectByMap(map);
        users.forEach(System.out::println);
        }
```

#### d、查询所有用户信息

> **调用方法：List<T> selectList(@Param(Constants.WRAPPER) Wrapper<T> queryWrapper);**

```java
/**
 * 测试查询所有数据
 */
@Test
void testSelectList(){
        List<User> users=userMapper.selectList(null);
        users.forEach(System.out::println);
        }
```

## 3.通用Service

> 说明:
>
>- 通用 Service CRUD 封装`IService`接口，进一步封装 CRUD 采用 `get 查询单行` `remove 删除` `list 查询集合` `page 分页` 前缀命名方式区分 `Mapper` 层避免混淆，
>- 泛型 `T` 为任意实体对象
>- 建议如果存在自定义通用 Service 方法的可能，请创建自己的 `IBaseService` 继承 `Mybatis-Plus` 提供的基类
>- 对象 `Wrapper` 为 条件构造器

MyBatis-Plus中有一个接口 **`IService`**和其实现类 **`ServiceImpl`**，封装了常见的业务层逻辑，详情查看源码IService和ServiceImpl

因此我们在使用的时候仅需在自己定义的**`Service`**接口中继承**`IService`**接口，在自己的实现类中实现自己的Service并继承**`ServiceImpl`**即可

---

> **IService中的CRUD方法**

- **增加：Save、SaveOrUpdate**

  ```java
  // 插入一条记录（选择字段，策略插入）
  boolean save(T entity);
  // 插入（批量）
  boolean saveBatch(Collection<T> entityList);
  // 插入（批量）
  boolean saveBatch(Collection<T> entityList, int batchSize);
  
  // TableId 注解存在更新记录，否插入一条记录
  boolean saveOrUpdate(T entity);
  // 根据updateWrapper尝试更新，否继续执行saveOrUpdate(T)方法
  boolean saveOrUpdate(T entity, Wrapper<T> updateWrapper);
  // 批量修改插入
  boolean saveOrUpdateBatch(Collection<T> entityList);
  // 批量修改插入
  boolean saveOrUpdateBatch(Collection<T> entityList, int batchSize);
  ```

- **删除：Remove**

  ```java
  // 根据 entity 条件，删除记录
  boolean remove(Wrapper<T> queryWrapper);
  // 根据 ID 删除
  boolean removeById(Serializable id);
  // 根据 columnMap 条件，删除记录
  boolean removeByMap(Map<String, Object> columnMap);
  // 删除（根据ID 批量删除）
  boolean removeByIds(Collection<? extends Serializable> idList);
  ```

- **修改：Update**

  ```java
  // 根据 UpdateWrapper 条件，更新记录 需要设置sqlset
  boolean update(Wrapper<T> updateWrapper);
  // 根据 whereWrapper 条件，更新记录
  boolean update(T updateEntity, Wrapper<T> whereWrapper);
  // 根据 ID 选择修改
  boolean updateById(T entity);
  // 根据ID 批量更新
  boolean updateBatchById(Collection<T> entityList);
  // 根据ID 批量更新
  boolean updateBatchById(Collection<T> entityList, int batchSize);
  ```

- **查询：Get、List、Count**

  ```java
  // 根据 ID 查询
  T getById(Serializable id);
  // 根据 Wrapper，查询一条记录。结果集，如果是多个会抛出异常，随机取一条加上限制条件 wrapper.last("LIMIT 1")
  T getOne(Wrapper<T> queryWrapper);
  // 根据 Wrapper，查询一条记录
  T getOne(Wrapper<T> queryWrapper, boolean throwEx);
  // 根据 Wrapper，查询一条记录
  Map<String, Object> getMap(Wrapper<T> queryWrapper);
  // 根据 Wrapper，查询一条记录
  <V> V getObj(Wrapper<T> queryWrapper, Function<? super Object, V> mapper);
  
  
  // 查询所有
  List<T> list();
  // 查询列表
  List<T> list(Wrapper<T> queryWrapper);
  // 查询（根据ID 批量查询）
  Collection<T> listByIds(Collection<? extends Serializable> idList);
  // 查询（根据 columnMap 条件）
  Collection<T> listByMap(Map<String, Object> columnMap);
  // 查询所有列表
  List<Map<String, Object>> listMaps();
  // 查询列表
  List<Map<String, Object>> listMaps(Wrapper<T> queryWrapper);
  // 查询全部记录
  List<Object> listObjs();
  // 查询全部记录
  <V> List<V> listObjs(Function<? super Object, V> mapper);
  // 根据 Wrapper 条件，查询全部记录
  List<Object> listObjs(Wrapper<T> queryWrapper);
  // 根据 Wrapper 条件，查询全部记录
  <V> List<V> listObjs(Wrapper<T> queryWrapper, Function<? super Object, V> mapper);
  
  // 查询总记录数
  int count();
  // 根据 Wrapper 条件，查询总记录数
  int count(Wrapper<T> queryWrapper);
  ```

- **分页：Page**

  ```java
  // 根据 ID 查询
  T getById(Serializable id);
  // 根据 Wrapper，查询一条记录。结果集，如果是多个会抛出异常，随机取一条加上限制条件 wrapper.last("LIMIT 1")
  T getOne(Wrapper<T> queryWrapper);
  // 根据 Wrapper，查询一条记录
  T getOne(Wrapper<T> queryWrapper, boolean throwEx);
  // 根据 Wrapper，查询一条记录
  Map<String, Object> getMap(Wrapper<T> queryWrapper);
  // 根据 Wrapper，查询一条记录
  <V> V getObj(Wrapper<T> queryWrapper, Function<? super Object, V> mapper);
  ```

## 4.调用Service层操作数据

> 我们在自己的Service接口中通过继承MyBatis-Plus提供的IService接口，不仅可以获得其提供的CRUD方法，而且还可以使用自身定义的方法。

- **创建`UserService`并继承`IService`**

  ```java
  /**
    * UserService继承IService模板提供的基础功能 
    */
  public interface UserService extends IService<User> {}
  ```

- **创建`UserService`的实现类并继承`ServiceImpl`**

  ```java
  /**
    * ServiceImpl实现了IService，提供了IService中基础功能的实现 
    * 若ServiceImpl无法满足业务需求，则可以使用自定的UserService定义方法，并在实现类中实现
    */
  @Service
  public class UserServiceImpl extends ServiceImpl<UserMapper,User> implements UserService{}
  ```

- **测试查询记录数**

  > **调用方法：int count();**

  ```java
  @Test
  public void testGetCount(){
      //查询总记录数
      //执行的SQL为：SELECT COUNT( * ) FROM user
      long count = userService.count();
      System.out.println("总记录数：" + count);
  }
  ```

- **测试批量插入数据**

  > **调用方法：boolean saveBatch(Collection<T> entityList);**

  ```java
  @Test
  public void test(){
      List<User> list = new ArrayList<>();
      for (int i = 1; i <= 10; i++) {
          User user = new User();
          user.setName("Vz"+i);
          user.setAge(20+i);
          list.add(user);
      }
      boolean b = userService.saveBatch(list);
      System.out.println(b ? "添加成功！" : "添加失败！");
  }
  ```
