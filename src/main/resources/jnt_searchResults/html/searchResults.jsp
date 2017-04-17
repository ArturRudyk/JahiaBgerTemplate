<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@page import="java.lang.System"%>
<%@page import="org.jahia.taglibs.search.*"%>
<%@page import="org.jahia.services.search.*"%>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="css" resources="searchresults.css"/>
<c:if test="${renderContext.editMode}">
    <fieldset>
    <legend>${fn:escapeXml(jcr:label(currentNode.primaryNodeType,currentResource.locale))}</legend>
</c:if>
<c:set var="hitsName" value="hits_${currentNode.identifier}"/>
<c:set var="hitsCountName" value="hitsCount_${currentNode.identifier}"/>
<c:choose>
    <c:when test='${searchMap[hitsName] eq null}'>
        <s:results var="resultsHits" approxCountVar="listApproxSize">
            <c:set target="${moduleMap}" property="listTotalSize" value="${count}" />
            <c:set target="${moduleMap}" property="resultsHits" value="${resultsHits}" />
            <c:set target="${moduleMap}" property="listApproxSize" value="${listApproxSize}" />
            <c:if test='${searchMap == null}'>
                <jsp:useBean id="searchMap" class="java.util.HashMap" scope="request"/>
            </c:if>
            <c:set target="${searchMap}" property="${hitsName}" value="${resultsHits}"/>
            <c:set target="${searchMap}" property="${hitsCountName}" value="${count}"/>
            <c:set target="${searchMap}" property="listApproxSize" value="${listApproxSize}" />
        </s:results>
    </c:when>
    <c:otherwise>
        <c:set target="${moduleMap}" property="listTotalSize" value="${searchMap[hitsCountName]}" />
        <c:set target="${moduleMap}" property="resultsHits" value="${searchMap[hitsName]}" />
        <c:set target="${moduleMap}" property="listApproxSize" value="${searchMap[listApproxSize]}" />
    </c:otherwise>
</c:choose>

<jcr:nodeProperty name="jcr:title" node="${currentNode}" var="title"/>
<jcr:nodeProperty name="autoSuggest" node="${currentNode}" var="autoSuggest"/>
<div id="${currentNode.UUID}">
    <div class="resultsList">
        <c:if test="${param.autoSuggest != false && autoSuggest.boolean && (empty moduleMap || empty moduleMap.begin || moduleMap.begin == 0)}">
            <%-- spelling auto suggestions are enabled --%>
            <jcr:nodeProperty name="autoSuggestMinimumHitCount" node="${currentNode}" var="autoSuggestMinimumHitCount"/>
            <jcr:nodeProperty name="autoSuggestHitCount" node="${currentNode}" var="autoSuggestHitCount"/>
            <jcr:nodeProperty name="autoSuggestMaxTermCount" node="${currentNode}" var="autoSuggestMaxTermCount"/>
            <c:if test="${moduleMap['listTotalSize'] <= functions:default(autoSuggestMinimumHitCount.long, 2)}">
                <%-- the number of original results is less than the configured threshold, we can start auto-suggest  --%>
                <s:suggestions runQuery="${autoSuggestHitCount.long > 0}" maxTermsToSuggest="${autoSuggestMaxTermCount.long}">
                    <%-- we have a suggestion --%>
                    <c:if test="${autoSuggestHitCount.long > 0 && suggestedCount > moduleMap['listTotalSize']}">
                        <%-- found more hits for the suggestion than the original query brings --%>
                        <h4>
                            <fmt:message key="search.results.didYouMean" />:&nbsp;
                            <c:forEach var="suggestion" items="${suggestion.allSuggestions}" varStatus="status">
                                <a href="<s:suggestedSearchUrl suggestion="${suggestion}"/>"><em>${fn:escapeXml(suggestion)}</em></a>
                                <c:if test="${not status.last}">, </c:if>
                            </c:forEach>
                            <br/><fmt:message key="search.results.didYouMean.topResults"><fmt:param value="${functions:min(functions:default(autoSuggestHitCount.long, 2), suggestedCount)}" /></fmt:message>
                        </h4>
                        <ol>
                            <s:resultIterator begin="0" end="${functions:default(autoSuggestHitCount.long, 2) - 1}">
                                <li><%@ include file="searchHit.jspf" %></li>
                            </s:resultIterator>
                        </ol>
                        <hr/>
                        <h4><fmt:message key="search.results.didYouMean.resultsFor"/>:&nbsp;<strong>${fn:escapeXml(suggestion.originalQuery)}</strong></h4>
                    </c:if>
                    <c:if test="${autoSuggestHitCount.long == 0}">
                        <h4>
                            <fmt:message key="search.results.didYouMean" />:&nbsp;
                            <c:forEach var="suggestion" items="${suggestion.allSuggestions}" varStatus="status">
                                <a href="<s:suggestedSearchUrl suggestion="${suggestion}"/>"><em>${fn:escapeXml(suggestion)}</em></a>
                                <c:if test="${not status.last}">, </c:if>
                            </c:forEach>
                        </h4>
                    </c:if>
                </s:suggestions>
            </c:if>
        </c:if>

        <c:if test="${searchMap['listApproxSize'] > 0 || moduleMap['listTotalSize'] > 0}">
            <c:set var="termKey" value="src_terms[0].term"/>
            <c:set var="search" value="${fn:escapeXml(param[termKey])}"/>
            <c:if test="${searchMap['listApproxSize'] eq 2147483647 || (searchMap['listApproxSize'] eq 0 && moduleMap['listTotalSize'] eq 2147483647)}">
                <h3><fmt:message key="search.results.sizeNotExact.found"><fmt:param value="${fn:escapeXml(param[termKey])}"/><fmt:param value="more"/></fmt:message></h3>
            </c:if>

            <div class="mod modContent skinContentLegacy">
            <div class="inner">
            <div class="richtext">
                <table bgcolor="#cccccc" border="0" width="500" cellpadding="2" cellspacing="0">
                    <tr>
                        <td>

                            <c:if test="${empty param.st}">
                                1 -
                                <c:set var= "st" scope="session"  value="10"/>
                            </c:if>
                            <c:if test="${not empty param.st}"><c:set var="st" scope="session" value="${param.st}"/></c:if>

                            <c:if test="${st >10}">
                                <h4><a href="${renderContext.mainResource.node.url}?st=${st - 10}&query=${search}#form"><--</a>
                            </c:if>

                            <c:if test="${not empty param.st}">
                                ${st - 9} -
                            </c:if>
                            <c:if test="${st > moduleMap['listTotalSize']}">
                            ${moduleMap['listTotalSize']}
                                <c:set var="endOfIterator" scope="session" value="${moduleMap['listTotalSize'] - 1}"/>
                            </c:if>
                            <c:if test="${(st < moduleMap['listTotalSize']) || (empty param.st && moduleMap['listTotalSize'] > 10) }">
                                ${st}
                                <a href="${renderContext.mainResource.node.url}?st=${st + 10}&query=${search}#form">--></a> </h4>
                                <c:set var="endOfIterator" scope="session" value="${st - 1}"/>
                            </c:if>
                            <c:set var="beginOfIterator" scope="session" value="${st - 10}"/>

                        </td>
                        <c:if test="${searchMap['listApproxSize'] > 0 && searchMap['listApproxSize'] < 2147483647 || moduleMap['listTotalSize'] < 2147483647}">
                            <c:set var="messKey" value="search.results.found" />
                            <c:if test="${searchMap['listApproxSize'] > 0}">
                                <c:set var="messKey" value="search.results.sizeNotExact.found" />
                            </c:if>
                            <td align="right"><p><fmt:message key="${messKey}"><fmt:param value="${fn:escapeXml(param[termKey])}"/><fmt:param value="${searchMap['listApproxSize'] > 0 ? searchMap['listApproxSize'] : moduleMap['listTotalSize']}"/></fmt:message></p></td><h3>
                        </c:if>
                    </tr>
                </table>

                <%--<c:set var="beginName" value="begin_${currentNode.identifier}"/>--%>
                <%--<c:set var="endName" value="end_${currentNode.identifier}"/>--%>
                <%--<c:if test="${not empty requestScope[beginName]}">--%>
                    <%--<c:set target="${moduleMap}" property="begin" value="${requestScope[beginName]}"/>--%>
                <%--</c:if>--%>
                <%--<c:if test="${not empty requestScope[endName]}">--%>
                    <%--<c:set target="${moduleMap}" property="end" value="${requestScope[endName]}"/>--%>
                <%--</c:if>--%>
                <table  border="0" width="500" cellpadding="2" cellspacing="0">
                    <s:resultIterator begin="${beginOfIterator}" end="${endOfIterator}" varStatus="status" hits="${moduleMap['resultsHits']}">
                        <tr><%--<span>${status.index+1}.</span>--%><%@ include file="searchHit.jspf" %></tr>
                    </s:resultIterator>
                </table>
            </div>
            </div>
            </div>
            <div class="clear"></div>
        </c:if>
        <c:if test="${moduleMap['listTotalSize'] == 0}">
            <h4><fmt:message key="search.results.no.results"/></h4>
        </c:if>
    </div>
</div>

<c:if test="${renderContext.editMode}">
    </fieldset>
</c:if>