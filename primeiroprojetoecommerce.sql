create database ecommerce;
use ecommerce;

-- Criando Tabela para armazenar informações dos clientes
create table clients(
	idClient INT auto_increment primary key,
	Fname varchar(11),
	Minit char(3),
	Lname varchar(20),
	CPF char(11) not null,
	Adress varchar(30),
	constraint unique_cpf_client unique(CPF)
);

-- Criando Tabela para armazenar informações dos produtos
create table product(
	idProduct INT auto_increment primary key,
	Pname varchar(11),
	classification_kids bool,
	category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos') not null,
	avaliacao float default 0,
	size varchar(10),
	constraint unique_product_name unique(Pname)
);

-- Criando Tabela para armazenar informações de pagamentos
create table payments(
	idPayment int auto_increment primary key,
	idClient int,
	typePayment enum('Cartão','Dinheiro','Pix','Vários Cartões','Boleto'),
	limitAvailable float,
	constraint fk_payments_client foreign key (idClient) references clients(idClient)
);

-- Criando Tabela para armazenar informações de pedidos
create table orders(
	idOrder int auto_increment primary key,
	idOrderClient int,
	orderStatus enum('Cancelado','Confirmado','Em processamento') not null,
	orderDescription varchar(260),
	sendValue float default 10,
	paymentCash bool default false,
	constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

-- Criando Tabela para armazenar informações de estoque de produtos
create table productStorage(
	idProdStorage int auto_increment primary key,
	storageLocation varchar(255),
	quantity int default 0
);

-- Criando Tabela para armazenar informações de fornecedores
create table supplier(
	idSupplier int auto_increment primary key,
	socialName varchar(255) not null,
	CNPJ char(15) not null,
	contact char(11) not null,
	constraint unique_supplier unique (CNPJ)
);

-- Criando Tabela para armazenar informações de vendedores
create table seller(
	idSeller int auto_increment primary key,
	SocialName VARCHAR(255) not null,
	AbstName varchar(255),
	CNPJ char(15),
	CPF char (9),
	location varchar(255), -- Adicione o tipo de dado para a localização
	contact CHAR(11) not NULL,
	constraint UNIQUE_cnpj_seller UNIQUE (CNPJ),
	constraint UNIQUE_cpf_seller unique(CPF)
);

-- Criando Tabela productSeller
create table productSeller(
	idPseller int,
	idProduct int,
	prodQuantity int DEFAULT 1,
	PRIMARY KEY (idPseller, idProduct),
	constraint fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
	constraint fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

-- Criando Tabela para relacionar os produtos e pedidos
create table productOrder(
	idPOproduct int,
	idPOorder int,
	poQuantity int default 1,
	poStatus enum('Disponível','Sem estoque') default 'Disponível',
	primary key (idPOproduct, idPOorder),
	constraint fk_product_order_product foreign key (idPOproduct) references product(idProduct),
	constraint fk_product_order_order foreign key (idPOorder) references orders(idOrder)
);

-- Criando Tabela Localização do estoque
create table storageLocation(
	idLProduct int,
	idLstorage int,
	location varchar(255) not null,
	primary key (idLproduct, idLstorage),
	constraint fk_storage_location_product foreign key (idLProduct) references product(idProduct),
	constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

show tables;
