create or replace view aggJoin6444624486476465899 as (
with aggView6204119064825700138 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView6204119064825700138 where mc.company_id=aggView6204119064825700138.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin7332492428465103855 as (
with aggView2748577201686040621 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin6444624486476465899 join aggView2748577201686040621 using(v8));
create or replace view aggJoin845736126072517150 as (
with aggView3680546274835700357 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3680546274835700357 where mi_idx.info_type_id=aggView3680546274835700357.v12 and info<'7.0');
create or replace view aggJoin544943350720135680 as (
with aggView6235684152127614168 as (select v37, MIN(v32) as v50 from aggJoin845736126072517150 group by v37)
select movie_id as v37, keyword_id as v14, v50 from movie_keyword as mk, aggView6235684152127614168 where mk.movie_id=aggView6235684152127614168.v37);
create or replace view aggJoin4100492895278455371 as (
with aggView277900370566928272 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView277900370566928272 where t.kind_id=aggView277900370566928272.v17 and production_year>2008);
create or replace view aggJoin804416659061821646 as (
with aggView3452867047539210309 as (select v37, MIN(v38) as v51 from aggJoin4100492895278455371 group by v37)
select v37, v23, v49 as v49, v51 from aggJoin7332492428465103855 join aggView3452867047539210309 using(v37));
create or replace view aggJoin5078497758305822918 as (
with aggView1731250435791241440 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView1731250435791241440 where mi.info_type_id=aggView1731250435791241440.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin4342663579852366845 as (
with aggView5932386668240658186 as (select v37, MIN(v49) as v49, MIN(v51) as v51 from aggJoin804416659061821646 group by v37,v49,v51)
select v37, v27, v49, v51 from aggJoin5078497758305822918 join aggView5932386668240658186 using(v37));
create or replace view aggJoin6155528259535998387 as (
with aggView4868329356419482407 as (select v37, MIN(v49) as v49, MIN(v51) as v51 from aggJoin4342663579852366845 group by v37,v49,v51)
select v14, v50 as v50, v49, v51 from aggJoin544943350720135680 join aggView4868329356419482407 using(v37));
create or replace view aggJoin13047166285280300 as (
with aggView527700344229711297 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v50, v49, v51 from aggJoin6155528259535998387 join aggView527700344229711297 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin13047166285280300;
