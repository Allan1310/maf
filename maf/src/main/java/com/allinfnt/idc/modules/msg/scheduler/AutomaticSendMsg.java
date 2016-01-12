package com.allinfnt.idc.modules.msg.scheduler;

import java.util.Date;
import java.util.List;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.allinfnt.idc.modules.msg.entity.Msginfo;
import com.allinfnt.idc.modules.msg.service.MsginfoService;

public class AutomaticSendMsg extends QuartzJobBean {

	private MsginfoService msginfoService;

	/**
	 * @author 彭振
	 * @memo 说明:每分钟查询数据库中是否有未发送信息
	 */
	@Override
	protected void executeInternal(JobExecutionContext cont)
			throws JobExecutionException {
		try {
			SchedulerContext sked = cont.getScheduler().getContext();
			msginfoService = (MsginfoService) sked.get("msginfoService");

			List<Msginfo> findList = msginfoService.findBybackflag("0");
			if (findList != null && findList.size() > 0) {
				for (Msginfo msginfo : findList) {
					if (msginfo.getPlanTime() != null
							&& msginfo.getPlanTime().before(new Date())) {

						if (msginfo.getBackFlag().equals("0")) {
							msginfo.setBackFlag("1");
							msginfoService.save(msginfo);
							msginfoService.realSendMsg(msginfo);
						}

					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
