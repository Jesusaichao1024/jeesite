package com.thinkgem.jeesite.modules.oa.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import java.util.Date;

public class Version extends DataEntity<Version> {
    //实例化
    private static final long serialVersionUID = 1L;
    //版本ID值
    private Integer versionId;
    //版本标题
    private String title;
    //版本号
    private String versions;
    //资源包名
    private String sourceName;
    //产品类型
    private Integer productType;
    //资源类型
    private Integer sourceType;
    //科目
    private String subject;
    //发布状态
    private Integer publishState;
    ////查阅状态
    private Integer viewState;
    //作者
    private String author;
    //创建时间
    private Date createTime;
    //修改时间
    private Date modifyTime;
    //发布时间
    private Date publishTime;
    //排序参数
    private Integer sort;
    //逻辑删除
    private Integer isDelete;

    @Override
    public String toString() {
        return "Version{" +
                "versionId=" + versionId +
                ", title='" + title + '\'' +
                ", versions='" + versions + '\'' +
                ", sourceName='" + sourceName + '\'' +
                ", productType=" + productType +
                ", sourceType=" + sourceType +
                ", subject='" + subject + '\'' +
                ", publishState=" + publishState +
                ", viewState=" + viewState +
                ", author='" + author + '\'' +
                ", createTime=" + createTime +
                ", modifyTime=" + modifyTime +
                ", publishTime=" + publishTime +
                ", sort=" + sort +
                ", isDelete=" + isDelete +
                '}';
    }

    public Integer getVersionId() {
        return versionId;
    }

    public void setVersionId(Integer versionId) {
        this.versionId = versionId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getVersions() {
        return versions;
    }

    public void setVersions(String versions) {
        this.versions = versions;
    }

    public String getSourceName() {
        return sourceName;
    }

    public void setSourceName(String sourceName) {
        this.sourceName = sourceName;
    }

    public Integer getProductType() {
        return productType;
    }

    public void setProductType(Integer productType) {
        this.productType = productType;
    }

    public Integer getSourceType() {
        return sourceType;
    }

    public void setSourceType(Integer sourceType) {
        this.sourceType = sourceType;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public Integer getPublishState() {
        return publishState;
    }

    public void setPublishState(Integer publishState) {
        this.publishState = publishState;
    }

    public Integer getViewState() {
        return viewState;
    }

    public void setViewState(Integer viewState) {
        this.viewState = viewState;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }
}
