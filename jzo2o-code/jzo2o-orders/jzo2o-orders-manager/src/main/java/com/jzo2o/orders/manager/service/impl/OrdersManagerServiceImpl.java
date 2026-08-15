package com.jzo2o.orders.manager.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jzo2o.api.orders.dto.response.OrderResDTO;
import com.jzo2o.api.orders.dto.response.OrderSimpleResDTO;
import com.jzo2o.common.enums.EnableStatusEnum;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.common.utils.ObjectUtils;
import com.jzo2o.orders.base.enums.OrderRefundStatusEnum;
import com.jzo2o.orders.base.enums.OrderStatusEnum;
import com.jzo2o.orders.base.mapper.OrdersCanceledMapper;
import com.jzo2o.orders.base.mapper.OrdersMapper;
import com.jzo2o.orders.base.mapper.OrdersRefundMapper;
import com.jzo2o.orders.base.model.domain.Orders;
import com.jzo2o.orders.base.model.domain.OrdersCanceled;
import com.jzo2o.orders.base.model.domain.OrdersRefund;
import com.jzo2o.orders.base.model.dto.OrderUpdateStatusDTO;
import com.jzo2o.orders.base.service.IOrdersCommonService;
import com.jzo2o.orders.manager.model.dto.OrderCancelDTO;
import com.jzo2o.orders.manager.service.IOrdersManagerService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

import static com.jzo2o.orders.base.constants.FieldConstants.SORT_BY;

/**
 * <p>
 * 订单表 服务实现类
 * </p>
 *
 * @author itcast
 * @since 2023-07-10
 */
@Slf4j
@Service
public class OrdersManagerServiceImpl extends ServiceImpl<OrdersMapper, Orders> implements IOrdersManagerService {

    @Resource
    private IOrdersManagerService owner;

    @Resource
    private IOrdersCommonService ordersCommonService;

    @Resource
    private OrdersCanceledMapper ordersCanceledMapper;

    @Resource
    private OrdersRefundMapper ordersRefundMapper;

    private TransactionTemplate transactionTemplate;

    @Override
    public List<Orders> batchQuery(List<Long> ids) {
        LambdaQueryWrapper<Orders> queryWrapper = Wrappers.<Orders>lambdaQuery().in(Orders::getId, ids).ge(Orders::getUserId, 0);
        return baseMapper.selectList(queryWrapper);
    }

    @Override
    public Orders queryById(Long id) {
        return baseMapper.selectById(id);
    }

    /**
     * 滚动分页查询
     *
     * @param currentUserId 当前用户id
     * @param ordersStatus  订单状态，0：待支付，100：派单中，200：待服务，300：服务中，400：待评价，500：订单完成，600：已取消，700：已关闭
     * @param sortBy        排序字段
     * @return 订单列表
     */
    @Override
    public List<OrderSimpleResDTO> consumerQueryList(Long currentUserId, Integer ordersStatus, Long sortBy) {
        // 1.构件查询条件
        LambdaQueryWrapper<Orders> queryWrapper = Wrappers.<Orders>lambdaQuery()
                .eq(ObjectUtils.isNotNull(ordersStatus), Orders::getOrdersStatus, ordersStatus)
                .lt(ObjectUtils.isNotNull(sortBy), Orders::getSortBy, sortBy)
                .eq(Orders::getUserId, currentUserId)
                .eq(Orders::getDisplay, EnableStatusEnum.ENABLE.getStatus());
        Page<Orders> queryPage = new Page<>();
        queryPage.addOrder(OrderItem.desc(SORT_BY));
        queryPage.setSearchCount(false);

        // 2.查询订单列表
        Page<Orders> ordersPage = baseMapper.selectPage(queryPage, queryWrapper);
        List<Orders> records = ordersPage.getRecords();
        List<OrderSimpleResDTO> orderSimpleResDTOS = BeanUtil.copyToList(records, OrderSimpleResDTO.class);
        return orderSimpleResDTOS;

    }
    /**
     * 根据订单id查询
     *
     * @param id 订单id
     * @return 订单详情
     */
    @Override
    public OrderResDTO getDetail(Long id) {
        Orders orders = queryById(id);
        OrderResDTO orderResDTO = BeanUtil.toBean(orders, OrderResDTO.class);
        return orderResDTO;
    }

    /**
     * 订单评价
     *
     * @param ordersId 订单id
     */
    @Override
    @Transactional
    public void evaluationOrder(Long ordersId) {
//        //查询订单详情
//        Orders orders = queryById(ordersId);
//
//        //构建订单快照
//        OrderSnapshotDTO orderSnapshotDTO = OrderSnapshotDTO.builder()
//                .evaluationTime(LocalDateTime.now())
//                .build();
//
//        //订单状态变更
//        orderStateMachine.changeStatus(orders.getUserId(), orders.getId().toString(), OrderStatusChangeEventEnum.EVALUATE, orderSnapshotDTO);
    }

    @Override
    public void cancel(OrderCancelDTO orderCancelDTO) {
        // 1. 根据订单id查询订单信息, 如果不存在, 直接报错
        Orders orders = this.getById(orderCancelDTO.getId());
        if (ObjectUtils.isNull(orders)) {
            throw new ForbiddenOperationException("订单不存在");
        }
        // 2. 根据订单状态 去分别编写两种情况取消订单的逻辑
        BeanUtil.copyProperties(orders, orderCancelDTO);
        if (ObjUtil.equal(orders.getOrdersStatus(), OrderStatusEnum.NO_PAY.getStatus())) {
            // 取消待支付订单: 1) 更新订单状态为已取消  2) 保存取消订单记录
//            owner.cancelByNoPay(orderCancelDTO);
            transactionTemplate.execute(status -> {
                OrderUpdateStatusDTO orderUpdateStatusDTO = OrderUpdateStatusDTO.builder()
                        .id(orderCancelDTO.getId())   // 订单id
                        .originStatus(OrderStatusEnum.NO_PAY.getStatus())   // 原始状态
                        .targetStatus(OrderStatusEnum.CANCELED.getStatus())   // 目标状态
                        .build();
                this.saveCanceledOrderInfo(orderCancelDTO, orderUpdateStatusDTO);
                return null;
            });
        } else if (ObjUtil.equal(orders.getOrdersStatus(), OrderStatusEnum.DISPATCHING.getStatus())) {
            // 取消派单中订单: 1) 更新订单状态为已关闭  2) 保存取消订单记录  3) 保存待退款的记录
//            owner.cancelByDispatching(orderCancelDTO);
            transactionTemplate.execute(status -> {
                // 更新订单状态为已关闭
                OrderUpdateStatusDTO orderUpdateStatusDTO = OrderUpdateStatusDTO.builder()
                        .id(orderCancelDTO.getId())   // 订单id
                        .originStatus(OrderStatusEnum.DISPATCHING.getStatus())   // 原始状态
                        .targetStatus(OrderStatusEnum.CLOSED.getStatus())   // 目标状态
                        .refundStatus(OrderRefundStatusEnum.REFUNDING.getStatus())   // 退款状态
                        .build();
                this.saveCanceledOrderInfo(orderCancelDTO, orderUpdateStatusDTO);
                // 保存待退款的记录
                OrdersRefund ordersRefund =  BeanUtil.copyProperties(orderCancelDTO,OrdersRefund.class);
                ordersRefundMapper.insert(ordersRefund);
                return null;
            });
        } else {
            throw new ForbiddenOperationException("当前状态订单暂不支持取消");
        }
    }

    @Override
    @Deprecated
    @Transactional(rollbackFor = Exception.class)
    public void cancelByNoPay(OrderCancelDTO orderCancelDTO) {
        // 更新订单状态为已取消
        OrderUpdateStatusDTO orderUpdateStatusDTO = OrderUpdateStatusDTO.builder()
                .id(orderCancelDTO.getId())   // 订单id
                .originStatus(OrderStatusEnum.NO_PAY.getStatus())   // 原始状态
                .targetStatus(OrderStatusEnum.CANCELED.getStatus())   // 目标状态
                .build();
        this.saveCanceledOrderInfo(orderCancelDTO, orderUpdateStatusDTO);
    }

    @Override
    @Deprecated
    @Transactional(rollbackFor = Exception.class)
    public void cancelByDispatching(OrderCancelDTO orderCancelDTO) {
        // 更新订单状态为已关闭
        OrderUpdateStatusDTO orderUpdateStatusDTO = OrderUpdateStatusDTO.builder()
                .id(orderCancelDTO.getId())   // 订单id
                .originStatus(OrderStatusEnum.DISPATCHING.getStatus())   // 原始状态
                .targetStatus(OrderStatusEnum.CLOSED.getStatus())   // 目标状态
                .refundStatus(OrderRefundStatusEnum.REFUNDING.getStatus())   // 退款状态
                .build();
        this.saveCanceledOrderInfo(orderCancelDTO, orderUpdateStatusDTO);

        // 保存待退款的记录
        OrdersRefund ordersRefund =  BeanUtil.copyProperties(orderCancelDTO,OrdersRefund.class);
        ordersRefundMapper.insert(ordersRefund);
    }

    /**
     * 保存取消订单信息
     *
     * @param orderCancelDTO
     * @param orderUpdateStatusDTO
     */
    private void saveCanceledOrderInfo(OrderCancelDTO orderCancelDTO, OrderUpdateStatusDTO orderUpdateStatusDTO) {
        int i = ordersCommonService.updateStatus(orderUpdateStatusDTO);
        if (i <= 0) {
            throw new ForbiddenOperationException("订单取消失败");
        }
        // 保存取消订单记录
        OrdersCanceled ordersCanceled = new OrdersCanceled();
        ordersCanceled.setId(orderCancelDTO.getId());//订单id
        ordersCanceled.setCancellerId(orderCancelDTO.getCurrentUserId());//取消人
        ordersCanceled.setCancelerName(orderCancelDTO.getCurrentUserName());//取消人名称
        ordersCanceled.setCancellerType(orderCancelDTO.getCurrentUserType());//取消人类型，1：普通用户，4：运营人员
        ordersCanceled.setCancelReason(orderCancelDTO.getCancelReason());//取消原因
        ordersCanceled.setCancelTime(LocalDateTime.now());//取消时间
        ordersCanceledMapper.insert(ordersCanceled);
    }

}