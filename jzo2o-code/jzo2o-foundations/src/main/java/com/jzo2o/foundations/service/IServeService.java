package com.jzo2o.foundations.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jzo2o.api.foundations.dto.response.ServeAggregationResDTO;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.foundations.model.domain.Serve;
import com.jzo2o.foundations.model.dto.request.ServePageQueryReqDTO;
import com.jzo2o.foundations.model.dto.request.ServeUpsertReqDTO;
import com.jzo2o.foundations.model.dto.response.*;

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

    /**
     * 首页服务分类及项目
     *
     * @param regionId
     * @return
     */
    List<ServeCategoryResDTO> firstPageServeList(Long regionId);

    /**
     * 精选推荐
     *
     * @param regionId
     * @return
     */
    List<ServeAggregationSimpleResDTO> hotServeList(Long regionId);

    /**
     * 查询当前区域下上架服务对应的分类
     *
     * @param regionId
     * @return
     */
    List<ServeAggregationTypeSimpleResDTO> serveTypeList(Long regionId);

    /**
     * 搜索
     *
     * @param cityCode
     * @param keyword
     * @param serveTypeId
     * @return
     */
    List<ServeSimpleResDTO> search(String cityCode, String keyword, Long serveTypeId);

    /**
     * 根据ID查询服务详情
     *
     * @param id
     * @return
     */
    ServeAggregationResDTO findServeDetailById(Long id);

}