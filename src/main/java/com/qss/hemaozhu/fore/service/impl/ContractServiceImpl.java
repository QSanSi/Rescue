package com.qss.hemaozhu.fore.service.impl;

import com.qss.hemaozhu.admin.mapper.DeptMapper;
import com.qss.hemaozhu.common.model.R;
import com.qss.hemaozhu.common.service.FileService;
import com.qss.hemaozhu.fore.entity.Contract;
import com.qss.hemaozhu.fore.entity.Pet;
import com.qss.hemaozhu.fore.entity.Revisit;
import com.qss.hemaozhu.fore.mapper.ContractMapper;
import com.qss.hemaozhu.fore.mapper.PetMapper;
import com.qss.hemaozhu.fore.mapper.RevisitMapper;
import com.qss.hemaozhu.fore.service.IContractService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author qss
 * @since 2020-04-05
 */
@Service
public class ContractServiceImpl extends ServiceImpl<ContractMapper, Contract> implements IContractService {
	@Autowired
	private ContractMapper conMapper;
	@Autowired
	private DeptMapper deptMapper;
	@Autowired
	private PetMapper petMapper;
	@Autowired
	private RevisitMapper rvMapper;
	@Autowired
	private FileService fileService;
	@Override
	public <E extends IPage<Contract>> E page(E page, Wrapper<Contract> queryWrapper) {
		getBaseMapper().selectPage(page, queryWrapper);
		List<Contract> conlist = page.getRecords();
		if(conlist.isEmpty()) {
			conlist = new ArrayList<>();
		}
		for (Contract con : conlist) {
			con.setDept(deptMapper.selectById(con.getDeptId()));
			con.setPet(petMapper.selectById(con.getPetId()));
		}
		page.setRecords(conlist);
		return page;
	}
	@Override
	@Transactional
	public R add(Contract con, MultipartFile file1, MultipartFile file2) {
		String contract;
		String agreement;
		try {
			if(!file1.getOriginalFilename().isEmpty()) {
				contract = fileService.uploadcontract(file1);
				con.setContract(contract);
			}
			if(!file2.getOriginalFilename().isEmpty()) {
				agreement = fileService.uploadagreement(file2);
				con.setAgreement(agreement);
			}
			this.save(con);
			Pet pet = petMapper.selectById(con.getPetId());
			pet.setStatus(1);
			petMapper.updateById(pet);
			return R.ok();
		} catch (IOException e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
    }
	@Override
	@Transactional
	public R updateall(Contract con, MultipartFile file1, MultipartFile file2) {
		String contract;
		String agreement;
		Contract lastcon = conMapper.selectById(con.getContractId());
		Pet lastpet = petMapper.selectById(lastcon.getPetId());
		lastpet.setStatus(0);
		petMapper.updateById(lastpet);
		try {
			if(file1 != null && !file1.getOriginalFilename().isEmpty()) {
				if(conMapper.selectById(con).getContract() != null) {
					fileService.delFile(conMapper.selectById(con).getContract());
				}
				contract = fileService.uploadcontract(file1);
				con.setContract(contract);
			}
			if(!file2.getOriginalFilename().isEmpty()) {
				if(conMapper.selectById(con).getAgreement() != null) {
					fileService.delFile(conMapper.selectById(con).getAgreement());
				}
				agreement = fileService.uploadagreement(file2);
				con.setAgreement(agreement);
			}
			Pet pet = petMapper.selectById(con.getPetId());
			pet.setStatus(1);
			petMapper.updateById(pet);
			this.updateById(con);
			return R.ok();
		} catch (IOException e) {
			e.printStackTrace();
			return R.error(e.getMessage());
		}
	}
	
	@Override
	@Transactional
	public boolean removeById(Serializable id) {
		Contract con = conMapper.selectById(id);
		Pet lastpet = petMapper.selectById(con.getPetId());
		lastpet.setStatus(0);
		petMapper.updateById(lastpet);
		if(con.getContract() != null) {
			fileService.delFile(con.getContract());
		}
		if(con.getAgreement() != null) {
			fileService.delFile(con.getAgreement());
		}
		QueryWrapper<Revisit> param = new QueryWrapper<>();
		param.eq("contract_id", id);
		rvMapper.delete(param);
		return super.removeById(id);
	}
	
	@Override
	@Transactional
	public boolean removeByIds(Collection<? extends Serializable> idList) {
		for (Serializable id : idList) {
			removeById(id);
		}
		return super.removeByIds(idList);
	}
}

