package com.pms.app.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pms.app.dao.IniPledgeRecordDao;
import com.pms.app.dao.IniPledgeRecordDetailDao;
import com.pms.app.dao.WarehouseDao;
import com.pms.app.entity.IniCheck;
import com.pms.app.entity.IniPledgeRecord;
import com.pms.app.entity.IniPledgeRecordDetail;
import com.pms.app.entity.IniRecord;
import com.pms.app.entity.PledgePurity;
import com.pms.app.entity.SupervisionCustomer;
import com.pms.app.entity.Warehouse;
import com.pms.app.entity.reference.CheckMethod;
import com.pms.app.util.CodeUtils;
import com.pms.base.dao.BaseDao;
import com.pms.base.service.BaseService;


@Service
public class IniPledgeRecordService extends BaseService<IniPledgeRecord, String>{
	
	@Autowired private IniPledgeRecordDao iniPledgeRecordDao;
	@Autowired private IniPledgeRecordDetailDao iniPledgeRecordDetailDao;
	@Autowired private PledgePurityService pledgePurityService;
	@Autowired private WarehouseDao warehouseDao;
	@Autowired private SupervisionCustomerService supervisionCustomerService;

	@Override
	protected BaseDao<IniPledgeRecord, String> getEntityDao() {
		return iniPledgeRecordDao;
	}

	public void save(List<IniRecord> iniRecordList, List<IniCheck> iniCheckList, String warehouseId) {
		if(iniRecordList.size() > 0 && iniCheckList.size() > 0) {
			List<IniPledgeRecordDetail> iniPledgeRecordDetailList = new ArrayList<IniPledgeRecordDetail>();
			IniPledgeRecord iniPledgeRecord = new IniPledgeRecord();
			iniPledgeRecord.setCode(CodeUtils.getPledgeRecordCode(warehouseId));
			Warehouse warehouse = warehouseDao.findOne(warehouseId);
			iniPledgeRecord.setWarehouse(warehouse);
			
			List<SupervisionCustomer> supervisionCustomers = supervisionCustomerService.findListByWarehouseId(warehouseId);
			if(!supervisionCustomers.isEmpty()) {
				iniPledgeRecord.setSupervisionCustomer(supervisionCustomers.get(0));
				iniPledgeRecord.setDelegator(supervisionCustomers.get(0).getDelegator());
			}
			
			PledgePurity pledgePurity = pledgePurityService.findOK();
			
			for (IniRecord iniRecord : iniRecordList) {
				IniPledgeRecordDetail iniPledgeRecordDetail = new IniPledgeRecordDetail();
				iniPledgeRecordDetail.setIniPledgeRecord(iniPledgeRecord);
				iniPledgeRecordDetail.setStyle(iniRecord.getStyle());
				iniPledgeRecordDetail.setPledgePurity(pledgePurity);
				iniPledgeRecordDetail.setSumWeight(iniRecord.getWeight());
				iniPledgeRecordDetail.setStorage(warehouse.getAddress());
				
				double gpWeight = 0.0;
				double rjWeight = 0.0;
				for (IniCheck iniCheck : iniCheckList) {
					if(iniCheck.getStyle().getId().equals(iniRecord.getStyle().getId())) {
						if(iniCheck.getCheckMethod() == CheckMethod.Spectrum) {
							gpWeight += iniCheck.getCheckWeight();
						}
						if(iniCheck.getCheckMethod() == CheckMethod.Dissolve) {
							rjWeight += iniCheck.getCheckWeight();
						}
					}
				}
				
				iniPledgeRecordDetail.setSpectrumRate(new BigDecimal(gpWeight / iniRecord.getWeight()).setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue());
				iniPledgeRecordDetail.setDissolveRate(new BigDecimal(rjWeight / iniRecord.getWeight()).setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue());
				
				iniPledgeRecordDetailList.add(iniPledgeRecordDetail);
			}
			
			iniPledgeRecordDao.save(iniPledgeRecord);
			iniPledgeRecordDetailDao.save(iniPledgeRecordDetailList);
			
		}
		
		
		
		
	}
	
	
	
}
