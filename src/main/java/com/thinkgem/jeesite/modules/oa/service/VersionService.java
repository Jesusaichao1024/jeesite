package com.thinkgem.jeesite.modules.oa.service;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.oa.dao.VersionDao;
import com.thinkgem.jeesite.modules.oa.entity.Version;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

@Service
@Transactional(readOnly = true)
public class VersionService extends CrudService<VersionDao, Version> {
    @Autowired
    private VersionDao versionDao;

    public Version get(String versionId) {
        Version version = dao.get(versionId);
        return version;
    }


    /**
     * 分页查询版本信息列表
     * @param page 分页对象
     * @param version
     * @return
     */
    public Page<Version> findPage(Page<Version> page, Version version) {
        version.setPage(page);
        page.setList(dao.findList(version));
        return page;
    }

    /**
     * 保存版本信息
     * @param version
     */
    @Transactional(readOnly = false)
    public void save(Version version) {
        super.save(version);
    }

    /**
     * 更新内容
     * @param version
     */
    @Transactional(readOnly = false)
    public void update(Version version) {
        Version versions = new Version();
        versions.setCreateTime(new Date());
        versions.setModifyTime(new Date());
        versionDao.update(version);
    }

    /**
     * 添加数据
     * @param version
     */
    @Transactional(readOnly = false)
    public void insert(Version version) {
        Version versions = new Version();
        versions.setProductType(version.getProductType());
        versions.setSort(version.getSort());
        versions.setAuthor(version.getAuthor());
        versions.setVersions(version.getVersions());
        versions.setSourceName(version.getSourceName());
        versions.setSourceType(version.getSourceType());
        versions.setSubject(version.getSubject());
        versionDao.insert(versions);
    }
}
