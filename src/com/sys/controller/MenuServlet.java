package com.sys.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.sys.entity.Menu;
import com.sys.service.impl.MenuServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: xueYaDong
 * @Company: 东方标准
 * @Date: 2019/11/29/16:30
 * @Description:
 */
@WebServlet("/sys/menu")
public class MenuServlet extends BaseServlet {

    private MenuServiceImpl service = new MenuServiceImpl();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException {

        List<Menu> list = service.listAll();

        //lambda 一级菜单
        List<Menu> listParent = list.stream().filter(m -> m.getType().equals("1")).collect(Collectors.toList());
        //二级菜单
        List<Menu> listSon = list.stream().filter(m -> m.getType().equals("2")).collect(Collectors.toList());

        Map<String, List<Menu>> map = new HashMap<>();
        map.put("parent", listParent);
        map.put("son", listSon);

        String mapJsonStr = JSON.toJSONString(map);
        JSON.parseObject(mapJsonStr, new TypeReference<Map<String, List<Menu>>>() {});
        PrintWriter out = response.getWriter();
        out.append(mapJsonStr);


//        for (int i = 0; i < list.size(); i++) {
//            if (list.get(i).getType().equals("1")) {
//                listParent.add(list.get(i));
//            }
//
//            if (list.get(i).getType().equals("2")) {
//                listSon.add(list.get(i));
//            }
//        }



    }
}
