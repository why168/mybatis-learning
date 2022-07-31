package github.why168;


import github.why168.service.ProductService;
import github.why168.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DatasourceTests {


    @Autowired
    private UserService userService;
    @Autowired
    private ProductService productService;

    @Test
    public void DatasourceTest() {
        System.out.println(userService.getById(1));
        System.out.println(productService.getById(1));
    }

}
