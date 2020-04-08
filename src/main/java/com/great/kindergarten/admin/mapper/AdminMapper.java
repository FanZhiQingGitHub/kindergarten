package com.great.kindergarten.admin.mapper;

import com.great.kindergarten.commons.entity.TblAdmin;
import com.great.kindergarten.commons.entity.TblKinder;
import com.great.kindergarten.commons.entity.TblMenu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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

	public TblAdmin findTblAdminByName(String name);

	public List<TblMenu> findMenuByName(String name);

	public List<TblMenu> findMenuBySid(Integer sid);

	public String findRoleByRid(Integer rid);

	public int updateAdminPwd(Map<String,String> adminMap);

	public List<TblKinder> findAllKinder(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findAllCount(HashMap<String, Object> condition);

	public int checkQualify(String kinderstatus, Integer kinderid, Date kinderapptime);

}
