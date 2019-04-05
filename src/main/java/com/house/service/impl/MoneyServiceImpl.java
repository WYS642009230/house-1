package com.house.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.house.mapper.MoneyMapper;
import com.house.pojo.Money;
import com.house.pojo.Page;
import com.house.service.MoneyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 租金缴费表 服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2019-03-30
 */
@Service
public class MoneyServiceImpl extends ServiceImpl<MoneyMapper, Money> implements MoneyService {

    @Autowired
    private MoneyMapper moneyMapper;
    @Value("${CURRENT_COUNT}")
    private Integer CURRENT_COUNT;

    /**
     * 分页查询
     *
     * @param page
     * @return
     */
    @Override
    public Page<Money> getByPage(Page<Money> page) {
        // 设置当前页，如果当前页为空，默认是0
        Integer currentPage = page.getCurrentPage();
        if (currentPage == null) {
            currentPage = 1;
        }
        // 设置每页显示条数，从resource文件中读取
        Integer currentCount = CURRENT_COUNT;
        page.setCurrentPage(currentPage);
        // 计算索引，index=（当前页-1）*每页条数
        int index = (currentPage - 1) * currentCount;
        page.setIndex(index);
        page.setCurrentCount(currentCount);
        // 根据这些信息，分页查询
        List<Money> list = moneyMapper.getList(page);
        // 查询总条数
        Integer totalCount = moneyMapper.getCount(page);
        // 设置总条数
        page.setTotalCount(totalCount);
        // 设置数据
        page.setList(list);
        // 计算总页数，总页数=总条数/每页显示条数 向上取整
        int totalPage = (int) Math.ceil(totalCount * 1.0 / currentCount);
        page.setTotalPage(totalPage);

        // 计算总收入
        double totalMoney = 0;
        for (Money money : list) {
            totalMoney += money.getMoneyMoney();
        }
        page.getParams().put("totalMoney", totalMoney);

        return page;
    }
}
