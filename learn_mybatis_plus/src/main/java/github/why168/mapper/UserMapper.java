package github.why168.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import github.why168.entity.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author Edwin
 * @since 2022-07-31 20:38:52
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {

    /**
     * 根据id查询用户信息为map集合
     *
     * @param id
     * @return
     */
    @MapKey("uid")
    Map<String, Object> selectMapById(@Param("id") Long id);

    /**
     * 通过年龄查询用户信息并分页
     *
     * @param page MyBatis-Plus所提供的分页对象，必须位于第一个参数的位置
     * @param age
     * @return
     */
    Page<User> selectPageVo(@Param("page") Page<User> page, @Param("age") Integer age);
}
