package github.why168.entity;

import com.baomidou.mybatisplus.annotation.*;
import github.why168.enums.SexEnum;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 *
 * </p>
 *
 * @author Edwin
 * @since 2022-07-31 20:38:52
 */
@Data
@TableName("user_plus")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @TableId(value = "uid", type = IdType.AUTO)
    private Long uid;

    /**
     * 姓名
     */
    @TableField("user_name")
    private String name;

    /**
     * 年龄
     */
    private Integer age;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 0:未删除
     */
    @TableLogic
    private Integer isDeleted;

    private SexEnum sex;


}
