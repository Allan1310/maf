
package com.allinfnt._2014._08.atomic.oa.userinfo.types;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.allinfnt._2014._08.atomic.oa.userinfo.types package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _GetUserList_QNAME = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "getUserList");
    private final static QName _GetBirthDayUserList_QNAME = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "getBirthDayUserList");
    private final static QName _GetBirthDayUserListResponse_QNAME = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "getBirthDayUserListResponse");
    private final static QName _GetUserInfoByName_QNAME = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "getUserInfoByName");
    private final static QName _GetUserInfoByNo_QNAME = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "getUserInfoByNo");
    private final static QName _GetUserListResponse_QNAME = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "getUserListResponse");
    private final static QName _GetNewUserListResponse_QNAME = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "getNewUserListResponse");
    private final static QName _GetNewUserList_QNAME = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "getNewUserList");
    private final static QName _GetUserInfoByNameResponse_QNAME = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "getUserInfoByNameResponse");
    private final static QName _GetUserInfoByNoResponse_QNAME = new QName("http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", "getUserInfoByNoResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.allinfnt._2014._08.atomic.oa.userinfo.types
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link GetNewUserList }
     * 
     */
    public GetNewUserList createGetNewUserList() {
        return new GetNewUserList();
    }

    /**
     * Create an instance of {@link GetUserListResponse }
     * 
     */
    public GetUserListResponse createGetUserListResponse() {
        return new GetUserListResponse();
    }

    /**
     * Create an instance of {@link GetBirthDayUserListResponse }
     * 
     */
    public GetBirthDayUserListResponse createGetBirthDayUserListResponse() {
        return new GetBirthDayUserListResponse();
    }

    /**
     * Create an instance of {@link GetUserInfoByName }
     * 
     */
    public GetUserInfoByName createGetUserInfoByName() {
        return new GetUserInfoByName();
    }

    /**
     * Create an instance of {@link GetUserInfoByNoResponse }
     * 
     */
    public GetUserInfoByNoResponse createGetUserInfoByNoResponse() {
        return new GetUserInfoByNoResponse();
    }

    /**
     * Create an instance of {@link User }
     * 
     */
    public User createUser() {
        return new User();
    }

    /**
     * Create an instance of {@link GetBirthDayUserList }
     * 
     */
    public GetBirthDayUserList createGetBirthDayUserList() {
        return new GetBirthDayUserList();
    }

    /**
     * Create an instance of {@link GetUserList }
     * 
     */
    public GetUserList createGetUserList() {
        return new GetUserList();
    }

    /**
     * Create an instance of {@link UserSearch }
     * 
     */
    public UserSearch createUserSearch() {
        return new UserSearch();
    }

    /**
     * Create an instance of {@link GetNewUserListResponse }
     * 
     */
    public GetNewUserListResponse createGetNewUserListResponse() {
        return new GetNewUserListResponse();
    }

    /**
     * Create an instance of {@link GetUserInfoByNo }
     * 
     */
    public GetUserInfoByNo createGetUserInfoByNo() {
        return new GetUserInfoByNo();
    }

    /**
     * Create an instance of {@link GetUserInfoByNameResponse }
     * 
     */
    public GetUserInfoByNameResponse createGetUserInfoByNameResponse() {
        return new GetUserInfoByNameResponse();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetUserList }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", name = "getUserList")
    public JAXBElement<GetUserList> createGetUserList(GetUserList value) {
        return new JAXBElement<GetUserList>(_GetUserList_QNAME, GetUserList.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetBirthDayUserList }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", name = "getBirthDayUserList")
    public JAXBElement<GetBirthDayUserList> createGetBirthDayUserList(GetBirthDayUserList value) {
        return new JAXBElement<GetBirthDayUserList>(_GetBirthDayUserList_QNAME, GetBirthDayUserList.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetBirthDayUserListResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", name = "getBirthDayUserListResponse")
    public JAXBElement<GetBirthDayUserListResponse> createGetBirthDayUserListResponse(GetBirthDayUserListResponse value) {
        return new JAXBElement<GetBirthDayUserListResponse>(_GetBirthDayUserListResponse_QNAME, GetBirthDayUserListResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetUserInfoByName }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", name = "getUserInfoByName")
    public JAXBElement<GetUserInfoByName> createGetUserInfoByName(GetUserInfoByName value) {
        return new JAXBElement<GetUserInfoByName>(_GetUserInfoByName_QNAME, GetUserInfoByName.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetUserInfoByNo }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", name = "getUserInfoByNo")
    public JAXBElement<GetUserInfoByNo> createGetUserInfoByNo(GetUserInfoByNo value) {
        return new JAXBElement<GetUserInfoByNo>(_GetUserInfoByNo_QNAME, GetUserInfoByNo.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetUserListResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", name = "getUserListResponse")
    public JAXBElement<GetUserListResponse> createGetUserListResponse(GetUserListResponse value) {
        return new JAXBElement<GetUserListResponse>(_GetUserListResponse_QNAME, GetUserListResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetNewUserListResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", name = "getNewUserListResponse")
    public JAXBElement<GetNewUserListResponse> createGetNewUserListResponse(GetNewUserListResponse value) {
        return new JAXBElement<GetNewUserListResponse>(_GetNewUserListResponse_QNAME, GetNewUserListResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetNewUserList }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", name = "getNewUserList")
    public JAXBElement<GetNewUserList> createGetNewUserList(GetNewUserList value) {
        return new JAXBElement<GetNewUserList>(_GetNewUserList_QNAME, GetNewUserList.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetUserInfoByNameResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", name = "getUserInfoByNameResponse")
    public JAXBElement<GetUserInfoByNameResponse> createGetUserInfoByNameResponse(GetUserInfoByNameResponse value) {
        return new JAXBElement<GetUserInfoByNameResponse>(_GetUserInfoByNameResponse_QNAME, GetUserInfoByNameResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetUserInfoByNoResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://www.allinfnt.com/2014/08/atomic/oa/userInfo/types", name = "getUserInfoByNoResponse")
    public JAXBElement<GetUserInfoByNoResponse> createGetUserInfoByNoResponse(GetUserInfoByNoResponse value) {
        return new JAXBElement<GetUserInfoByNoResponse>(_GetUserInfoByNoResponse_QNAME, GetUserInfoByNoResponse.class, null, value);
    }

}
