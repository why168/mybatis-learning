package com.why168;

import com.why168.config.SqlSessionUtils;
import com.why168.domain.User;
import com.why168.mapper.UserMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.*;
import java.util.List;

public class MyBatisTest {

    private SqlSession sqlSession;
    private UserMapper mapper;

    @Before
    public void init() {
        sqlSession = SqlSessionUtils.getSqlSession();
        mapper = sqlSession.getMapper(UserMapper.class);
    }

    @After
    public void destroy() {
        sqlSession.close();
    }

    @Test
    public void testJDBC() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=UTF-8", "root", "root");
        PreparedStatement ps = connection.prepareStatement("INSERT INTO test.t_user (username, password, age, sex, email)\n" + "VALUES ('admin', '123456', 23, '男', '12345@qq.com');", Statement.RETURN_GENERATED_KEYS);
        ps.executeUpdate();
        ResultSet resultSet = ps.getGeneratedKeys();
        System.out.println(resultSet.next());
    }

    @Test
    public void TestInsertUser() {
        SqlSession sqlSession = SqlSessionUtils.getSqlSession();
        UserMapper mapper = sqlSession.getMapper(UserMapper.class);

        User userInsert = new User();
        userInsert.setAge(20);
        userInsert.setEmail("3333@qq.com");
        userInsert.setUsername("奶狗" + System.currentTimeMillis());
        userInsert.setPassword("www123");
        userInsert.setSex("男");

        int count = mapper.insertUser(userInsert);
        System.out.println("TestInsertUser count:" + count);
        mapper.getAllUser().forEach(user -> System.out.println(user.toString()));
    }

    @Test
    public void TestDeleteUser() {
        int count = mapper.deleteUser(33);
        System.out.println("TestDeleteUser count:" + count);
        mapper.getAllUser().forEach(user -> System.out.println(user.toString()));

    }

    @Test
    public void TestDeleteMore() {
        int count = mapper.deleteMore("12,15,18,20");
        System.out.println("TestDeleteMore count:" + count);
        mapper.getAllUser().forEach(user -> System.out.println(user.toString()));
    }

    @Test
    public void TestGetUserById() {
        User user = mapper.getUserById(35);
        System.out.println("TestGetUserById user:" + user.toString());
    }

    @Test
    public void TestGetUserByLike() {
        List<User> userList = mapper.getUserByLike("奶狗");
        userList.forEach(System.out::println);
    }

}
