package cn.wolfcode.crm.mapper;

import cn.wolfcode.crm.domain.SystemDictionary;
import cn.wolfcode.crm.query.QueryObject;

import java.util.List;

public interface SystemDictionaryMapper {
    public abstract int deleteByPrimaryKey(Long id);

    public abstract int insert(SystemDictionary record);

    public abstract SystemDictionary selectByPrimaryKey(Long id);

    public abstract List<SystemDictionary> selectAll();

    public abstract int updateByPrimaryKey(SystemDictionary record);

    public abstract List<SystemDictionary> selectForList(QueryObject qo);
}