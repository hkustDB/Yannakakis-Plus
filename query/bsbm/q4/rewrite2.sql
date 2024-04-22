create or replace view ptpAux22 as select product as v1 from producttypeproduct;
create or replace view pAux37 as select nr as v1, label as v2, propertyTex1 as v11 from product;
create or replace view semiJoinView3874417031704094388 as select v1, v2, v11 from pAux37 where (v1) in (select (product) from productfeatureproduct AS pfp2);
create or replace view semiJoinView5390112470239271824 as select v1, v2, v11 from semiJoinView3874417031704094388 where (v1) in (select (product) from productfeatureproduct AS pfp3);
create or replace view semiJoinView2725154085416290776 as select v1 from ptpAux22 where (v1) in (select (v1) from semiJoinView5390112470239271824);
create or replace view semiJoinView7981845556490582151 as select v1 from semiJoinView2725154085416290776 where (v1) in (select (product) from productfeatureproduct AS pfp1);
create or replace view semiEnum8242814066640026645 as (
select v2, v1, v11 from semiJoinView7981845556490582151 join semiJoinView5390112470239271824 using(v1));
create or replace view semiEnum8242814066640026645 as (
select v2, v1, v11 from semiJoinView7981845556490582151 join semiJoinView5390112470239271824 using(v1));
select distinct v1, v2, v11 from semiEnum8242814066640026645;
