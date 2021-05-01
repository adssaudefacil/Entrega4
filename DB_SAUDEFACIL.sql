/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     30/04/2021 20:28:24                          */
/*==============================================================*/


/*==============================================================*/
/* Table: dCLINICA                                              */
/*==============================================================*/
create table dCLINICA
(
   ID_CLINICA           int not null,
   NOME                 char(100),
   ENDERECO             char(100),
   TELEFONE             char(50),
   ESPECIALIDADE        char(50)
);

alter table dCLINICA
   add primary key (ID_CLINICA);

/*==============================================================*/
/* Table: dEXAME                                                */
/*==============================================================*/
create table dEXAME
(
   ID_EXAME             int not null,
   NOME                 char(50),
   TP_EXAME             char(20)
);

alter table dEXAME
   add primary key (ID_EXAME);

/*==============================================================*/
/* Table: dGRUPOFAMILIAR                                        */
/*==============================================================*/
create table dGRUPOFAMILIAR
(
   ID_PARENTE           int not null,
   NOME                 char(100),
   ID_GRUPO             int not null,
   ID_USUARIO           int not null,
   dGR_ID_GRUPO         int
);

alter table dGRUPOFAMILIAR
   add primary key (ID_GRUPO);

/*==============================================================*/
/* Table: dMEDICAMENTOS                                         */
/*==============================================================*/
create table dMEDICAMENTOS
(
   ID_MEDICAMENTO       int not null,
   NOME                 char(100),
   ID_MEDICO            int not null,
   INTERVALO            time,
   STITUACAO            bool,
   IMG                  longblob
);

alter table dMEDICAMENTOS
   add primary key (ID_MEDICAMENTO);

/*==============================================================*/
/* Table: dMEDICO                                               */
/*==============================================================*/
create table dMEDICO
(
   ID_MEDICO            int not null,
   NOME                 char(100),
   ESPECIALIDADE        char(100),
   CRM                  int
);

alter table dMEDICO
   add primary key (ID_MEDICO);

/*==============================================================*/
/* Table: dPACIENTE                                             */
/*==============================================================*/
create table dPACIENTE
(
   ID_PACIENTE          int not null,
   ID_USUARIO           int,
   ID_GRUPO             int not null,
   NOME                 char(100),
   ENDERECO             char(100),
   TELEFONE             char(50),
   EMAIL                char(100),
   SEXO                 bool
);

alter table dPACIENTE
   add primary key (ID_PACIENTE);

/*==============================================================*/
/* Table: dPARENTE                                              */
/*==============================================================*/
create table dPARENTE
(
   ID_PARENTE           int not null,
   NOME                 char(100),
   GRAU                 int,
   IDADE                int
);

alter table dPARENTE
   add primary key (ID_PARENTE);

/*==============================================================*/
/* Table: dUSUARIO                                              */
/*==============================================================*/
create table dUSUARIO
(
   ID_USUARIO           int not null,
   NOME                 char(100),
   LOGIN                char(20),
   SENHA                char(8)
);

alter table dUSUARIO
   add primary key (ID_USUARIO);

/*==============================================================*/
/* Table: dVACINA                                               */
/*==============================================================*/
create table dVACINA
(
   ID_VACINA            int not null,
   NOME                 char(100),
   APLICACAO            char(20),
   N_DOSES              int,
   SITUACAO             bool,
   IMG                  longblob,
   DOSE                 int,
   DT_DOSE              date
);

alter table dVACINA
   add primary key (ID_VACINA);

/*==============================================================*/
/* Table: fATESTADO                                             */
/*==============================================================*/
create table fATESTADO
(
   ID_ATESTADO          int not null,
   ID_PACIENTE          int not null,
   DT_INICIO            datetime,
   DT_FIM               datetime,
   IMG_ATESTADO         longblob,
   ID_MEDICO            int not null,
   ID_CLINICA           int not null
);

alter table fATESTADO
   add primary key (ID_ATESTADO);

/*==============================================================*/
/* Table: fCONSULTA                                             */
/*==============================================================*/
create table fCONSULTA
(
   ID_CONSULTA          int not null,
   DT_CONSULTA          date,
   ID_MEDICO            int not null,
   HR_CONSULTA          time,
   OBS                  char(200),
   ID_PACIENTE          int not null,
   ID_CLINICA           int not null
);

alter table fCONSULTA
   add primary key (ID_CONSULTA);

/*==============================================================*/
/* Table: fEXAME                                                */
/*==============================================================*/
create table fEXAME
(
   ID_EXAME             int not null,
   DT_EXAME             date,
   DT_RESULTADO         date,
   ID_MEDICO            int not null,
   ID_CLINICA           int not null,
   PRECO_UNIT           float(4,2),
   QTDE                 int,
   PRECO_TOTAL          float(4,2),
   ID_PACIENTE          int not null,
   ID_EVENTO            int not null
);

alter table fEXAME
   add primary key (ID_EVENTO);

/*==============================================================*/
/* Table: fMEDICAMENTOS                                         */
/*==============================================================*/
create table fMEDICAMENTOS
(
   ID_MEDICAMENTO       int not null,
   ID_PACIENTE          int not null,
   DT_MEDICAMENTO       date,
   HR_MEDICAMENTO       time,
   ID_EVENTO            int not null
);

alter table fMEDICAMENTOS
   add primary key (ID_EVENTO);

/*==============================================================*/
/* Table: fVACINA                                               */
/*==============================================================*/
create table fVACINA
(
   ID_VACINA            int not null,
   DT_VACINA            date,
   HR_VACINA            time,
   ID_MEDICO            int,
   ID_CLINICA           int not null,
   ID_EVENTO            int not null,
   ID_PACIENTE          int not null
);

alter table fVACINA
   add primary key (ID_EVENTO);

alter table dGRUPOFAMILIAR add constraint FK_TEM_PARENTE foreign key (ID_PARENTE)
      references dPARENTE (ID_PARENTE) on delete restrict on update restrict;

alter table dGRUPOFAMILIAR add constraint FK_TESTE foreign key (dGR_ID_GRUPO)
      references dGRUPOFAMILIAR (ID_GRUPO) on delete restrict on update restrict;

alter table dGRUPOFAMILIAR add constraint FK_USUARIO_GRUPO foreign key (ID_USUARIO)
      references dUSUARIO (ID_USUARIO) on delete restrict on update restrict;

alter table dMEDICAMENTOS add constraint FK_MEDICO_RECEITA foreign key (ID_MEDICO)
      references dMEDICO (ID_MEDICO) on delete restrict on update restrict;

alter table dPACIENTE add constraint FK_POSSUI foreign key (ID_GRUPO)
      references dGRUPOFAMILIAR (ID_GRUPO) on delete restrict on update restrict;

alter table dPACIENTE add constraint FK_Reference_13 foreign key (ID_USUARIO)
      references dUSUARIO (ID_USUARIO) on delete restrict on update restrict;

alter table fATESTADO add constraint FK_EMITE foreign key (ID_CLINICA)
      references dCLINICA (ID_CLINICA) on delete restrict on update restrict;

alter table fATESTADO add constraint FK_PRESCREVE foreign key (ID_MEDICO)
      references dMEDICO (ID_MEDICO) on delete restrict on update restrict;

alter table fATESTADO add constraint FK_RECEBE foreign key (ID_PACIENTE)
      references dPACIENTE (ID_PACIENTE) on delete restrict on update restrict;

alter table fCONSULTA add constraint FK_AGENDA foreign key (ID_CLINICA)
      references dCLINICA (ID_CLINICA) on delete restrict on update restrict;

alter table fCONSULTA add constraint FK_CLINICA_FAZ foreign key (ID_MEDICO)
      references dMEDICO (ID_MEDICO) on delete restrict on update restrict;

alter table fCONSULTA add constraint FK_SOLICITA foreign key (ID_PACIENTE)
      references dPACIENTE (ID_PACIENTE) on delete restrict on update restrict;

alter table fEXAME add constraint FK_EXAME foreign key (ID_EXAME)
      references dEXAME (ID_EXAME) on delete restrict on update restrict;

alter table fEXAME add constraint FK_FAZ foreign key (ID_CLINICA)
      references dCLINICA (ID_CLINICA) on delete restrict on update restrict;

alter table fEXAME add constraint FK_INDICA foreign key (ID_MEDICO)
      references dMEDICO (ID_MEDICO) on delete restrict on update restrict;

alter table fEXAME add constraint FK_SOLICITA foreign key (ID_PACIENTE)
      references dPACIENTE (ID_PACIENTE) on delete restrict on update restrict;

alter table fMEDICAMENTOS add constraint FK_MEDICAMENTO foreign key (ID_MEDICAMENTO)
      references dMEDICAMENTOS (ID_MEDICAMENTO) on delete restrict on update restrict;

alter table fMEDICAMENTOS add constraint FK_PACIENTE foreign key (ID_PACIENTE)
      references dPACIENTE (ID_PACIENTE) on delete restrict on update restrict;

alter table fVACINA add constraint FK_CLINICA_APLICA foreign key (ID_CLINICA)
      references dCLINICA (ID_CLINICA) on delete restrict on update restrict;

alter table fVACINA add constraint FK_TOMA foreign key (ID_PACIENTE)
      references dPACIENTE (ID_PACIENTE) on delete restrict on update restrict;

alter table fVACINA add constraint FK_VACINA foreign key (ID_VACINA)
      references dVACINA (ID_VACINA) on delete restrict on update restrict;

