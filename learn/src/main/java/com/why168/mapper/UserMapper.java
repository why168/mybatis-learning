package com.why168.mapper;


import com.why168.domain.User;
import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 * MyBatis面向接口编程的两个一致：
 * 1、映射文件的`namespace`要和`mapper`接口的全类名保持一致
 * 2、映射文件中SQL语句的`id`要和`mapper`接口中的方法名一致
 * <p>
 * 表--实体类--mapper接口--映射文件
 */
public interface UserMapper {

    /**
     * 添加用户信息
     */
    int insertUser(User user);

    /**
     * 删除用户信息
     */
    int deleteUser(Integer id);

    int deleteMore(@Param("ids") String ids);


    /**
     * 根据id查询用户信息
     */
    User getUserById(@Param("id") Integer id);

    /**
     * 查询所有的用户信息
     */
    List<User> getAllUser();


    /**
     * 根据用户名模糊查询用户信息
     */
    List<User> getUserByLike(@Param("username") String username);

    /**
     * 查询指定表中的数据
     */
    List<User> getUserByTableName(@Param("tableName") String tableName);

    /**
     * 根据id查询用户信息为一个map集合
     */
    Map<String, Object> getUserByIdToMap(@Param("id") Integer id);

    /**
     * 查询所有用户信息为map集合
     */
//    List<Map<String, Object>> getAllUserToMap();
    @MapKey("id")
    Map<String, Object> getAllUserToMap();


    /**
     * 验证登录（使用@Param）
     */
    User checkLoginByParam(@Param("username") String username, @Param("password") String password);

    /**
     * 验证登录（参数为map）
     */
    User checkLoginByMap(Map<String, Object> map);

    /**
     * 验证登录
     */
    User checkLogin(String username, String password);

    /**
     * 根据用户名查询用户信息
     */
    User getUserByUsername(String username);

}
