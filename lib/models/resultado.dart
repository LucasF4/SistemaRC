class Resultado {
  String? dataSituacao;
  String? fantasia;
  String? tipo;
  String? nome;
  String? telefone;
  String? email;
  String? situacao;
  String? bairro;
  String? logradouro;
  String? numero;
  String? cep;
  String? municipio;
  String? porte;
  String? abertura;
  String? naturezaJuridica;
  String? uf;
  String? cnpj;
  String? ultimaAtualizacao;
  String? status;
  String? complemento;
  String? efr;
  String? motivoSituacao;
  String? situacaoEspecial;
  String? dataSituacaoEspecial;
  String? capitalSocial;

  Resultado(
      {this.dataSituacao,
      this.fantasia,
      this.tipo,
      this.nome,
      this.telefone,
      this.email,
      this.situacao,
      this.bairro,
      this.logradouro,
      this.numero,
      this.cep,
      this.municipio,
      this.porte,
      this.abertura,
      this.naturezaJuridica,
      this.uf,
      this.cnpj,
      this.ultimaAtualizacao,
      this.status,
      this.complemento,
      this.efr,
      this.motivoSituacao,
      this.situacaoEspecial,
      this.dataSituacaoEspecial,
      this.capitalSocial});

  Resultado.fromJson(Map<String, dynamic> json) {
    dataSituacao = json['data_situacao'];
    fantasia = json['fantasia'];
    tipo = json['tipo'];
    nome = json['nome'];
    telefone = json['telefone'];
    email = json['email'];
    situacao = json['situacao'];
    bairro = json['bairro'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    cep = json['cep'];
    municipio = json['municipio'];
    porte = json['porte'];
    abertura = json['abertura'];
    naturezaJuridica = json['natureza_juridica'];
    uf = json['uf'];
    cnpj = json['cnpj'];
    ultimaAtualizacao = json['ultima_atualizacao'];
    status = json['status'];
    complemento = json['complemento'];
    efr = json['efr'];
    motivoSituacao = json['motivo_situacao'];
    situacaoEspecial = json['situacao_especial'];
    dataSituacaoEspecial = json['data_situacao_especial'];
    capitalSocial = json['capital_social'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data_situacao'] = this.dataSituacao;
    data['fantasia'] = this.fantasia;
    data['tipo'] = this.tipo;
    data['nome'] = this.nome;
    data['telefone'] = this.telefone;
    data['email'] = this.email;
    data['situacao'] = this.situacao;
    data['bairro'] = this.bairro;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['cep'] = this.cep;
    data['municipio'] = this.municipio;
    data['porte'] = this.porte;
    data['abertura'] = this.abertura;
    data['natureza_juridica'] = this.naturezaJuridica;
    data['uf'] = this.uf;
    data['cnpj'] = this.cnpj;
    data['ultima_atualizacao'] = this.ultimaAtualizacao;
    data['status'] = this.status;
    data['complemento'] = this.complemento;
    data['efr'] = this.efr;
    data['motivo_situacao'] = this.motivoSituacao;
    data['situacao_especial'] = this.situacaoEspecial;
    data['data_situacao_especial'] = this.dataSituacaoEspecial;
    data['capital_social'] = this.capitalSocial;
    return data;
  }
}