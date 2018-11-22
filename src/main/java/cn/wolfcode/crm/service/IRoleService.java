package cn.wolfcode.crm.service;



import cn.wolfcode.crm.domain.Role;import cn.wolfcode.crm.query.QueryObject;import com.github.pagehelper.PageInfo;import java.util.List;public interface IRoleService {
    public abstract void save(Role entry, Long[] permissionIds);

    public abstract void delete(Long id);

    public abstract void update(Role entry, Long[] permissionIds);

    public abstract Role get(Long id);

    public abstract List<Role> listAll();

    //角色不支持高级查询
    public abstract PageInfo<Role> query(QueryObject qo);

    public abstract void deleteRolePermission(Long roleId);

    public abstract void insertRolePermission(Long permissionId, Long roleId);

    public abstract void deleteRoleEmployee(Long roleId);
}
