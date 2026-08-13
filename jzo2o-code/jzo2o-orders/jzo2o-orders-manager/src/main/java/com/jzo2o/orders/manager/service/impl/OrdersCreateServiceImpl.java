package com.jzo2o.orders.manager.service.impl;

import cn.hutool.core.util.ObjUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jzo2o.api.customer.AddressBookApi;
import com.jzo2o.api.customer.dto.response.AddressBookResDTO;
import com.jzo2o.api.foundations.ServeApi;
import com.jzo2o.api.foundations.dto.response.ServeAggregationResDTO;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.common.utils.DateUtils;
import com.jzo2o.mvc.utils.UserContext;
import com.jzo2o.orders.base.constants.RedisConstants;
import com.jzo2o.orders.base.mapper.OrdersMapper;
import com.jzo2o.orders.base.model.domain.Orders;
import com.jzo2o.orders.manager.model.dto.request.PlaceOrderReqDTO;
import com.jzo2o.orders.manager.model.dto.response.PlaceOrderResDTO;
import com.jzo2o.orders.manager.service.IOrdersCreateService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 下单服务类
 * </p>
 *
 * @author itcast
 * @since 2023-07-10
 */
@Slf4j
@Service
public class OrdersCreateServiceImpl extends ServiceImpl<OrdersMapper, Orders> implements IOrdersCreateService {

    @Resource
    private AddressBookApi addressBookApi;

    @Resource
    private ServeApi serveApi;

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Override
    public PlaceOrderResDTO placeOrder(PlaceOrderReqDTO placeOrderReqDTO) {
        // 查询服务地址和服务信息
        Long serveId = placeOrderReqDTO.getServeId();
        Long addressBookId = placeOrderReqDTO.getAddressBookId();
        AddressBookResDTO addressDto = addressBookApi.detail(addressBookId);
        if (ObjUtil.isNull(addressDto)) {
            throw new ForbiddenOperationException("服务地址有误");
        }
        ServeAggregationResDTO serveDto = serveApi.findById(serveId);
        if (ObjUtil.isNull(serveDto)) {
            throw new ForbiddenOperationException("服务信息有误");
        }
        // 封装信息
        Orders orders = new Orders();
        orders.setId(generateOrderId());   // 订单id
        orders.setUserId(UserContext.currentUserId());   // 下单人id
        orders.setServeId(placeOrderReqDTO.getServeId());   // 服务id
        // - 运营数据微服务
        orders.setServeTypeId(serveDto.getServeTypeId());   // 服务类型id
        orders.setServeTypeName(serveDto.getServeTypeName());   // 服务类型名称
        orders.setServeItemId(serveDto.getServeItemId());   // 服务项id
        orders.setServeItemName(serveDto.getServeItemName());   // 服务项名称
        orders.setServeItemImg(serveDto.getServeItemImg());   // 服务项图片
        orders.setUnit(serveDto.getUnit());   // 服务单位
        orders.setPrice(serveDto.getPrice());   // 服务单价
        orders.setCityCode(serveDto.getCityCode());   // 城市编码
        // - 状态
        orders.setOrdersStatus(0);   // 订单状态: 待支付
        orders.setPayStatus(2);   // 支付状态: 待支付
        // - 金额
        orders.setPurNum(placeOrderReqDTO.getPurNum());   // 购买数量
        orders.setTotalAmount(serveDto.getPrice().multiply(new BigDecimal(placeOrderReqDTO.getPurNum())));   // 总金额: 价格 * 购买数量
        orders.setDiscountAmount(new BigDecimal(0));   // 优惠金额
        orders.setRealPayAmount(orders.getTotalAmount().subtract(orders.getDiscountAmount()));   // 实付金额 订单总金额 - 优惠金额
        // - 地址
        orders.setServeAddress(addressDto.getAddress());   // 服务详细地址
        orders.setContactsPhone(addressDto.getPhone());   // 联系人手机号
        orders.setContactsName(addressDto.getName());   // 联系人名字
        orders.setLon(addressDto.getLon());   // 经度
        orders.setLat(addressDto.getLat());   // 纬度
        // - 时间
        orders.setServeStartTime(placeOrderReqDTO.getServeStartTime());//服务开始时间
        orders.setDisplay(1);   // 用户端是否展示 1 展示
        orders.setSortBy(DateUtils.toEpochMilli(placeOrderReqDTO.getServeStartTime()) + orders.getId() % 100000);   // 排序字段
        // 保存
        this.save(orders);
        return new PlaceOrderResDTO(orders.getId());
    }

    /**
     * 生成订单 id
     *
     * @return 订单id 19位：2位年 + 2位月 + 2位日 + 13位序号（自增）
     */
    private Long generateOrderId() {
        // 2位年 + 2位月 + 2位日
        Long yyMMdd = DateUtils.getFormatDate(LocalDateTime.now(), "yyMMdd");
        // 自增数字  1 2
        Long num = redisTemplate.opsForValue().increment(RedisConstants.Lock.ORDERS_SHARD_KEY_ID_GENERATOR, 1);   // 1 代表每次增长量为 1
        // 组装返回
        return yyMMdd * 10000000000000L + num;
    }

}