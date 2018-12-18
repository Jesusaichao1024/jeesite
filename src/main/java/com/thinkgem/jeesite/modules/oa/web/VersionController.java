/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.oa.web;

import com.sun.tools.javac.resources.version;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.oa.entity.OaNotify;
import com.thinkgem.jeesite.modules.oa.entity.Version;
import com.thinkgem.jeesite.modules.oa.service.OaNotifyService;
import com.thinkgem.jeesite.modules.oa.service.VersionService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 版本列表Controller
 * @author ThinkGem
 * @version 2014-05-16
 */
@Controller
@RequestMapping(value = "${adminPath}/oa/version")
public class VersionController extends BaseController {

	@Autowired
	private VersionService versionService;

	@ModelAttribute
	public Version get(@RequestParam(required=false) String id) {
		 Version version = null;
		if (StringUtils.isNotBlank(id)){
			version = versionService.get(id);
		}
		if (version == null){
			version = new Version();
		}
		return version;
	}

    /**
     * 查询所有的版本列表
	 * @param version
     * @param request
     * @param response
     * @param model
     * @return
     */
	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = {"list", ""})
	public String list(Version version, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Version> page = versionService.findPage(new Page<Version>(request, response), version);
		model.addAttribute("page", page);
		return "modules/oa/oaNotifyList";
	}

	/**
     * 上传资源
	 * @param version
     * @param model
     * @return
     */
	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = "form")
	public String form(Version version , Model model) {
		if (StringUtils.isNotBlank(version.getId())){
			  versionService.insert(version);
		}
		/*model.addAttribute("oaNotify", oaNotify);*/
		return "modules/oa/oaNotifyForm";
	}

	/**
     * 保存版本信息
	 * @param version
     * @param model
     * @param redirectAttributes
     * @return
     */
	@RequiresPermissions("oa:oaNotify:edit")
	@RequestMapping(value = "save")
	public String save(Version version, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, version)){
			return form(version, model);
		}
		// 如果是修改，则状态为已发布，则不能再进行操作
		if (StringUtils.isNotBlank(version.getId())){
			Version v = versionService.get(version.getId());
			if ("1".equals(v.getViewState())){
				addMessage(redirectAttributes, "已发布，不能操作！");
				return "redirect:" + adminPath + "/oa/oaNotify/form?id="+version.getId();
			}
		}
		versionService.save(version);
		addMessage(redirectAttributes, "保存通知'" + version.getTitle() + "'成功");
		return "redirect:" + adminPath + "/oa/oaNotify/?repage";
	}

    /**
     * 删除版本信息
	 * @param version
     * @param redirectAttributes
     * @return
     */
	@RequiresPermissions("oa:oaNotify:edit")
	@RequestMapping(value = "delete")
	public String delete(Version version, RedirectAttributes redirectAttributes) {
		versionService.delete(version);
		addMessage(redirectAttributes, "删除通知成功");
		return "redirect:" + adminPath + "/oa/oaNotify/?repage";
	}
	
	
}