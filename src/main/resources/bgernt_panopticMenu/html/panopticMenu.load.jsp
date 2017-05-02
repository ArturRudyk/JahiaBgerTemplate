<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
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
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %><c:if test="${renderContext.editMode}">
    <template:module path="*" nodeTypes="bgernt:panopticMenuPage" />
</c:if>

<style>
    @import "css/bgerv10.css";
</style>


<c:set var="locale" value="${renderContext.mainResourceLocale}"/>
<div class="mod modNavHome" data-connectors="MasterSlave1Slave">
    <div class="inner">
        <div class="preload">
            <c:forEach items="${currentNode.nodes}" var="item">
                <img src="${item.properties.photo.node.url}" alt="${item.properties.page.node.properties['jcr:title'].string}" width="1280" height="636">
            </c:forEach>
        </div>
        <div role='navigation' aria-label='Home page navigation' class="nav phonoptic-menu" id='panoptic-menu'>
            <ul>
                <c:set var="imageIndex" value="0" scope="page"/>
                <c:forEach items="${currentNode.nodes}" var="secondLevel" varStatus="status">
                    <c:set var="imageIndex" value="${imageIndex + 1}" scope="page"/>
                    <c:set var="last" value=""/>
                    <c:if test="${status.last}">
                        <c:set var="last">last</c:set>
                    </c:if>
                    <li class="item ${last}" data-image="${secondLevel.properties.photo.node.name}"
                        aria-expanded="false" aria-haspopup="true">
                        <a class="l1 second-level" href="${secondLevel.properties.page.node.url}">
                            <template:module node="${secondLevel}"/>
                        </a>
                        <%--<ul class="sub">--%>
                            <%--<bger:getMenuRoot var="subNodes" pageNode="${secondLevel.properties.page.node}" workspace="${workspace}" />--%>
                            <%--<c:forEach items="${subNodes.nodes}" var="thirdLevel">--%>
                                <%--<c:set var="url" value=""/>--%>
                                <%--<c:set var="path" value=""/>--%>
                                <%--<c:set var="title" value=""/>--%>
                                <%--<c:choose>--%>
                                    <%--<c:when test="${thirdLevel.properties['jcr:primaryType'].string eq 'jnt:page'}">--%>
                                        <%--<c:set var="url" value="${thirdLevel.url}" />--%>
                                        <%--<c:choose>--%>
                                            <%--<c:when test="${thirdLevel.name eq 'gericht-elektronischer-verkehr'}">--%>
                                                <%--<c:set var="url" value="${url}?summary=true"/>--%>
                                            <%--</c:when>--%>
                                            <%--<c:when test="${(thirdLevel.name eq 'jurisdiction-recht-kostenpflichtige-suche') || thirdLevel.name eq 'jurisdiction-recht-leitentscheide1954-direct'}">--%>
                                                <%--<bger:getEsigateProperty var="url" key="${thirdLevel.name}" locale="${locale}"/>--%>
                                            <%--</c:when>--%>
                                        <%--</c:choose>--%>
                                        <%--<c:set var="path" value="${thirdLevel.path}" />--%>
                                        <%--<c:set var="title" value="${thirdLevel.properties['jcr:title'].string}"/>--%>
                                    <%--</c:when>--%>
                                    <%--<c:when test="${thirdLevel.properties['jcr:primaryType'].string eq 'jnt:nodeLink'}">--%>
                                        <%--<c:set var="url" value="${thirdLevel.properties['j:node'].node.url}" />--%>
                                        <%--<c:if test="${thirdLevel.name eq 'session-link'}">--%>
                                            <%--<c:set var="url" value="${url}?detail=true"/>--%>
                                        <%--</c:if>--%>
                                        <%--<c:set var="path" value="${thirdLevel.properties['j:node'].node.path}" />--%>
                                        <%--<c:set var="title" value="${thirdLevel.displayableName}"/>--%>
                                    <%--</c:when>--%>
                                <%--</c:choose>--%>
                                <%--<c:set var="show" value="true" />--%>
                                <%--<c:forEach var="excludePage" items="${secondLevel.properties.excludePages}">--%>
                                    <%--<c:if test="${excludePage.node.url eq url}">--%>
                                        <%--<c:set var="show" value="false" />--%>
                                    <%--</c:if>--%>
                                <%--</c:forEach>--%>
                                <%--<c:if test="${show && not empty url && not empty path && not empty title}">--%>
                                    <%--<li class=''>--%>
                                        <%--<a class="l2 third-level" href="${url}">--%>
                                            <%--<span>${title}</span>--%>
                                        <%--</a>--%>
                                        <%--&lt;%&ndash;<ul class='four-level'>&ndash;%&gt;--%>
                                            <%--&lt;%&ndash;<c:forEach items="${thirdLevel.nodes}" var="fourthLevel">&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<c:set var="fourthLevelPageShow" value="true"/>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<c:forEach items="${excludePages.nodes}" var="excludeNode">&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;<c:if test="${fourthLevel.url eq excludeNode.properties.link.node.url}">&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;<c:set var="fourthLevelPageShow" value="false"/>&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;</c:forEach>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<c:set var="fourthLevelUrl" value=""/>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<c:set var="fourthLevelPath" value=""/>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<c:set var="fourthLevelTitle" value=""/>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<c:choose>&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;<c:when test="${fourthLevel.properties['jcr:primaryType'].string eq 'jnt:page'}">&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;<c:set var="fourthLevelUrl" value="${fourthLevel.url}" />&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;<c:if test="${(fourthLevel.name eq 'jurisdiction-recht-leitentscheide1954') || (fourthLevel.name eq 'jurisdiction-recht-urteile2000neu')&ndash;%&gt;--%>
                                                            <%--&lt;%&ndash;|| (fourthLevel.name eq 'jurisdiction-recht-kostenpflichtige-urteile2000neu') || (fourthLevel.name eq 'jurisdiction-recht-urteile2000')&ndash;%&gt;--%>
                                                            <%--&lt;%&ndash;|| (fourthLevel.name eq 'jurisdiction-jurivoc')}">&ndash;%&gt;--%>
                                                            <%--&lt;%&ndash;<bger:getEsigateProperty var="fourthLevelUrl" key="${fourthLevel.name}" locale="${locale}"/>&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;<c:set var="fourthLevelPath" value="${fourthLevel.path}" />&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;<c:set var="fourthLevelTitle" value="${fourthLevel.properties['jcr:title'].string}"/>&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;</c:when>&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;<c:when test="${fourthLevel.properties['jcr:primaryType'].string eq 'jnt:nodeLink'}">&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;<c:set var="fourthLevelUrl" value="${fourthLevel.properties['j:node'].node.url}" />&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;<c:set var="fourthLevelPath" value="${fourthLevel.properties['j:node'].node.path}" />&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;<c:set var="fourthLevelTitle" value="${fourthLevel.displayableName}"/>&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;</c:when>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;</c:choose>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<c:if test="${fourthLevelPageShow && not empty fourthLevelUrl && not empty fourthLevelPath && not empty fourthLevelTitle}">&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;<c:set var="classActive" value="" />&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;<c:set var="subClassActive" value="" />&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;<c:if test="${renderContext.mainResource.node.path eq fourthLevelPath}">&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;<c:set var="classActive" value="active" />&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;<c:if test="${renderContext.mainResource.node.parent.path eq fourthLevelPath}">&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;<c:set var="subClassActive" value="active" />&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;<li>&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;<a class="l4" href="${fourthLevelUrl}">&ndash;%&gt;--%>
                                                            <%--&lt;%&ndash;<span>${fourthLevelTitle}</span>&ndash;%&gt;--%>
                                                        <%--&lt;%&ndash;</a>&ndash;%&gt;--%>
                                                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
                                            <%--&lt;%&ndash;</c:forEach>&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;</ul>&ndash;%&gt;--%>
                                    <%--</li>--%>
                                <%--</c:if>--%>
                            <%--</c:forEach>--%>
                        <%--</ul>--%>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
