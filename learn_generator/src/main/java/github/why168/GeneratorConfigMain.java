package github.why168;

import github.why168.mapper.DeptMapper;
import github.why168.pojo.Dept;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class GeneratorConfigMain {

    public static void main(String[] args) {
        SqlSession sqlSession = SqlSessionUtils.getSqlSession();
        DeptMapper mapper = sqlSession.getMapper(DeptMapper.class);
        List<Dept> depts = mapper.selectByExample(null);
        depts.forEach(System.out::println);
    }
}
