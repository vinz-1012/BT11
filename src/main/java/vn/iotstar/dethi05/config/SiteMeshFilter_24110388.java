package vn.iotstar.dethi05.config;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import jakarta.servlet.http.HttpServletResponse;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.config.ObjectFactory;
import org.sitemesh.config.properties.PropertiesFilterConfigurator;
import org.sitemesh.config.xml.XmlFilterConfigurator;
import org.sitemesh.webapp.SiteMeshFilter;
import org.sitemesh.webapp.WebAppContext;
import org.sitemesh.webapp.contentfilter.HttpServletResponseBuffer;
import org.sitemesh.webapp.contentfilter.ResponseMetaData;

import java.io.IOException;
import java.nio.CharBuffer;

public class SiteMeshFilter_24110388 extends ConfigurableSiteMeshFilter {

    private FilterConfig filterConfig;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        super.init(filterConfig);
    }

    @Override
    protected Filter setup() throws ServletException {
        ObjectFactory objectFactory = getObjectFactory();
        SiteMeshFilterBuilder builder = new SiteMeshFilterBuilder() {
            @Override
            public Filter create() {
                return new SiteMeshFilter(getSelector(), getContentProcessor(), getDecoratorSelector(), isIncludeErrorPages()) {

                    @Override
                    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
                            throws IOException, ServletException {
                        HttpServletRequest req = (HttpServletRequest) servletRequest;
                        HttpServletRequest wrappedRequest = new HttpServletRequestWrapper(req) {
                            @Override
                            public RequestDispatcher getRequestDispatcher(String path) {
                                RequestDispatcher rd = super.getRequestDispatcher(path);
                                if (rd == null) {
                                    return null;
                                }
                                return new RequestDispatcher() {
                                    @Override
                                    public void forward(ServletRequest request, ServletResponse response)
                                            throws ServletException, IOException {
                                        rd.include(request, response);
                                        flushSafely(response);
                                    }

                                    @Override
                                    public void include(ServletRequest request, ServletResponse response)
                                            throws ServletException, IOException {
                                        rd.include(request, response);
                                        flushSafely(response);
                                    }
                                };
                            }
                        };
                        super.doFilter(wrappedRequest, servletResponse, filterChain);
                    }

                    @Override
                    protected WebAppContext createContext(String contentType, HttpServletRequest request,
                                                         HttpServletResponse response, ResponseMetaData metaData) {
                        return new WebAppContext(contentType, request, response,
                                getFilterConfig().getServletContext(), getContentProcessor(), metaData, isIncludeErrorPages()) {
                            @Override
                            protected void dispatch(HttpServletRequest req, HttpServletResponse resp, String path)
                                    throws ServletException, IOException {
                                RequestDispatcher rd = getServletContext().getRequestDispatcher(path);
                                if (rd == null) {
                                    throw new ServletException("Could not get RequestDispatcher for " + path);
                                }
                                rd.include(req, resp);
                                flushSafely(resp);
                            }
                        };
                    }

                    @Override
                    protected boolean postProcess(String contentType, CharBuffer buffer, HttpServletRequest request,
                                                  HttpServletResponse response, ResponseMetaData metaData)
                            throws IOException, ServletException {
                        boolean result = super.postProcess(contentType, buffer, request, response, metaData);
                        flushSafely(response);
                        return result;
                    }

                    @Override
                    protected void writeOriginal(HttpServletResponse response, CharBuffer buffer,
                                                HttpServletResponseBuffer responseBuffer) throws IOException {
                        super.writeOriginal(response, buffer, responseBuffer);
                        flushSafely(response);
                    }

                    private void flushSafely(ServletResponse response) {
                        try {
                            response.getWriter().flush();
                        } catch (Exception e1) {
                            try {
                                response.getOutputStream().flush();
                            } catch (Exception ignored) {
                            }
                        }
                    }
                };
            }
        };

        new PropertiesFilterConfigurator(objectFactory, getConfigProperties(filterConfig))
                .configureFilter(builder);
        new XmlFilterConfigurator(objectFactory, loadConfigXml(filterConfig, getConfigFileName()))
                .configureFilter(builder);
        applyCustomConfiguration(builder);

        return builder.create();
    }
}
