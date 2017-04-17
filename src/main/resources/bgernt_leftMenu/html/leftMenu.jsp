<%@ page language="java" contentType="text/jnt_searchResults.html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%@ taglib prefix="bger" uri="http://www.bger.ch/jahia/tags/bger" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>


<bger:getMenuRoot var="rootNode" pageNode="${renderContext.mainResource.node}" />

<jcr:jqom var="menuFirstLevel">
    <query:selector nodeTypeName="jnt:page" />
    <query:childNode path="${rootNode.path}" />
</jcr:jqom>

<h2 class="invisible">Navigation secondaire</h2>
<div class="mod modNavSub">
    <div class="inner">
        <ul>
            <c:forEach items="${menuFirstLevel.nodes}" var="child">
                <c:set var="classActive" value="" />
                <c:if test="${fn:startsWith(renderContext.mainResource.node.path, child.path)}">
                    <c:set var="classActive" value="active" />
                </c:if>
                <li class="item">
                    <a class="l1 ${classActive}" href="${child.url}">
                        <span>${child.properties["jcr:title"].string}</span>
                    </a>
                </li>
                <c:if test="${fn:startsWith(renderContext.mainResource.node.path, child.path)}">
                    <ul class="sub">
                        <jcr:jqom var="menuSecondLevel">
                            <query:selector nodeTypeName="jnt:page" />
                            <query:childNode path="${child.path}" />
                        </jcr:jqom>
                        <c:forEach items="${menuSecondLevel.nodes}" var="subchild">
                            <c:set var="classActive" value="" />
                            <c:if test="${renderContext.mainResource.node.path eq subchild.path}">
                                <c:set var="classActive" value="active" />
                            </c:if>
                            <li>
                                <a class="l2 ${classActive}" href="${subchild.url}">
                                    <span>${subchild.properties["jcr:title"].string}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
            </c:forEach>
        </ul>
    </div>
</div>
