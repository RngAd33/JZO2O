package com.jzo2o.foundations.controller.operation;

import com.jzo2o.common.annotation.NoWriteService;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.common.model.Result;
import com.jzo2o.foundations.enums.FoundationStatusEnum;
import com.jzo2o.foundations.model.domain.Serve;
import com.jzo2o.foundations.model.dto.request.ServePageQueryReqDTO;
import com.jzo2o.foundations.model.dto.request.ServeUpsertReqDTO;
import com.jzo2o.foundations.model.dto.response.ServeResDTO;
import com.jzo2o.foundations.model.dto.response.ServeSimpleResDTO;
import com.jzo2o.foundations.service.IServeService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 区域服务接口
 */
@RestController("operationServeController")
@RequestMapping("/operation/serve")
public class ServeController {

    @Resource
    private IServeService serveService;

    @GetMapping("/page")
    @ApiOperation("区域分页查询")
    public PageResult<ServeResDTO> page(ServePageQueryReqDTO servePageQueryReqDTO) {
        return serveService.page(servePageQueryReqDTO);
    }

    @PostMapping("/batch")
    @ApiOperation("区域服务新增")
    public Result add(@RequestBody List<ServeUpsertReqDTO> dtoList) {
        serveService.add(dtoList);
        return Result.ok();
    }

    @NoWriteService
    @PutMapping("/{id}")
    @ApiOperation("区域服务修改价格")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "区域服务id", required = true, dataTypeClass = Long.class),
            @ApiImplicitParam(name = "price", value = "区域服务修改之后的价格", required = true, dataTypeClass = BigDecimal.class)
    })
    public void update(@PathVariable("id") Long id, BigDecimal price) {
        Serve serve = new Serve();
        serve.setId(id);
        serve.setPrice(price);
        serveService.updateById(serve);   // mp 动态 SQL：update serve set price = ? where id = ?
    }

    @DeleteMapping("/{id}")
    @ApiOperation("区域服务删除")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "区域服务id", required = true, dataTypeClass = Long.class)
    })
    public void delete(@PathVariable("id") Long id) {
        serveService.deleteById(id);
    }

    @PutMapping("/onSale/{id}")
    @ApiOperation("区域服务上架")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "区域服务id", required = true, dataTypeClass = Long.class)
    })
    public void onSale(@PathVariable("id") Long id) {
        serveService.onSale(id);
    }

    @PutMapping("/offSale/{id}")
    @ApiOperation("区域服务下架")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "区域服务id", required = true, dataTypeClass = Long.class)
    })
    public void offSale(@PathVariable("id") Long id) {
        serveService.offSale(id);
    }

    @NoWriteService
    @PutMapping("/onHot/{id}")
    @ApiOperation("设置热门")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "区域服务id", required = true, dataTypeClass = Long.class)
    })
    public void onHot(@PathVariable("id") Long id) {
        Serve serve = new Serve();
        serve.setId(id);
        serve.setHotTimeStamp(new Date().getTime());
        serve.setIsHot(FoundationStatusEnum.ENABLE.getStatus());
        serveService.updateById(serve);
    }

    @NoWriteService
    @PutMapping("/offHot/{id}")
    @ApiOperation("取消热门")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "区域服务id", required = true, dataTypeClass = Long.class)
    })
    public void offHot(@PathVariable("id") Long id) {
        Serve serve = new Serve();
        serve.setId(id);
        serve.setIsHot(FoundationStatusEnum.DISABLE.getStatus());
        serveService.updateById(serve);
    }

    @GetMapping("/search")
    @ApiOperation("服务搜索")
    public List<ServeSimpleResDTO> search(String cityCode, String keyword, Long serveTypeId) {
        return serveService.search(cityCode, keyword, serveTypeId);
    }

}