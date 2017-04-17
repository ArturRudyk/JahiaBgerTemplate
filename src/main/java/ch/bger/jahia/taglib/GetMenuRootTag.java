package ch.bger.jahia.taglib;

import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.content.JCRTemplate;
import org.jahia.taglibs.AbstractJahiaTag;
import org.slf4j.Logger;

import javax.jcr.RepositoryException;
import javax.servlet.jsp.JspException;
import java.util.Locale;

/**
 * Get the root under the homepage for a page.
 * 
 * Example :
 * Home
 * - Menu Root 1
 *   - Page 11
 *   - Page 12
 *     - Page 121
 * - Menu Root 2
 *   -Page 21
 *    - Page 211
 * 
 * For node "Page 121", the result is "Menu Root 1"
 * For node "Page 11", the result is "Menu Root 1"
 * For node "Page 21", the result is "Menu Root 2"
 * 
 * @author mrmau <mrmau@smile.fr>
 */
public class GetMenuRootTag extends AbstractJahiaTag {

    /** The Constant LOGGER. */
    private static final Logger LOGGER = org.slf4j.LoggerFactory.getLogger(GetMenuRootTag.class);

    /** The var. */
    private String var;

    /** The page node. */
    private JCRNodeWrapper pageNode;

    /** The workspace */
    private String workspace;

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.BodyTagSupport#doStartTag()
     */
    @Override
    public int doStartTag() throws JspException {
        try {
            final JCRSessionWrapper userSession = JCRTemplate.getInstance().getSessionFactory()
                    .getCurrentUserSession(workspace, new Locale(pageNode.getLanguage()));
            final JCRSessionWrapper session = JCRTemplate.getInstance().getSessionFactory().getCurrentSystemSession(
                    userSession.getWorkspace().getName(), userSession.getLocale(), userSession.getFallbackLocale());
            final String homepagePath = getRenderContext().getSite().getHome().getPath();
            JCRNodeWrapper currentNode = session.getNodeByIdentifier(pageNode.getIdentifier());
            if (!currentNode.getPath().equals(homepagePath)) {
                JCRNodeWrapper parentNode = pageNode.getParent();
                while (parentNode != null && !homepagePath.equals(parentNode.getPath())) {
                    currentNode = currentNode.getParent();
                    parentNode = currentNode.getParent();
                }
            }
            pageContext.setAttribute(var, currentNode);
        } catch (RepositoryException e) {
            LOGGER.error("Fail to get homepage node.", e);
        }

        return EVAL_BODY_INCLUDE;
    }

    /**
     * Gets the var.
     *
     * @return the var
     */
    public String getVar() {
        return var;
    }

    /**
     * Sets the var.
     *
     * @param var the new var
     */
    public void setVar(final String var) {
        this.var = var;
    }

    /**
     * Gets the page node.
     *
     * @return the page node
     */
    public JCRNodeWrapper getPageNode() {
        return pageNode;
    }

    /**
     * Sets the page node.
     *
     * @param pageNode the new page node
     */
    public void setPageNode(final JCRNodeWrapper pageNode) {
        this.pageNode = pageNode;
    }

    public String getWorkspace() {
        return workspace;
    }

    public void setWorkspace(final String workspace) {
        this.workspace = workspace;
    }
}
