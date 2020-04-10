package com.great.kindergarten.parent.service;

import com.great.kindergarten.commons.entity.SearchCondition;
import com.great.kindergarten.commons.entity.TableDate;
import com.great.kindergarten.commons.entity.TblParent;
import com.great.kindergarten.commons.entity.Result;
import com.great.kindergarten.parent.mapper.ParentMapper;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

/**
 * @author Administrator
 */
@Service
public class ParentService {

    @Resource
    private ParentMapper parentMapper;

    public ParentService()
    {

    }


    /**
     * 根据id和条件找到安全视频列表
     * @param searchCondition
     * @return
     */
    public TableDate parentSafetyTestList(SearchCondition searchCondition){
        TableDate result = new TableDate();

        //计算总共的页数
        result.setCount(parentMapper.countVideoListNumber(searchCondition));
        //放入查询的数据
        result.setData( parentMapper.findVideoList(searchCondition));

        return result;
    }














    /**
     * 家长根据旧密码修改新密码
     * @param parentId
     * @param parentOldPwd
     * @param parentNewPwd
     * @return
     */
    public Result updateParentPwd(Integer parentId ,String parentOldPwd ,String parentNewPwd){
        Result updateResult = new Result();

        //判断数据是否完整
        if (parentId!=null&&parentOldPwd!=null&&!"".equals(parentOldPwd)&&parentNewPwd!=null&&!"".equals(parentNewPwd)){
            //判断旧密码是否输入正确
            if (parentMapper.countOldParentPwd(parentOldPwd,parentId)>0){
                //判断更改密码是否成功
                if(parentMapper.updateParentPwd(parentNewPwd,parentId)>0){
                    //修改成功
                    updateResult.setSuccess(true);
                }
            }else {
                updateResult.setMsg("oldPwdError");
            }

        }else {
            updateResult.setMsg("error");
        }

        return updateResult;
    }



    /**
     * 家长端口登陆方法
     * @param parentName
     * @param parentPwd
     * @return
     */
    public TblParent parentLogin(String parentName, String parentPwd){
        return parentMapper.parentLogin(parentName,parentPwd);
    }





}
