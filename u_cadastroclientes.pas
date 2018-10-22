unit u_cadastroclientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection;

type
  Tf_cadastroclientes = class(TForm)
    pg_cadastro: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    grid: TDBGrid;
    Nome: TLabeledEdit;
    cpf: TLabeledEdit;
    telefone: TLabeledEdit;
    numero: TLabeledEdit;
    endereco: TLabeledEdit;
    bairro: TLabeledEdit;
    Complemento: TLabeledEdit;
    cep: TLabeledEdit;
    cidade: TLabeledEdit;
    btn_salvar: TBitBtn;
    Conn: TZConnection;
    qry: TZQuery;
    qry_grid: TZQuery;
    ds_grid: TDataSource;
    btnInserir: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    codigo: TEdit;
    Label1: TLabel;
    procedure btn_salvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure gridDblClick(Sender: TObject);
    procedure ExecutaQuery(sstr:string);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    tipoentrada:string;
  public
    { Public declarations }
  end;

var
  f_cadastroclientes: Tf_cadastroclientes;

implementation

{$R *.dfm}

procedure Tf_cadastroclientes.ExecutaQuery(sstr:string);
begin
   //-> Salvar em banco
   try
      qry.Active:=false;
      qry.SQL.Clear;
      qry.SQL.Add('begin;');
      qry.ExecSQL;

      qry.Active:=false;
      qry.SQL.Clear;
      qry.SQL.Add(sstr);
      qry.ExecSQL;

      qry.Active:=false;
      qry.SQL.Clear;
      qry.SQL.Add('commit;');
      qry.ExecSQL;
   except //-> Erro qualquer
      qry.Active:=false;
      qry.SQL.Clear;
      qry.SQL.Add('rollback;');
      qry.ExecSQL;

      ShowMessage('Erro');
   end;

   //->
   qry_grid.Active:=false;
   qry_grid.Active:=true;
end;

procedure Tf_cadastroclientes.btn_salvarClick(Sender: TObject);
var ssql:string;
begin
   //-> Rotina para inclusão edição no banco de dados
   if tipoentrada='I' then
   begin
      //-> Inserir
      ssql:='';
      ssql:=ssql+' INSERT INTO public.clientes(';
      ssql:=ssql+' nome, cpf, telefone, endereco, numero,';
      ssql:=ssql+' bairro, complemento, cep, cidade) Values(';
      ssql:=ssql+' '+QuotedStr(Nome.Text)+',';
      ssql:=ssql+' '+QuotedStr(cpf.Text)+',';
      ssql:=ssql+' '+QuotedStr(telefone.Text)+',';
      ssql:=ssql+' '+QuotedStr(endereco.Text)+',';
      ssql:=ssql+' '+QuotedStr(numero.Text)+',';
      ssql:=ssql+' '+QuotedStr(bairro.Text)+',';
      ssql:=ssql+' '+QuotedStr(Complemento.Text)+',';
      ssql:=ssql+' '+QuotedStr(cep.Text)+',';
      ssql:=ssql+' '+QuotedStr(cidade.Text)+');';
   end
   else if tipoentrada='A' then
   begin
      //-> Alterar
      ssql:='';
      ssql:=ssql+' UPDATE public.clientes SET';
      ssql:=ssql+' nome='+QuotedStr(Nome.Text)+',';
      ssql:=ssql+' cpf='+QuotedStr(cpf.Text)+',';
      ssql:=ssql+' telefone='+QuotedStr(telefone.Text)+',';
      ssql:=ssql+' endereco='+QuotedStr(endereco.Text)+',';
      ssql:=ssql+' numero='+QuotedStr(numero.Text)+',';
      ssql:=ssql+' bairro='+QuotedStr(bairro.Text)+',';
      ssql:=ssql+' complemento='+QuotedStr(Complemento.Text)+',';
      ssql:=ssql+' cep='+QuotedStr(cep.Text)+',';
      ssql:=ssql+' cidade='+QuotedStr(cidade.Text);
      ssql:=ssql+' WHERE codigo='+codigo.Text+';';
   end;
   //->
   ExecutaQuery(ssql);
   tipoentrada:='';
   pg_cadastro.ActivePageIndex:=0;
end;

procedure Tf_cadastroclientes.FormShow(Sender: TObject);
var i: integer;
begin
   //-> Conectando ao banco
   Conn.Connected:=false;
   Conn.HostName:='localhost:5432';
   Conn.Database:='macro';
   Conn.User:='postgres';
   Conn.Password:='123';

   Conn.Connected:=true;
   //-> Conectando a query
   qry.Active:=false;
   qry.Connection:=Conn;

   qry_grid.Active:=false;
   qry_grid.Connection:=Conn;
   qry_grid.SQL.Clear;
   qry_grid.SQL.Add('SELECT *');
   qry_grid.SQL.Add(' FROM public.clientes;');
   qry_grid.Active:=true;

   qry_grid.First;
   
   i:=0;
   while i<grid.FieldCount do
   begin
      if not (pos(LowerCase(grid.Fields[i].FieldName),'codigo nome telefone cidade')>0) then
         grid.Fields[i].Visible:=false
      else
         inc(i);
   end;

end;

procedure Tf_cadastroclientes.btnInserirClick(Sender: TObject);
begin
   //-> Limpar campos para novo registro
   pg_cadastro.ActivePageIndex:=1;
   tipoentrada:='I';

   codigo.Clear;
   Nome.Clear;
   endereco.Clear;
   numero.Clear;
   cpf.Clear;
   telefone.Clear;
   bairro.Clear;
   Complemento.Clear;
   cep.Clear;
   cidade.Clear;
end;

procedure Tf_cadastroclientes.btnAlterarClick(Sender: TObject);
begin
   //-> Preencher campos para alteração
   pg_cadastro.ActivePageIndex:=1;
   tipoentrada:='A';

   codigo.Text:= qry_grid.fieldByName('codigo').AsString;
   Nome.Text:= qry_grid.fieldByName('nome').AsString;
   endereco.Text:= qry_grid.fieldByName('endereco').AsString;
   numero.Text:= qry_grid.fieldByName('numero').AsString;
   cpf.Text:= qry_grid.fieldByName('cpf').AsString;
   telefone.Text:= qry_grid.fieldByName('telefone').AsString;
   bairro.Text:= qry_grid.fieldByName('bairro').AsString;
   Complemento.Text:= qry_grid.fieldByName('complemento').AsString;
   cep.Text:= qry_grid.fieldByName('cep').AsString;
   cidade.Text:= qry_grid.fieldByName('cidade').AsString;

end;

procedure Tf_cadastroclientes.gridDblClick(Sender: TObject);
begin
   //->
   btnAlterar.Click;
end;

procedure Tf_cadastroclientes.btnExcluirClick(Sender: TObject);
var ssql:string;
begin
   //-> Exclusão de registro
   If  MessageDlg('Deseja excluir este registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
   begin
      ssql:=ssql+' DELETE FROM public.clientes ';
      ssql:=ssql+' WHERE codigo='+codigo.Text+';';
      ExecutaQuery(ssql);
   end;
end;

end.
