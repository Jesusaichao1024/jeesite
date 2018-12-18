/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.oa.entity.OaNotifyRecord;
import com.thinkgem.jeesite.modules.oa.entity.Version;

import java.util.List;

/**
 * 通知通告记录DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface VersionDao extends CrudDao<Version>{

	/**
	 * 添加数据
	 *
	 * @param version
	 * @return
	 */
	int insertAll(List<Version> version);

	/**
	 * 物理删除
	 * @param versionId
	 * @return
	 */
	int deleteByVersionId(String versionId);
}