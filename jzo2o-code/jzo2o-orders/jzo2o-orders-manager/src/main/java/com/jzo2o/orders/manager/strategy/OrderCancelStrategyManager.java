package com.jzo2o.orders.manager.strategy;

import cn.hutool.core.util.ObjUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.orders.base.mapper.OrdersMapper;
import com.jzo2o.orders.base.model.domain.Orders;
import com.jzo2o.orders.manager.model.dto.OrderCancelDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * 订单取消策略上下文环境类
 */
@Component
@Slf4j
public class OrderCancelStrategyManager {

    @Resource
    private OrdersMapper ordersMapper;

    // key格式：userType+":"+orderStatusEnum，例：1：NO_PAY
    private Map<String, OrderCancelStrategy> strategyMap = new HashMap<>();

    @PostConstruct // 此注解标注的方法会在当前对象创建后自动调用
    public void init() {
        strategyMap = SpringUtil.getBeansOfType(OrderCancelStrategy.class);
        log.debug("订单取消策略类初始化到map完成！");
    }

    /**
     * 订单取消
     *
     * @param orderCancelDTO
     */
    public void cancel(OrderCancelDTO orderCancelDTO) {
        // 根据订单id查询订单信息，如果订单不存在，直接返回错误
        Orders orders = ordersMapper.selectById(orderCancelDTO.getId());
        if (ObjUtil.isNull(orders)) {
            throw new ForbiddenOperationException("订单不存在");
        }
        // 根据用户类型和订单状态获取获取策略对象
        String key = orderCancelDTO.getCurrentUserType() + ":" + orders.getOrdersStatus();
        OrderCancelStrategy strategy =  strategyMap.get(key);
        if (ObjUtil.isEmpty(strategy)) {
            throw new ForbiddenOperationException("不被许可的操作");
        }
        // 执行策略对象的方法
        strategy.cancel(orderCancelDTO);
    }

}