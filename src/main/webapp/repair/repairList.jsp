<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>报修列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tp5page.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/lay/modules/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/icheck/icheck.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/dw.js"></script>
    <script type="text/javascript">

        layui.use('form', function () {  //如果只加载一个模块，可以不填数组。如：layui.use('form')
            var form = layui.form //获取form模块
        });

        /**
         * 分页函数
         * @param currentPage
         */
        function page(currentPage) {
            $("#currentPage").val(currentPage)
            $("#listForm").submit()
        }

        /**
         * 删除提示函数
         * @param id
         */
        function deleteRepair(id) {
            layer.confirm('确定删除吗?', {icon: 2, title: '提示'}, function (index) {
                window.location.href = "${pageContext.request.contextPath}/repair/deleteRepair" + id + ".html"
                layer.close(index);
            });
        }

        /**
         * 已维修
         * @param id
         */
        function repair(id) {
            layer.confirm('该房屋已维修成功?', {icon: 1, title: '提示'}, function (index) {
                window.location.href = "${pageContext.request.contextPath}/repair/repair" + id + ".html"
                layer.close(index);
            });
        }

        /**
         * 查看原因
         */
        function lookContent(content) {
            layer.alert(content)
        }

    </script>
    <style type="text/css">
        .layui-table img {
            max-width: 80px;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/header.jsp"></jsp:include>

    <jsp:include page="/left.jsp"></jsp:include>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <fieldset class="layui-elem-field">
                <legend>报修管理 - 报修列表</legend>
                <div class="layui-field-box">
                    <form id="listForm" class="layui-form"
                          action="${pageContext.request.contextPath}/repair/repairList.html" method="post">
                        <input type="hidden" id="currentPage" name="currentPage" value="${page.currentPage}">
                        <div class="layui-form-item" style="text-align:center;">
                            <div class="layui-input-inline">
                                <input autocomplete="off" class="layui-input" placeholder="房屋名" type="text"
                                       name="params[houseName]" value="${page.params.houseName}">
                            </div>
                            <div class="layui-input-inline">
                                <input autocomplete="off" class="layui-input" placeholder="用户" type="text"
                                       name="params[userName]" value="${page.params.userName}">
                            </div>

                            <div class="layui-input-inline">
                                <input autocomplete="off" class="layui-input" placeholder="维修人" type="text"
                                       name="params[staffName]" value="${page.params.staffName}">
                            </div>

                            <div class="layui-inline" style="text-align:left;">
                                <div class="layui-input-inline">
                                    <button class="layui-btn"><i class="layui-icon">&#xe615;</i>查询</button>
                                </div>
                            </div>
                        </div>
                    </form>
                    <hr>
                    <div class="layui-btn-group">
                        <a class="layui-btn layui-btn-xs layui-btn-normal"
                           href="${pageContext.request.contextPath}/repair/toRepair.html">
                            <i class="layui-icon">&#xe654;</i>新增
                        </a>
                    </div>
                    <hr>
                    <form id="deleteForm" method="post">
                        <table class="layui-table">
                            <thead>
                            <tr>
                                <th>报修人</th>
                                <th>报修房屋</th>
                                <th>报修时间</th>
                                <th>维修人</th>
                                <th>状态</th>
                                <th style="text-align:center;">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach items="${page.list}" var="repair" varStatus="i">
                                <tr>
                                    <td>${repair.user.name}</td>
                                    <td>${repair.house.houseName}</td>
                                    <td>${repair.repairTime}</td>
                                    <td>${repair.repairStaff}</td>
                                    <td>
                                        <c:if test="${repair.repairState==0}">
                                            未维修
                                        </c:if>
                                        <c:if test="${repair.repairState==1}">
                                            维修中
                                        </c:if>
                                        <c:if test="${repair.repairState==2}">
                                            已维修
                                        </c:if>
                                    </td>
                                    <td class="text-center">
                                        <div class="layui-btn-group">
                                            <c:if test="${sessionScope.user.role == 3 and repair.repairState == 0}">
                                                <a class="layui-btn layui-btn-xs layui-btn-normal"
                                                   href="${pageContext.request.contextPath}/repair/getRepair/${repair.repairId}.html">
                                                    <i class="layui-icon">&#xe642;</i>维修
                                                </a>
                                            </c:if>
                                            <c:if test="${sessionScope.user.role == 3 and repair.repairState == 1}">
                                                <a class="layui-btn layui-btn-xs layui-btn-success"
                                                   href="javascript:void(0)"
                                                   onclick="repair('${repair.repairId}')">
                                                    <i class="layui-icon">&#xe642;</i>已维修
                                                </a>
                                            </c:if>
                                            <a class="layui-btn layui-btn-xs layui-btn-danger"
                                               href="javascript:void(0)"
                                               onclick="deleteRepair('${repair.repairId}')">
                                                <i class="layui-icon">&#xe640;</i>删除
                                            </a>
                                            <a class="layui-btn layui-btn-xs"
                                               href="javascript:void(0);"
                                               onclick="lookContent('${repair.repairContent}')">
                                                <i class="layui-icon">&#xe63a;</i>查看原因
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>
                    </form>
                    总条数：${page.totalCount}
                </div>
                <div style="border-top: 1px dotted #e2e2e2; text-align: left;">
                    <ul class="pagination">

                        <%--不是第一页，就显示--%>
                        <c:if test="${page.currentPage!=1}">
                            <li>
                                <a href="javascript:void(0);" onclick="page(${page.currentPage-1})">&laquo;</a>
                            </li>
                        </c:if>
                        <c:forEach begin="1" end="${page.totalPage}" var="p">
                            <c:if test="${p==page.currentPage}">
                                <li class="active"><span>${p}</span></li>
                            </c:if>
                            <c:if test="${p!=page.currentPage}">
                                <li><a href="javascript:void(0);" onclick="page(${p})">${p}</a></li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${page.currentPage!=page.totalPage}">
                            <li><a href="javascript:void(0);" onclick="page(${page.currentPage+1})">&raquo;</a></li>
                        </c:if>
                    </ul>

                </div>
            </fieldset>
        </div>
    </div>
    <jsp:include page="/footer.jsp"></jsp:include>
</div>
</body>
</html>