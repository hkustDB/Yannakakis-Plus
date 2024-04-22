create or replace view ptpAux22 as select product as v1 from producttypeproduct;
create or replace view pAux37 as select nr as v1, label as v2, propertyTex1 as v11 from product;
create or replace view semiJoinView4366808820513420001 as select v1, v2, v11 from pAux37 where (v1) in (select (product) from productfeatureproduct AS pfp1);
create or replace view semiJoinView7487850708479836186 as select v1, v2, v11 from semiJoinView4366808820513420001 where (v1) in (select (product) from productfeatureproduct AS pfp2);
create or replace view semiJoinView8921439065199986256 as select v1, v2, v11 from semiJoinView7487850708479836186 where (v1) in (select (product) from productfeatureproduct AS pfp3);
create or replace view semiJoinView3152552629887156129 as select v1 from ptpAux22 where (v1) in (select (v1) from semiJoinView8921439065199986256);
create or replace view semiEnum2429244845663693312 as (
select v2, v1, v11 from semiJoinView3152552629887156129 join semiJoinView8921439065199986256 using(v1));
create or replace view semiEnum2429244845663693312 as (
select v2, v1, v11 from semiJoinView3152552629887156129 join semiJoinView8921439065199986256 using(v1));
select distinct v1, v2, v11 from semiEnum2429244845663693312;
