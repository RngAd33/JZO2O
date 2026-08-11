package com.jzo2o.customer.service;

import com.jzo2o.api.customer.dto.response.AddressBookResDTO;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.customer.model.domain.AddressBook;
import com.jzo2o.customer.model.dto.request.AddressBookPageQueryReqDTO;
import com.jzo2o.customer.model.dto.request.AddressBookUpsertReqDTO;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 地址薄 服务类
 * </p>
 *
 * @author itcast
 * @since 2023-07-06
 */
public interface IAddressBookService extends IService<AddressBook> {

    /**
     * 根据用户id和城市编码获取地址
     *
     * @param userId 用户id
     * @param cityCode 城市编码
     * @return 地址编码
     */
    List<AddressBookResDTO> getByUserIdAndCity(Long userId, String cityCode);

    /**
     * 根据用户id和城市编码获取默认地址
     *
     * @return
     */
    AddressBookResDTO findDefaultAddress();

    /**
     * 根据用户id和城市编码获取地址薄分页列表
     *
     * @param addressBookUpsertReqDTO
     */
    void add(AddressBookUpsertReqDTO addressBookUpsertReqDTO);

    /**
     * 分页查询
     *
     * @param addressBookPageQueryReqDTO 查询参数
     * @return 分页列表
     */
    PageResult<AddressBookResDTO> page(AddressBookPageQueryReqDTO addressBookPageQueryReqDTO);

    /**
     * 根据id更新地址薄
     *
     * @param id
     * @param addressBookUpsertReqDTO
     */
    void updateAddressBook(Long id, AddressBookUpsertReqDTO addressBookUpsertReqDTO);

    /**
     * 根据id和flag更新地址薄
     *
     * @param id
     * @param flag
     */
    void updateDefaultStatus(Long id, Integer flag);

}