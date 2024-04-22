create or replace view pAux16 as select nr as v1, label as v2 from product;
create or replace view semiJoinView7964418480174870140 as select product as v1, productFeature as v22 from productfeatureproduct AS pfp1 where (productFeature) in (select (productFeature) from productfeatureproduct AS pfp2);
create or replace view semiJoinView1533235341963123387 as select v1, v2 from pAux16 where (v1) in (select (v1) from semiJoinView7964418480174870140);
select distinct v1, v2 from semiJoinView1533235341963123387;
