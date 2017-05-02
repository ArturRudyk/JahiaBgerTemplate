<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/jnt_searchResults.html;charset=UTF-8"%>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr"%>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/jnt_searchResults.html; charset=utf-8" />

<title>${fn:escapeXml(renderContext.mainResource.node.displayableName)}</title>

<link type="text/css" rel="stylesheet" media="screen" href="${url.currentModule}/css/styles.css" />
<c:if test="${renderContext.editMode or renderContext.editModeConfigName eq 'studiomode'}">
    <link type="text/css" rel="stylesheet" media="screen" href="${url.currentModule}/css/edit.css" />
</c:if>
</head>

<body>
    <style type="text/css">
        .bgimg{position:absolute;top:0;left:0;height:636px;width:100%;background:#fff url(/img/bg.jpg) no-repeat scroll center 0}
    </style>
    <div class="bodywrapper">
        <a class="hiddenanchor" name="start"></a>
        <div class="head">
            <div class="line line_head">
                <div class="unit size1of3">
                    <div class="mod modLogo" data-connectors="MasterSlave1Master">
                        <div class="inner">
                            <a href="/" target="_top" title="Retour à la page d'accueil" accesskey="0">
                                <img src="${url.currentModule}/images/schweizerisches-bundesgericht-logo.gif" width="300" height="189" alt="Logo Tribunal fédéral" />
                            </a>
                        </div>
                    </div>
                </div>
                <div class="unit size2of3 lastUnit grid_left">
                    <div class="line">
                        <template:area path="top-header"/>
                    </div>
                    <div class="line">
                        <template:area path="main-navigation"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="page">
        <div class="body">
            <div class="line overflow">
                <div class="unit size1of3">
                    <template:area path="left-navigation"/>
                </div>
                <div class="unit lastUnit size2of3 grid_left">
                    <a class="hiddenanchor" name="content"></a>
                    <div class="mod modContent skinContentLegacy">
                        <div class="inner">
                            <template:area path="pagecontent"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <template:theme />
</body>
</html>
