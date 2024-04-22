create or replace view pAux37 as select nr as v1, label as v2, propertyTex1 as v11 from product;
create or replace view ptpAux22 as select product as v1 from producttypeproduct;
create or replace view semiJoinView4262783605398023938 as select v1, v2, v11 from pAux37 where (v1) in (select (product) from productfeatureproduct AS pfp1);
create or replace view semiJoinView1769204615223929021 as select v1 from ptpAux22 where (v1) in (select (product) from productfeatureproduct AS pfp2);
create or replace view semiJoinView4021972227360412763 as select v1, v2, v11 from semiJoinView4262783605398023938 where (v1) in (select (product) from productfeatureproduct AS pfp3);
create or replace view semiJoinView8385151560516559072 as select v1 from semiJoinView1769204615223929021 where (v1) in (select (v1) from semiJoinView4021972227360412763);
create or replace view semiEnum7945819833967815604 as (
select v2, v1, v11 from semiJoinView8385151560516559072 join semiJoinView4021972227360412763 using(v1));
create or replace view semiEnum7945819833967815604 as (
select v2, v1, v11 from semiJoinView8385151560516559072 join semiJoinView4021972227360412763 using(v1));
select distinct v1, v2, v11 from semiEnum7945819833967815604;
