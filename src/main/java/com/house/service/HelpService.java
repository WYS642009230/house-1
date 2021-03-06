package com.house.service;

import com.house.pojo.Help;
import com.baomidou.mybatisplus.service.IService;
import com.house.pojo.Page;

/**
 * <p>
 * 帮助表 服务类
 * </p>
 *
 * @author ${author}
 * @since 2019-03-30
 */
public interface HelpService extends IService<Help> {

    /**
     * 分页查询
     * @param page
     * @return
     */
    Page<Help> getByPage(Page<Help> page);
}
