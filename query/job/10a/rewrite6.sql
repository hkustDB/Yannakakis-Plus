create or replace view aggJoin38325546877847670 as (
with aggView935683880991964603 as (select id as v1, name as v43 from char_name as chn)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView935683880991964603 where ci.person_role_id=aggView935683880991964603.v1 and note LIKE '%(voice)%' and note LIKE '%(uncredited)%');
create or replace view aggJoin3713918244580619867 as (
with aggView5526591065438020249 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v12, v43 from aggJoin38325546877847670 join aggView5526591065438020249 using(v29));
create or replace view aggJoin1609643642762226744 as (
with aggView4888942522935581005 as (select v31, MIN(v43) as v43 from aggJoin3713918244580619867 group by v31,v43)
select id as v31, title as v32, production_year as v35, v43 from title as t, aggView4888942522935581005 where t.id=aggView4888942522935581005.v31 and production_year>2005);
create or replace view aggJoin6708727614621052064 as (
with aggView1180689008577765048 as (select v31, MIN(v43) as v43, MIN(v32) as v44 from aggJoin1609643642762226744 group by v31,v43)
select company_id as v15, company_type_id as v22, v43, v44 from movie_companies as mc, aggView1180689008577765048 where mc.movie_id=aggView1180689008577765048.v31);
create or replace view aggJoin770537081724886780 as (
with aggView3324485277051510394 as (select id as v22 from company_type as ct)
select v15, v43, v44 from aggJoin6708727614621052064 join aggView3324485277051510394 using(v22));
create or replace view aggJoin721725682738489917 as (
with aggView6473664429425390896 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v43, v44 from aggJoin770537081724886780 join aggView6473664429425390896 using(v15));
select MIN(v43) as v43,MIN(v44) as v44 from aggJoin721725682738489917;
