package com.jzo2o.orders.manager.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jzo2o.orders.base.model.domain.Orders;
import com.jzo2o.orders.manager.model.dto.request.OrdersPayReqDTO;
import com.jzo2o.orders.manager.model.dto.request.PlaceOrderReqDTO;
import com.jzo2o.orders.manager.model.dto.response.OrdersPayResDTO;
import com.jzo2o.orders.manager.model.dto.response.PlaceOrderResDTO;

/**
 * <p>
 * 下单服务类
 * </p>
 *
 * @author itcast
 * @since 2023-07-10
 */
public interface IOrdersCreateService extends IService<Orders> {

    /**
     * 下单
     *
     * @param placeOrderReqDTO
     * @return
     */
    PlaceOrderResDTO placeOrder(PlaceOrderReqDTO placeOrderReqDTO);

    /**
     * 下单
     *
     * @param userId 登录用户id
     * @param placeOrderReqDTO 订单参数
     * @return 订单id
     */
    PlaceOrderResDTO placeOrder(Long userId, PlaceOrderReqDTO placeOrderReqDTO);

    /**
     * 支付
     *
     * @param id
     * @param ordersPayReqDTO
     * @return
     */
    OrdersPayResDTO pay(Long id, OrdersPayReqDTO ordersPayReqDTO);

    /**
     * 查询订单支付结果
     *
     * @param id
     * @return
     */
    OrdersPayResDTO getPayResultFromTradServer(Long id);

}