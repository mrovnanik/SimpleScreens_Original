<#assign cellPadding = "1pt">
<#assign dateFormat = dateFormat!"dd MMM yyyy">
<#assign nowTimestamp = ec.l10n.format(ec.user.nowTimestamp, "dd.MM.yyyy HH:mm:ss")>


<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="OpenSans">

    <fo:layout-master-set>
        <fo:simple-page-master master-name="A4">
            <fo:region-body
                    margin-top="1.5cm"
                    margin-bottom="1.5cm"
                    margin-left="1.5cm"
                    margin-right="1.5cm">
            </fo:region-body>
            <fo:region-before
                    extent="1cm"/>
            <fo:region-after extent="1cm"/>
            <fo:region-start extent="1cm"/>
            <fo:region-end extent="1cm"/>
        </fo:simple-page-master>

        <fo:simple-page-master master-name="A4-landscape" page-height="21cm" page-width="29.7cm">
            <fo:region-body
                    margin-top="1.5cm"
                    margin-bottom="1.5cm"
                    margin-left="1.25cm"
                    margin-right="1.5cm">
            </fo:region-body>
            <fo:region-before
                    extent="1cm"/>
            <fo:region-after extent="1cm"/>
            <fo:region-start extent="1cm"/>
            <fo:region-end extent="1cm"/>
        </fo:simple-page-master>
    </fo:layout-master-set>

    <fo:page-sequence master-reference="A4-landscape" id="mainSequence">
        <fo:static-content flow-name="xsl-region-before">
            <fo:block text-align="center" font-weight="bold"
                      margin-top="0.3cm">${Static["org.moqui.util.StringUtilities"].encodeForXmlAttribute("Zoznam dodávateľov - telefón + e-mail", true)}</fo:block>
            <fo:block-container position="fixed" top="0.2cm" left="1.5cm">
                <fo:block text-align="left">
                    <#--<fo:external-graphic src="${sri.buildUrl('/images/customer/hotel-slovan-logo.PNG').url}" content-height="0.33in" content-width="scale-to-fit" scaling="uniform"/>-->
                    <fo:external-graphic src="${logoPath}" content-height="0.33in" content-width="scale-to-fit" scaling="uniform"/>
                </fo:block>
            </fo:block-container>
        </fo:static-content>

        <fo:static-content flow-name="xsl-region-after">
            <fo:block>
                <fo:block text-align="left" font-size="8pt" margin-left="0.5cm"
                          margin-bottom="0.5cm">${Static["org.moqui.util.StringUtilities"].encodeForXmlAttribute("Vygenerované ${nowTimestamp}", true)}</fo:block>
            </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
        <#-- TABLE -->
            <fo:table table-layout="fixed" width="100%">
                <fo:table-header font-size="9pt" font-weight="bold" border-bottom="solid black"
                                 background-color="rgb(204, 255, 104)" line-height="15pt">
                    <fo:table-cell width="6.5cm" padding="${cellPadding}">
                        <fo:block text-align="left">Spoločnosť</fo:block>
                    </fo:table-cell>
                    <fo:table-cell width="5cm" padding="${cellPadding}">
                        <fo:block>Popis</fo:block>
                    </fo:table-cell>
                    <fo:table-cell width="3cm" padding="${cellPadding}">
                        <fo:block>Priezvisko</fo:block>
                    </fo:table-cell>
                    <fo:table-cell width="2cm" padding="${cellPadding}">
                        <fo:block>Meno</fo:block>
                    </fo:table-cell>
                    <fo:table-cell width="2.75cm" padding="${cellPadding}">
                        <fo:block>Pozícia</fo:block>
                    </fo:table-cell>
                    <fo:table-cell width="3cm" padding="${cellPadding}">
                        <fo:block>Telefón</fo:block>
                    </fo:table-cell>
                    <fo:table-cell width="5cm" padding="${cellPadding}">
                        <fo:block>E-mail</fo:block>
                    </fo:table-cell>
                </fo:table-header>
                <fo:table-body>
                <#list supplierList as supplier>

                    <#assign phoneNumbersMobile = ec.entity.find("mantle.party.contact.PartyContactMechTelecomNumber").condition("partyId", supplier.partyId).condition("contactMechPurposeId", "PhoneMobile").conditionDate("fromDate","thruDate",ec.user.nowTimestamp).disableAuthz().list()>
                    <#assign phoneNumbersOther = ec.entity.find("mantle.party.contact.PartyContactMechTelecomNumber").condition("partyId", supplier.partyId).condition("contactMechPurposeId", "PhoneAssistant").conditionDate("fromDate","thruDate",ec.user.nowTimestamp).conditionDate("fromDate", "thruDate", ec.user.nowTimestamp).disableAuthz().list()>
                    <#assign emailContacts = ec.entity.find("mantle.party.contact.PartyContactMechInfo").condition("partyId", supplier.partyId).condition("contactMechTypeEnumId", "CmtEmailAddress").conditionDate("fromDate","thruDate",ec.user.nowTimestamp).disableAuthz().list()>

                    <#assign notes = ec.entity.find("mantle.party.PartyNoteNotDeleted").condition("partyId", supplier.partyId).disableAuthz().list()>

                    <#assign persons = ec.entity.find("PartyRelationship").condition("fromPartyId",supplier.partyId).condition("relationshipTypeEnumId","PrtAgent").disableAuthz().list()>

                    <#assign orgName = Static["org.moqui.util.StringUtilities"].encodeForXmlAttribute(supplier.organizationName!"nedef.", true)>





                    <#list phoneNumbersOther as number>
                        <fo:table-row font-size="8pt" border-bottom="thin solid grey"
                                      background-color="rgb(180, 232, 184)">
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block text-align="left">${orgName}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block>
                                    <#list notes as note>
                                        <#if note.noteText?length gte 35>${note.noteText[0..*35]?trim + "..."}<#else>${note.noteText?trim}</#if>
                                        <#sep>,</#sep>
                                    </#list>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block></fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block text-align="left"></fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block text-align="left">${translatedContactTypes.get(number.contactMechPurposeId) + ''}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block>${number.countryCode + ' ' + number.areaCode + ' ' + number.contactNumber}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block></fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </#list>

                    <#list emailContacts as email>
                        <fo:table-row font-size="8pt" border-bottom="thin solid grey"
                                      background-color="rgb(180, 232, 184)">
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block text-align="left">${orgName}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block>
                                    <#list notes as note>
                                        <#if note.noteText?length gte 35>${note.noteText[0..*35]?trim + "..."}<#else>${note.noteText?trim}</#if>
                                        <#sep>,</#sep>
                                    </#list>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block></fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block></fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block>${translatedContactTypes.get(email.contactMechPurposeId) + ''}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block></fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block>${email.infoString + ''}</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </#list>


                    <#list persons as person >
                        <#assign personNumbers = ec.entity.find("mantle.party.contact.PartyContactMechTelecomNumber").condition("partyId", person.toPartyId).conditionDate("fromDate","thruDate",ec.user.nowTimestamp).disableAuthz().list()>
                        <#assign personalInfo = ec.entity.find("mantle.party.Person").condition("partyId", person.toPartyId).disableAuthz().one()>
                        <#assign personEmails = ec.entity.find("mantle.party.contact.PartyContactMechInfo").condition("partyId", person.toPartyId).condition("contactMechTypeEnumId","CmtEmailAddress").conditionDate("fromDate","thruDate",ec.user.nowTimestamp).disableAuthz().list()>

                        <fo:table-row font-size="8pt" border-bottom="thin solid grey">
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block
                                        text-align="left">${Static["org.moqui.util.StringUtilities"].encodeForXmlAttribute(supplier.organizationName!"nedef.", true)}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block>
                                    <#list notes as note>
                                        <#if note.noteText?length gte 35>${note.noteText[0..*35]?trim + "..."}<#else>${note.noteText?trim}</#if>
                                        <#sep>,</#sep>
                                    </#list>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block>
                                    <#if personalInfo.personalTitle?has_content>
                                        ${personalInfo.personalTitle + ' '}
                                    </#if>
                                    ${'' + Static["org.moqui.util.StringUtilities"].encodeForXmlAttribute(personalInfo.lastName!"", true)}
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block>${Static["org.moqui.util.StringUtilities"].encodeForXmlAttribute(personalInfo.firstName!"", true) + ''}</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <fo:block></fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <#list personNumbers as number>
                                    <fo:block>
                                    ${number.countryCode + ' ' + number.areaCode + ' ' + number.contactNumber }
                                    </fo:block>
                                </#list>
                            </fo:table-cell>
                            <fo:table-cell padding="${cellPadding}">
                                <#list personEmails as email>
                                    <fo:block>
                                    ${email.infoString + ''}
                                    </fo:block>
                                </#list>
                            </fo:table-cell>
                        </fo:table-row>
                    </#list>

                </#list>
                    <fo:table-row font-size="9pt" border-top="solid black">
                        <fo:table-cell padding="${cellPadding}">
                            <fo:block></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="${cellPadding}">
                            <fo:block></fo:block>
                        </fo:table-cell>
                    <#-- <fo:table-cell padding="${cellPadding}"><fo:block></fo:block></fo:table-cell> -->
                        <fo:table-cell padding="${cellPadding}">
                            <fo:block></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="${cellPadding}">
                            <fo:block></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="${cellPadding}">
                            <fo:block text-align="right"></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="${cellPadding}">
                            <fo:block text-align="right"></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="${cellPadding}">
                            <fo:block text-align="right"></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:flow>
    </fo:page-sequence>
</fo:root>