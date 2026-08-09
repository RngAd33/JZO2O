package com.jzo2o.foundations.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.foundations.model.domain.Serve;
import com.jzo2o.foundations.model.dto.request.ServePageQueryReqDTO;
import com.jzo2o.foundations.model.dto.request.ServeUpsertReqDTO;
import com.jzo2o.foundations.model.dto.response.ServeResDTO;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

/**
 * 区域服务接口
 */
public interface IServeService extends IService<Serve> {

    /**
     * 区域服务分页查询
     *
     * @param servePageQueryReqDTO
     * @return
     */
    PageResult<ServeResDTO> page(ServePageQueryReqDTO servePageQueryReqDTO);

    /**
     * 区域服务新增
     *
     * @param dtoList 区域服务集合
     */
    void add(List<ServeUpsertReqDTO> dtoList);

    /**
     * 区域服务删除
     *
     * @param id 区域服务id
     */
    void deleteById(Long id);

    /**
     * 区域服务上架
     *
     * @param id 区域服务id
     */
    void onSale(Long id);

    /**
     * 区域服务下架
     *
     * @param id
     */
    void offSale(Long id);

    void offHot(Long id);

}