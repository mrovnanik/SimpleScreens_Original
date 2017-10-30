<#-- PAYMENT RELATED INFO -->
<#assign paySum = ec.l10n.format(paymentTotal, "0.00").replace(".", ",")!0/>
<#assign payCurrency = payment.amountUomId!"N/a"/>
<#assign dbtBankBIC = payment.dbtBIC!"N/a"/>
<#assign dbtBankIBAN = payment.dbtIBAN!"N/a"/>
<#assign dbtParty = payment.dbtParty!"N/a"/>
<#assign dbtBICpaddedX = dbtBankBIC?right_pad(12, "X")/>
<#assign cdtBankBIC = payment.cdtBIC!"N/a"/>
<#assign cdtBankIBAN = payment.cdtIBAN!"N/a"/>
<#assign cdtParty = payment.cdtParty!"N/a"/>
<#assign cdtBICpaddedX = cdtBankBIC?right_pad(12, "X")/>
<#assign payVS = payment.variableSymbol!""?left_pad(10, "0")/>
<#assign paySS = payment.specificSymbol!""?left_pad(10, "0")/>
<#assign payCS = payment.constantSymbol!""?left_pad(4, "0")/>
<#-- assign dbtBankCity = payment.dbtAddressCity!"N/a - city"/ -->
<#-- assign dbtBankStreet = payment.dbtAddressStreet!"N/a - street"/ -->
<#-- assign dbtBankZIP = payment.dbtAddressZIP!"N/a - ZIP"/ -->
<#-- assign dbtBankCountry = payment.dbtAddressCountry!"N/a - ZIP"/-- >
<#-- ************************************ -->
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<Document xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
  <CstmrCdtTrfInitn>
    <GrpHdr>
      <MsgId>${ec.user.getVisitId()}_${ec.l10n.format(ec.user.getNowTimestamp(), "yyMMddHHmmssSSS")}</MsgId>
      <CreDtTm>${ec.l10n.format(ec.user.getNowTimestamp(), "yyyy-MM-dd'T'HH:mm:ss")}</CreDtTm>
      <NbOfTxs>000000000000001</NbOfTxs>
      <CtrlSum>${paymentTotal}</CtrlSum>
      <InitgPty>
        <Nm>${ec.user.getUsername()}</Nm>
      </InitgPty>
    </GrpHdr>
    <PmtInf>
      <PmtInfId>${paymentId}</PmtInfId>
      <PmtMtd>TRF</PmtMtd>
      <BtchBookg>true</BtchBookg>
      <NbOfTxs>000000000000001</NbOfTxs>
      <CtrlSum>${paymentTotal}</CtrlSum>
      <PmtTpInf>
        <SvcLvl>
          <Cd>SEPA</Cd>
        </SvcLvl>
      </PmtTpInf>
      <ReqdExctnDt>${ec.l10n.format(dueDate, "yyyy-MM-dd")}</ReqdExctnDt>
      <Dbtr>
        <Nm>${dbtParty}</Nm>
      </Dbtr>
      <DbtrAcct>
        <Id>
          <IBAN>${dbtBankIBAN}</IBAN>
        </Id>
        <Ccy>EUR</Ccy>
      </DbtrAcct>
      <DbtrAgt>
        <FinInstnId>
          <BIC>${dbtBankBIC}</BIC>
        </FinInstnId>
      </DbtrAgt>
	  <CdtTrfTxInf>
		<PmtId>
          <InstrId>01</InstrId>
          <EndToEndId>/VS${payVS}/SS${paySS}/KS${payCS}</EndToEndId>
        </PmtId>
        <Amt>
          <InstdAmt Ccy="EUR">${paymentTotal}</InstdAmt>
        </Amt>
        <ChrgBr>SLEV</ChrgBr>
        <CdtrAgt>
          <FinInstnId>
            <BIC>${cdtBankBIC}</BIC>
          </FinInstnId>
        </CdtrAgt>
        <Cdtr>
          <Nm>${cdtParty}</Nm>
        </Cdtr>
        <CdtrAcct>
          <Id>
            <IBAN>${cdtBankIBAN}</IBAN>
          </Id>
        </CdtrAcct>
        <RmtInf>
          <Ustrd>UCEL PLATBY 1</Ustrd>
        </RmtInf>
	  </CdtTrfTxInf>
	</PmtInf>
  </CstmrCdtTrfInitn>
</Document>