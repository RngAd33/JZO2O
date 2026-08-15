package com.jzo2o.orders.base.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jzo2o.orders.base.model.domain.ServeProviderSync;

/**
 * <p>
 * 机构服务端更新服务时间 Mapper 接口
 * </p>
 *
 * @author itcast
 * @since 2023-08-09
 */
public interface ServeProviderSyncMapper extends BaseMapper<ServeProviderSync> {

//    @Update("update serve_provider_sync set serve_times=JSON_ARRAY_APPEND(serve_times,'$',#{serveTime})," +
//            "acceptance_num=acceptance_num+1 where id=#{id}")
//    int addServeTimes(@Param("id")Long id, @Param("serveTime") Integer serveTime);
}
