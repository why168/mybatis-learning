package github.why168.service.impl;

import github.why168.entity.Product;
import github.why168.mapper.ProductMapper;
import github.why168.service.ProductService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Edwin
 * @since 2022-07-31 20:38:51
 */
@Service
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements ProductService {

}
