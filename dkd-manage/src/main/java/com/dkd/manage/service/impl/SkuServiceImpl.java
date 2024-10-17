package com.dkd.manage.service.impl;

import java.util.List;

import com.dkd.common.exception.ServiceException;
import com.dkd.common.utils.DateUtils;
import com.dkd.manage.mapper.ChannelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dkd.manage.mapper.SkuMapper;
import com.dkd.manage.domain.Sku;
import com.dkd.manage.service.ISkuService;

/**
 * 商品管理Service业务层处理
 *
 * @author hlxllo
 * @date 2024-10-17
 */
@Service
public class SkuServiceImpl implements ISkuService {
    @Autowired
    private SkuMapper skuMapper;

    @Autowired
    private ChannelMapper channelMapper;

    /**
     * 查询商品管理
     *
     * @param skuId 商品管理主键
     * @return 商品管理
     */
    @Override
    public Sku selectSkuBySkuId(Long skuId) {
        return skuMapper.selectSkuBySkuId(skuId);
    }

    /**
     * 查询商品管理列表
     *
     * @param sku 商品管理
     * @return 商品管理
     */
    @Override
    public List<Sku> selectSkuList(Sku sku) {
        return skuMapper.selectSkuList(sku);
    }

    /**
     * 新增商品管理
     *
     * @param sku 商品管理
     * @return 结果
     */
    @Override
    public int insertSku(Sku sku) {
        sku.setCreateTime(DateUtils.getNowDate());
        return skuMapper.insertSku(sku);
    }

    /**
     * 修改商品管理
     *
     * @param sku 商品管理
     * @return 结果
     */
    @Override
    public int updateSku(Sku sku) {
        sku.setUpdateTime(DateUtils.getNowDate());
        return skuMapper.updateSku(sku);
    }

    /**
     * 批量删除商品管理
     *
     * @param skuIds 需要删除的商品管理主键
     * @return 结果
     */
    @Override
    public int deleteSkuBySkuIds(Long[] skuIds) {
        // 判断是否有商品和货道关联
        int count = channelMapper.countChannelBySkuIds(skuIds);
        // 没有关联才删除
        if (count > 0) {
            throw new ServiceException("商品和货道关联，无法删除");
        }
        return skuMapper.deleteSkuBySkuIds(skuIds);
    }

    /**
     * 删除商品管理信息
     *
     * @param skuId 商品管理主键
     * @return 结果
     */
    @Override
    public int deleteSkuBySkuId(Long skuId) {
        return skuMapper.deleteSkuBySkuId(skuId);
    }

    /**
     * 批量插入商品管理
     * @param skuList
     * @return 插入数量
     */
    public int batchInsertSkus(List<Sku> skuList) {
        return skuMapper.batchInsertSkus(skuList);
    }
}
