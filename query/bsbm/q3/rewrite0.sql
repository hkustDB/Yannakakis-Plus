create or replace view pAux37 as select nr as v1, label as v2 from product;
create or replace view semiJoinView5962506946890837814 as select v1, v2 from pAux37 where (v1) in (select (product) from producttypeproduct AS ptp);
create or replace view semiJoinView1264733822639197 as select v1, v2 from semiJoinView5962506946890837814 where (v1) in (select (product) from productfeatureproduct AS pfp);
select distinct v1, v2 from semiJoinView1264733822639197;
