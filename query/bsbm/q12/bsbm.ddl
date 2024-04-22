CREATE TABLE productfeature (
  nr integer,
  label varchar,
  `comment` varchar,
  publisher integer,
  publishDate date,
  PRIMARY KEY (nr)
) WITH (
        'cardinality' = '289'
);

CREATE TABLE producttype (
  nr integer,
  label varchar,
  `comment` varchar,
  parent integer,
  publisher integer,
  publishDate date,
  PRIMARY KEY (nr)
) WITH (
        'cardinality' = '7'
);

CREATE TABLE producer (
  nr integer,
  label varchar,
  `comment` varchar,
  homepage varchar,
  country varchar,
  publisher integer,
  publishDate date,
  PRIMARY KEY (nr)
) WITH (
        'cardinality' = '1'
);

CREATE TABLE product (
  nr integer,
  label varchar,
  `comment` varchar,
  producer integer ,
  propertyNum1 integer,
  propertyNum2 integer,
  propertyNum3 integer,
  propertyNum4 integer,
  propertyNum5 integer,
  propertyNum6 integer,
  propertyTex1 varchar,
  propertyTex2 varchar,
  propertyTex3 varchar,
  propertyTex4 varchar,
  propertyTex5 varchar,
  propertyTex6 varchar,
  publisher integer,
  publishDate date,
  PRIMARY KEY (nr)
) WITH (
        'cardinality' = '10'
);

CREATE TABLE producttypeproduct (
  product integer,
  productType integer,
  PRIMARY KEY (product, productType)
) WITH (
        'cardinality' = '10'
);

CREATE TABLE productfeatureproduct (
  product integer,
  productFeature integer,
  PRIMARY KEY (product,productFeature)
) WITH (
        'cardinality' = '213'
);

CREATE TABLE vendor (
  nr integer,
  label varchar,
  `comment` varchar,
  homepage varchar,
  country varchar,
  publisher integer,
  publishDate date,
  PRIMARY KEY (nr)
) WITH (
        'cardinality' = '1'
);

CREATE TABLE offer (
  nr integer,
  product int,
  producer int,
  vendor int,
  price double,
  validFrom datetime,
  validTo datetime,
  deliveryDays integer,
  offerWebpage varchar,
  publisher integer,
  publishDate date,
  PRIMARY KEY (nr)
) WITH (
        'cardinality' = '200'
);

CREATE TABLE person (
  nr integer,
  name varchar,
  mbox_sha1sum char(40),
  country varchar,
  publisher integer,
  publishDate date,
  PRIMARY KEY (nr)
) WITH (
        'cardinality' = '6'
);

CREATE TABLE review (
  nr integer,
  product int,
  producer int,
  person int,
  reviewDate datetime,
  title varchar,
  text varchar,
  `language` varchar,
  rating1 integer,
  rating2 integer,
  rating3 integer,
  rating4 integer,
  publisher integer,
  publishDate date,
  PRIMARY KEY (nr)
) WITH (
        'cardinality' = '100'
);