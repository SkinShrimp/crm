package cn.wolfcode.crm.mapper;

import cn.wolfcode.crm.domain.Role;
import cn.wolfcode.crm.query.QueryObject;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

public interface RoleMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Role record);

    Role selectByPrimaryKey(Long id);

    List<Role> selectAll();

    int updateByPrimaryKey(Role record);

    List<Role> selectForList(QueryObject qo);

    void deleteRolePermission(Long roleId);

    void insertRolePermission(@Param("permissionId") Long permissionId, @Param("roleId") Long roleId);

    void deleteRoleEmployee(Long roleId);

    Set<String> selectRolesSNByEmployeeId(Long EmployeeId);
}