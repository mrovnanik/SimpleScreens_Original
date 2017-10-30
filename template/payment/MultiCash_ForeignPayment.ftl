<#-- PAYMENT RELATED INFO -->
<#assign paySum = ec.l10n.format(paymentTotal, "0.00").replace(".", ",")!0/>
<#assign paySumPadded = paySum?right_pad(17," ")/>
<#assign payCurrency = payment.amountUomId!"N/a"/>
<#assign payVS = payment.variableSymbol!""?left_pad(10, "0")/>
<#assign dbtBankIBAN = payment.dbtIBAN!"N/a"/>
<#assign dbtBankBIC = payment.dbtBIC!"N/a"/>
<#assign dbtBank= payment.dbtBank!"N/a"/>
<#assign dbtParty = payment.dbtParty!"N/a"/>
<#assign cdtBankIBAN = payment.cdtIBAN!"N/a"/>
<#assign cdtBankBIC = payment.cdtBIC!"N/a"/>
<#assign cdtBank = payment.cdtBank!"N/a"/>
<#assign cdtParty = payment.cdtParty!"N/a"/>
<#assign dbtBankCity = payment.dbtAddressCity!"N/a - city"/>
<#assign dbtBankStreet = payment.dbtAddressStreet!"N/a - street"/>
<#assign dbtBankZIP = payment.dbtAddressZIP!"N/a - ZIP"/>
<#assign fileName = "MCH_"+payment.paymentId+"_MCH.SKA"/>
<#assign dbtBICpaddedX = dbtBankBIC?right_pad(12, "X")/>
<#assign cdtBICpaddedX = cdtBankBIC?right_pad(12, "X")/>
<#-- DEBTOR RELATED INFO -->
<#assign dbtCompanyFullName = debtorParty.organizationName!"N/a company">
<#assign dbtCompanyStreet = debtorParty.partyInfoData.address1!"N/a street">
<#assign dbtCompanyZIP = debtorParty.partyInfoData.postalCode!"N/a ZIP">
<#assign dbtCompanyCity = debtorParty.partyInfoData.city!"N/a city">
<#assign dbtCompanyCountry = debtorParty.partyInfoData.countryGeoId!"N/a country">
<#-- BENEFICIARY RELATED INFO -->
<#assign cdtCompanyFullName = payment.cdtParty!"N/a company">
<#assign cdtCompanyStreet = payment.cdtPartyStreet!"N/a street">
<#assign cdtCompanyZIP = payment.cdtPartyZIP!"N/a ZIP">
<#assign cdtCompanyCity = payment.cdtPartyCity!"N/a city">
<#assign cdtCompanyCountry = payment.cdtPartyCountry!"N/a country">
<#-- BENEFICIARY BANK RELATED INFO -->
<#assign cdtBankStreet = payment.cdtAddressStreet!"N/a street">
<#assign cdtBankZIP = payment.cdtAddressZIP!"N/a ZIP">
<#assign cdtBankCity = payment.cdtAddressCity!"N/a city">
<#assign cdtBankCountry = payment.cdtAddressCountry!"N/a country">
<#-- ************************************ -->
:01:REFERENCIA DTSKA
:02:${paySumPadded}
:03:00001
:04:${dbtBankBIC}
:05:${dbtCompanyFullName[0..*35]}
${dbtCompanyStreet[0..*35]}
${dbtCompanyZIP[0..*5]} ${dbtCompanyCity[0..*29]}
:07:${fileName}
{1: F01${dbtBICpaddedX}0001000001}{2:I100${cdtBICpaddedX}N1}{4:
:20:${payment.paymentId[0..*16]?right_pad(16)}
:32A:${ec.l10n.format(dueDate, "yyMMdd")}${payCurrency}${paySum}
:50:${dbtCompanyFullName[0..*35]}
${dbtCompanyFullName[0..*35]}
${dbtCompanyStreet[0..*35]}
${dbtCompanyZIP[0..*5]} ${dbtCompanyCity[0..*29]}
:52D:<#if dbtBankIBAN?length gte 16>${dbtBankIBAN[8..*16]}<#else>${dbtBankIBAN?left_pad(16, "0")}</#if>
<#if dbtBankIBAN?length gte 16>${dbtBankIBAN[8..*16]}<#else>${dbtBankIBAN?left_pad(16, "0")}</#if>
EUR EUR
130|DE|DE
:57A:${cdtBankBIC}|
:57D:${cdtBank}
${cdtBank[0..*35]}
${cdtBankStreet[0..*35]}
${cdtBankZIP[0..*5]} ${cdtBankCity[0..*29]}
:59:/${cdtBankIBAN}
${cdtCompanyFullName[0..*35]}
${cdtCompanyStreet[0..*35]}
${cdtCompanyZIP[0..*5]} ${cdtCompanyCity[0..*29]}
:70:${payVS[0..*10]}
:71A:BN1
:72:01 06 04 02
PARTNER
REEXPORT
STATISTICS
-}