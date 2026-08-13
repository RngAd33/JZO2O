package com.jzo2o.orders.manager.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jzo2o.api.customer.AddressBookApi;
import com.jzo2o.api.customer.dto.response.AddressBookResDTO;
import com.jzo2o.api.foundations.ServeApi;
import com.jzo2o.api.foundations.dto.response.ServeAggregationResDTO;
import com.jzo2o.api.trade.NativePayApi;
import com.jzo2o.api.trade.TradingApi;
import com.jzo2o.api.trade.dto.request.NativePayReqDTO;
import com.jzo2o.api.trade.dto.response.NativePayResDTO;
import com.jzo2o.api.trade.dto.response.TradingResDTO;
import com.jzo2o.api.trade.enums.PayChannelEnum;
import com.jzo2o.api.trade.enums.TradingStateEnum;
import com.jzo2o.common.expcetions.CommonException;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.common.utils.DateUtils;
import com.jzo2o.mvc.utils.UserContext;
import com.jzo2o.orders.base.constants.RedisConstants;
import com.jzo2o.orders.base.enums.OrderPayStatusEnum;
import com.jzo2o.orders.base.enums.OrderStatusEnum;
import com.jzo2o.orders.base.mapper.OrdersMapper;
import com.jzo2o.orders.base.model.domain.Orders;
import com.jzo2o.orders.manager.model.dto.request.OrdersPayReqDTO;
import com.jzo2o.orders.manager.model.dto.request.PlaceOrderReqDTO;
import com.jzo2o.orders.manager.model.dto.response.OrdersPayResDTO;
import com.jzo2o.orders.manager.model.dto.response.PlaceOrderResDTO;
import com.jzo2o.orders.manager.porperties.TradeProperties;
import com.jzo2o.orders.manager.service.IOrdersCreateService;
import com.jzo2o.redis.annotations.Lock;
import lombok.extern.slf4j.Slf4j;
import org.redisson.api.RedissonClient;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

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
    private IOrdersCreateService owner;

    @Resource
    private AddressBookApi addressBookApi;

    @Resource
    private NativePayApi nativePayApi;

    @Resource
    private ServeApi serveApi;

    @Resource
    private TradingApi tradingApi;

    @Resource
    private TradeProperties tradeProperties;

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Override
    public PlaceOrderResDTO placeOrder(PlaceOrderReqDTO placeOrderReqDTO) {
        // 先注册对象再调用接口，防止事务失效
        return owner.placeOrder(UserContext.currentUserId(), placeOrderReqDTO);
    }

    @Override
    @Lock(formatter = "ORDERS:CREATE:LOCK:#{userId}:#{placeOrderReqDTO.serveId}", time = 30, waitTime = 1, unlock = false)
    public PlaceOrderResDTO placeOrder(Long userId, PlaceOrderReqDTO placeOrderReqDTO) {
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

    @Override
    public OrdersPayResDTO pay(Long id, OrdersPayReqDTO ordersPayReqDTO) {
        // 查询订单
        Orders orders = this.getById(id);
        if (ObjUtil.isNull(orders)) {
            throw new ForbiddenOperationException("订单不存在");
        }

        // 校验状态
        Integer payStatus = orders.getPayStatus();
        String transactionId = orders.getTransactionId();
        if (payStatus == 4 && StrUtil.isNotBlank(transactionId)) {
            throw new ForbiddenOperationException("订单已经支付了");
        }

        // 调用支付API，生成支付二维码
        NativePayReqDTO nativePayReqDTO = new NativePayReqDTO();
        nativePayReqDTO.setProductAppId("jzo2o.orders");
        nativePayReqDTO.setProductOrderNo(id);
        nativePayReqDTO.setTradingChannel(ordersPayReqDTO.getTradingChannel());
        nativePayReqDTO.setTradingAmount(orders.getRealPayAmount());
        nativePayReqDTO.setMemo(orders.getServeItemName());
        nativePayApi.createDownLineTrading(nativePayReqDTO);
        // - 根据交易渠道设置商户号
        if (ObjUtil.equal(ordersPayReqDTO.getTradingChannel(), PayChannelEnum.WECHAT_PAY)) {
            nativePayReqDTO.setEnterpriseId(tradeProperties.getWechatEnterpriseId());   // 微信商户号
        } else if (ObjUtil.equal(ordersPayReqDTO.getTradingChannel(), PayChannelEnum.ALI_PAY)) {
            nativePayReqDTO.setEnterpriseId(tradeProperties.getAliEnterpriseId());   // 阿里商户号
        }
        // - 如果原有的交易渠道不为空，而且跟刚刚传入交易渠道不一样，就改变交易渠道
        nativePayReqDTO.setChangeChannel(StrUtil.isNotBlank(orders.getTradingChannel())
                && !StrUtil.equals(orders.getTradingChannel(), ordersPayReqDTO.getTradingChannel().toString()));

        // 更新订单表数据(支付服务交易单号、支付渠道)
        NativePayResDTO nativePayResDTO = nativePayApi.createDownLineTrading(nativePayReqDTO);
        orders.setTradingOrderNo(nativePayResDTO.getTradingOrderNo());
        orders.setTradingChannel(nativePayResDTO.getTradingChannel());
        this.updateById(orders);

        // 封装返回结果
        OrdersPayResDTO ordersPayResDTO = BeanUtil.copyProperties(nativePayResDTO, OrdersPayResDTO.class, "payStatus");
        ordersPayResDTO.setPayStatus(2);
        return ordersPayResDTO;
    }

    @Override
    public OrdersPayResDTO getPayResultFromTradServer(Long id) {
        Orders orders = this.getById(id);
        if (ObjUtil.isNull(orders)) {
            throw new ForbiddenOperationException("订单不存在");
        }
        // 如果订单的支付状态是待支付，并且支付服务交易单号不为空，调用支付服务查询订单支付状态
        if (Objects.equals(orders.getPayStatus(), TradingStateEnum.FKZ.getCode()) && orders.getTradingOrderNo() != null) {
            TradingResDTO tradingResDTO = tradingApi.findTradResultByTradingOrderNo(orders.getTradingOrderNo());
            // 根据支付服务返回的状态修改订单表中字段(订单状态、支付状态、第三方支付交易号)
            TradingStateEnum tradingState = tradingResDTO.getTradingState();
            boolean update = this.lambdaUpdate()
                    //交易状态: 4-已结算  订单状态:派单中
                    .set(ObjUtil.equal(tradingState, TradingStateEnum.YJS), Orders::getOrdersStatus, OrderStatusEnum.DISPATCHING.getStatus())
                    //交易状态: 3-付款失败  订单状态:已关闭
                    .set(ObjUtil.equal(tradingState, TradingStateEnum.FKSB), Orders::getOrdersStatus, OrderStatusEnum.CLOSED.getStatus())
                    //交易状态: 5-取消订单  订单状态:已取消
                    .set(ObjUtil.equal(tradingState, TradingStateEnum.QXDD), Orders::getOrdersStatus, OrderStatusEnum.CANCELED.getStatus())
                    //交易状态: 4-已结算  支付状态:支付成功
                    .set(ObjUtil.equal(tradingState, TradingStateEnum.YJS), Orders::getPayStatus, OrderPayStatusEnum.PAY_SUCCESS.getStatus())
                    //第三方支付交易单号
                    .set(ObjUtil.isNotEmpty(tradingResDTO.getTransactionId()), Orders::getTransactionId, tradingResDTO.getTransactionId())
                    //根据订单id更新
                    .eq(Orders::getId, id)
                    .update();
            if (!update) {
                log.info("更新订单:{}状态失败", orders.getId());
                throw new CommonException("更新订单" + orders.getId() + "状态失败");
            }
        }
        // 返回封装结果
        OrdersPayResDTO ordersPayResDTO = new OrdersPayResDTO();
        ordersPayResDTO.setProductOrderNo(orders.getId());   // 业务系统订单号
        ordersPayResDTO.setTradingOrderNo(orders.getTradingOrderNo());   // 交易系统订单号
        ordersPayResDTO.setTradingChannel(orders.getTradingChannel());   // 支付渠道
        ordersPayResDTO.setPayStatus(orders.getPayStatus());   // 支付状态
        return ordersPayResDTO;
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