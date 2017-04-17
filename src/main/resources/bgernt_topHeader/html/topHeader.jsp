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
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<div class="unit size2of3">
    <div class="mod modNavService">
        <div class="inner">
            <h1 class="invisible">Navigation</h1>
            <h2 class="invisible">Liens directs</h2>
            <ul class="skiplinks">
                <li><a href="index/federal/federal-inherit-template/federal-virtual-tour.htm#navigation" accesskey="1"
                    title="[ALT + 1]">Accès direct à la navigation principale</a></li>
                <li><a href="index/federal/federal-inherit-template/federal-virtual-tour.htm#content" accesskey="2"
                    title="[ALT + 2]">Passer au contenu</a></li>
            </ul>

            <div class="nav">
<!-- MENUS TO BUILD WITH JCR QUERIES -->
                <template:module path="${currentNode.path}/simpleMenu" view="top" />

                <template:module path="${currentNode.path}/languageSwitcher" />

            </div>

        </div>
    </div>
</div>
<div class="unit size1of3 lastUnit">
    <div class="mod modSearch">
        <div class="inner">
<%--             <template:area path="searchbar"/> --%>
            <template:module path="${currentNode.path}/searchBar" />
        </div>
    </div>
</div>