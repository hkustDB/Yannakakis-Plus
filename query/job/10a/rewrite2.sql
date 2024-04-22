create or replace view aggJoin8457523496862020757 as (
with aggView2669994474465324862 as (select id as v29 from role_type as rt where role= 'actor')
select movie_id as v31, person_role_id as v1, note as v12 from cast_info as ci, aggView2669994474465324862 where ci.role_id=aggView2669994474465324862.v29 and note LIKE '%(voice)%' and note LIKE '%(uncredited)%');
create or replace view aggJoin4845200816597294600 as (
with aggView640884267606734087 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView640884267606734087 where mc.company_type_id=aggView640884267606734087.v22);
create or replace view aggJoin6036446914969749502 as (
with aggView3812797552595271854 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin4845200816597294600 join aggView3812797552595271854 using(v15));
create or replace view aggJoin1060222828393700654 as (
with aggView1151907901437966952 as (select v31 from aggJoin6036446914969749502 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView1151907901437966952 where t.id=aggView1151907901437966952.v31 and production_year>2005);
create or replace view aggJoin8932391534382284754 as (
with aggView1784129846406593747 as (select v31, MIN(v32) as v44 from aggJoin1060222828393700654 group by v31)
select v1, v12, v44 from aggJoin8457523496862020757 join aggView1784129846406593747 using(v31));
create or replace view aggJoin8106227556127148876 as (
with aggView3468846388067015995 as (select v1, MIN(v44) as v44 from aggJoin8932391534382284754 group by v1,v44)
select name as v2, v44 from char_name as chn, aggView3468846388067015995 where chn.id=aggView3468846388067015995.v1);
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin8106227556127148876;
