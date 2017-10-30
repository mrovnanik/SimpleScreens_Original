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
        <Nm>${debtor}</Nm>
        <PstlAdr>
          <Ctry>${payment.dbtAddressCountry}</Ctry>
          <AdrLine>${payment.dbtAddressStreet}</AdrLine>
          <AdrLine>${payment.dbtAddressCity}</AdrLine>
        </PstlAdr>
      </Dbtr>
      <DbtrAcct>
        <Id>
          <IBAN>${dbtIBAN}</IBAN>
        </Id>
        <Ccy>EUR</Ccy>
      </DbtrAcct>
      <DbtrAgt>
        <FinInstnId>
          <BIC>${payment.dbtBIC}</BIC>
        </FinInstnId>
      </DbtrAgt>
	  <CdtTrfTxInf>
	  </CdtTrfTxInf>
	</PmtInf>
  </CstmrCdtTrfInitn>
</Document>