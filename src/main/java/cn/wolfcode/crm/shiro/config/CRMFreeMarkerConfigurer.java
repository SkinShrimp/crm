package cn.wolfcode.crm.shiro.config;

import com.jagregory.shiro.freemarker.ShiroTags;
import freemarker.template.Configuration;
import freemarker.template.TemplateException;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import java.io.IOException;

public class CRMFreeMarkerConfigurer extends FreeMarkerConfigurer {
    @Override
    public void afterPropertiesSet() throws IOException, TemplateException {
        super.afterPropertiesSet();
        Configuration configuration = getConfiguration();

        /*freeMarker中注册新的标签，注册扩展的标签库*/

        configuration.setSharedVariable("shiro", new ShiroTags());
    }
}
