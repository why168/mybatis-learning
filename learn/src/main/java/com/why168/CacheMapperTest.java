package com.why168;

import com.why168.config.SqlSessionUtils;
import com.why168.domain.Emp;
import com.why168.mapper.CacheMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;


public class CacheMapperTest {

    /*
    MyBatis的一级缓存
    - 一级缓存是SqlSession级别的，通过同一个SqlSession查询的数据会被缓存，下次查询相同的数据，就会从缓存中直接获取，不会从数据库重新访问
    - 使一级缓存失效的四种情况：
        1. 不同的SqlSession对应不同的一级缓存
        2. 同一个SqlSession但是查询条件不同
        3. 同一个SqlSession两次查询期间执行了任何一次增删改操作
        4. 同一个SqlSession两次查询期间手动清空了缓存

    MyBatis的二级缓存的相关配置
    - 在mapper配置文件中添加的cache标签可以设置一些属性
    - eviction属性：缓存回收策略
        - LRU（Least Recently Used） – 最近最少使用的：移除最长时间不被使用的对象。
        - FIFO（First in First out） – 先进先出：按对象进入缓存的顺序来移除它们。
        - SOFT – 软引用：移除基于垃圾回收器状态和软引用规则的对象。
        - WEAK – 弱引用：更积极地移除基于垃圾收集器状态和弱引用规则的对象。
        - 默认的是 LRU
    - flushInterval属性：刷新间隔，单位毫秒
        - 默认情况是不设置，也就是没有刷新间隔，缓存仅仅调用语句（增删改）时刷新
    - size属性：引用数目，正整数
        - 代表缓存最多可以存储多少个对象，太大容易导致内存溢出
    - readOnly属性：只读，true/false
        - true：只读缓存；会给所有调用者返回缓存对象的相同实例。因此这些对象不能被修改。这提供了很重要的性能优势。
        - false：读写缓存；会返回缓存对象的拷贝（通过序列化）。这会慢一些，但是安全，因此默认是false

    MyBatis缓存查询的顺序
        - 先查询二级缓存，因为二级缓存中可能会有其他程序已经查出来的数据，可以拿来直接使用
        - 如果二级缓存没有命中，再查询一级缓存
        - 如果一级缓存也没有命中，则查询数据库
        - SqlSession关闭之后，一级缓存中的数据会写入二级缓存
     */
    @Test
    public void testOneCache01() {
        SqlSession sqlSession1 = SqlSessionUtils.getSqlSession();
        CacheMapper mapper1 = sqlSession1.getMapper(CacheMapper.class);
        Emp emp1 = mapper1.getEmpByEid(1);
        System.out.println(emp1);

        Emp emp2 = mapper1.getEmpByEid(1);
        System.out.println(emp2);
    }

    @Test
    public void testOneCache04() {
        SqlSession sqlSession1 = SqlSessionUtils.getSqlSession();
        CacheMapper mapper1 = sqlSession1.getMapper(CacheMapper.class);
        Emp emp1 = mapper1.getEmpByEid(1);
        System.out.println(emp1);

        SqlSession sqlSession2 = SqlSessionUtils.getSqlSession();
        CacheMapper mapper2 = sqlSession2.getMapper(CacheMapper.class);
        Emp emp2 = mapper2.getEmpByEid(1);
        System.out.println(emp2);
    }

    @Test
    public void testOneCache02() {
        SqlSession sqlSession1 = SqlSessionUtils.getSqlSession();
        CacheMapper mapper1 = sqlSession1.getMapper(CacheMapper.class);
        Emp emp1 = mapper1.getEmpByEid(1);
        System.out.println(emp1);

        mapper1.insertEmp(new Emp(null, "abc", 23, "男", "123@qq.com"));

        Emp emp2 = mapper1.getEmpByEid(1);
        System.out.println(emp2);

    }

    @Test
    public void testOneCache03() {
        SqlSession sqlSession1 = SqlSessionUtils.getSqlSession();
        CacheMapper mapper1 = sqlSession1.getMapper(CacheMapper.class);
        Emp emp1 = mapper1.getEmpByEid(1);
        System.out.println(emp1);

        sqlSession1.clearCache();

        Emp emp2 = mapper1.getEmpByEid(1);
        System.out.println(emp2);
    }


    @Test
    public void testTwoCache() {
        try {
            InputStream is = Resources.getResourceAsStream("mybatis-config.xml");
            SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);

            SqlSession sqlSession1 = sqlSessionFactory.openSession(true);
            CacheMapper mapper1 = sqlSession1.getMapper(CacheMapper.class);
            System.out.println(mapper1.getEmpByEid(1));
            sqlSession1.close();

            SqlSession sqlSession2 = sqlSessionFactory.openSession(true);
            CacheMapper mapper2 = sqlSession2.getMapper(CacheMapper.class);
            System.out.println(mapper2.getEmpByEid(1));
            sqlSession2.close();

            SqlSession sqlSession3 = sqlSessionFactory.openSession(true);
            CacheMapper mapper3 = sqlSession3.getMapper(CacheMapper.class);
            System.out.println(mapper3.getEmpByEid(1));
            sqlSession3.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
