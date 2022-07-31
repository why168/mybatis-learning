package github.why168;

import github.why168.mapper.DeptMapper;
import github.why168.mapper.EmpMapper;
import github.why168.pojo.Dept;
import github.why168.pojo.Emp;
import github.why168.pojo.EmpExample;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class GeneratorConfigMain {

    /**
     * mybatis-generator-maven-plugin插件中的驱动
     *
     */
    public static void main(String[] args) {
        SqlSession sqlSession = SqlSessionUtils.getSqlSession();
        DeptMapper mapper = sqlSession.getMapper(DeptMapper.class);
        List<Dept> depts = mapper.selectByExample(null);
        depts.forEach(System.out::println);
    }

}
