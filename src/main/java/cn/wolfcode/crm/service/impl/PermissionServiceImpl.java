package cn.wolfcode.crm.service.impl;

import cn.wolfcode.crm.domain.Permission;
import cn.wolfcode.crm.mapper.PermissionMapper;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.service.IPermissionService;
import cn.wolfcode.crm.util.RequiredPermission;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import java.lang.reflect.Method;
import java.util.Collection;
import java.util.List;
import java.util.Map;

@Service
public class PermissionServiceImpl implements IPermissionService {
    @Autowired
    private PermissionMapper permissionMapper;
    //注入spring上下文
    @Autowired
    private ApplicationContext ctx;

    @Override
    public void save(Permission entry) {
        permissionMapper.insert(entry);
    }

    @Override
    public void delete(Long id) {
        permissionMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Permission entry) {
        permissionMapper.updateByPrimaryKey(entry);
    }

    @Override
    public Permission get(Long id) {
        return permissionMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Permission> listAll() {
        return permissionMapper.selectAll();
    }

    @Override
    public PageInfo<Permission> query(QueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<Permission> list = permissionMapper.selectForList(qo);
        return new PageInfo<Permission>(list);
    }

    /**
     * 当用户更新权限的时候自动生成权限列表
     */
    @Override
    public void onload() {

        List<String> list = permissionMapper.selectAllExpression();

        //1.获取到Spring容器对象
        Map<String, Object> beansWithAnnotation = ctx.getBeansWithAnnotation(Controller.class);
        //2.从容器中获取到所有的Controller对象
        Collection<Object> values = beansWithAnnotation.values();
        //3.获取Controller对象中的所有的方法
        for (Object value : values) {
            Method[] methods = value.getClass().getDeclaredMethods();
            for (Method method : methods) {
                //4.判断每个方法是否有贴@RequiredPermission注解
                if (method.isAnnotationPresent(RequiredPermission.class)) {
                    RequiredPermission annotation = method.getAnnotation(RequiredPermission.class);
                    String[] experssions = annotation.value();
                    String expression = experssions[1];
                    //贴了:生成权限信息
                    if (list.contains(expression)) {
                        continue;
                    }
                    Permission permission = new Permission();
                    permission.setName(experssions[0]);
                    permission.setExpression(experssions[1]);
                    //5.将权限信息保存到数据库中
                    permissionMapper.insert(permission);
                }
            }
        }

    }

    @Override
    public void deletePermissonRole(Long permissonId) {
        permissionMapper.deletePermissonRole(permissonId);
    }
}
