package com.allinfnt.idc.modules.msg.service;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.utils.SpringContextHolder;
import com.allinfnt.idc.common.utils.StringUtils;
import com.google.common.base.Strings;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * 邮件服务类. 由Freemarker引擎生成的的html格式邮件, 并带有附件.
 * 
 * @author peng.liao
 */
public class MailService {

	private static final String DEFAULT_ENCODING = "utf-8";
	private static Logger logger = LoggerFactory.getLogger(MailService.class);
	private JavaMailSender mailSender;
	private Configuration freemarkerConfiguration;
	private Template template;

	/**
	 * 发送MIME格式的邮件.
	 */
	public boolean sendTemplateMail(Map<String, String> map) throws Exception {
		boolean isSuccess = false;
		MimeMessage msg = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(msg, true,
				DEFAULT_ENCODING);

		if (Strings.isNullOrEmpty(map.get("mailTo"))) {
			logger.warn("邮件地址为空");
		}
		helper.setTo(map.get("mailTo").split(","));
		if (StringUtils.isNotBlank(map.get("mailCc"))) {
			helper.setCc(map.get("mailCc").split(","));
		}
		if (StringUtils.isNotBlank(map.get("mailBcc"))) {
			helper.setBcc(map.get("mailBcc").split(","));
		}

		helper.setFrom(Global.getConfig("mail.username"),
				Global.getConfig("productName"));
		helper.setSubject(map.get("subject"));
		String content = map.get("message");
		if (map.get("message").indexOf("<body>") < 0) {
			content = generateContent(map);
		}
		// helper.setText(map.get("message"), true);
		helper.setText(content, true);

		mailSender.send(msg);

		isSuccess = true;
		logger.debug("邮件已发送至" + map.get("mailTo"));

		return isSuccess;
	}

	/**
	 * 使用Freemarker生成html格式内容.
	 */
	public String generateContent(Map<String, String> context)
			throws MessagingException {
		try {
			if (freemarkerConfiguration == null) {
				freemarkerConfiguration = SpringContextHolder
						.getBean("freemarkerConfiguration");
			}
			String templateName = context.get("template");
			if (templateName == null) {
				templateName = "email/mailTemplate.ftl";
			}
			template = freemarkerConfiguration.getTemplate(templateName,
					DEFAULT_ENCODING);
			return FreeMarkerTemplateUtils.processTemplateIntoString(template,
					context);
		} catch (IOException e) {
			logger.error("生成邮件内容失败, FreeMarker模板不存在", e);
			throw new MessagingException("FreeMarker模板不存在", e);
		} catch (TemplateException e) {
			logger.error("生成邮件内容失败, FreeMarker处理失败", e);
			throw new MessagingException("FreeMarker处理失败", e);
		}
	}

	/**
	 * 获取classpath中的附件.
	 */
	private File generateAttachment() throws MessagingException {
		try {
			Resource resource = new ClassPathResource(
					"/email/mailAttachment.txt");
			return resource.getFile();
		} catch (IOException e) {
			logger.error("构造邮件失败,附件文件不存在", e);
			throw new MessagingException("附件文件不存在", e);
		}
	}

	/**
	 * Spring的MailSender.
	 */
	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	public JavaMailSender getMailSender() {
		return mailSender;
	}

	/**
	 * 注入Freemarker引擎配置,构造Freemarker 邮件内容模板.
	 */
	public void setFreemarkerConfiguration(Configuration freemarkerConfiguration)
			throws IOException {
		this.freemarkerConfiguration = freemarkerConfiguration;

	}
}
