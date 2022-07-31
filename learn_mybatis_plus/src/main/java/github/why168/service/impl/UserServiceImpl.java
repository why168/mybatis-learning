package github.why168.service.impl;

import github.why168.entity.User;
import github.why168.mapper.UserMapper;
import github.why168.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Edwin
 * @since 2022-07-31 20:38:52
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

}
