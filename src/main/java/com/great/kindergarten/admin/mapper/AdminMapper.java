package com.great.kindergarten.admin.mapper;

import com.great.kindergarten.commons.entity.TblAdmin;
import com.great.kindergarten.commons.entity.TblMenu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


/**
 * @author LXC
 */

@Mapper
public interface AdminMapper {

	/**
	 * @param adminname
	 * @return
	 */
	public String findAdminStatus(@Param(value="adminname")String adminname);

	/**
	 * @param tblAdmin
	 * @return
	 */
	public TblAdmin adminLogin(TblAdmin tblAdmin);

	public List<TblAdmin> findAdminByName(String name);

	public List<TblMenu> findMenuByName(String name);

	public List<TblMenu> findMenuBySid(Integer sid);

	public String findRoleByRid(Integer rid);

}
