create or replace view aggJoin5184122472666853260 as (
with aggView5255133069319201052 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView5255133069319201052 where mc.company_id=aggView5255133069319201052.v1);
create or replace view aggJoin232856555676729828 as (
with aggView7901607556855771238 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView7901607556855771238 where mi.info_type_id=aggView7901607556855771238.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin3016815066240161761 as (
with aggView3997217117366970694 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView3997217117366970694 where mk.keyword_id=aggView3997217117366970694.v14);
create or replace view aggJoin2364297535532086754 as (
with aggView1752168676528382250 as (select v37 from aggJoin232856555676729828 group by v37)
select id as v37, title as v38, kind_id as v17, production_year as v41 from title as t, aggView1752168676528382250 where t.id=aggView1752168676528382250.v37 and production_year>2005);
create or replace view aggJoin8047497692976186925 as (
with aggView2022844469082037147 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin5184122472666853260 join aggView2022844469082037147 using(v8));
create or replace view aggJoin5495144567905987787 as (
with aggView6122412627891677048 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView6122412627891677048 where mi_idx.info_type_id=aggView6122412627891677048.v12 and info<'8.5');
create or replace view aggJoin6851818523845386210 as (
with aggView402797235193139022 as (select v37, MIN(v32) as v50 from aggJoin5495144567905987787 group by v37)
select v37, v50 from aggJoin3016815066240161761 join aggView402797235193139022 using(v37));
create or replace view aggJoin3654591996956564569 as (
with aggView7281873621605276847 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41 from aggJoin2364297535532086754 join aggView7281873621605276847 using(v17));
create or replace view aggJoin521652939774102920 as (
with aggView5312634837043458750 as (select v37, MIN(v38) as v51 from aggJoin3654591996956564569 group by v37)
select v37, v49 as v49, v51 from aggJoin8047497692976186925 join aggView5312634837043458750 using(v37));
create or replace view aggJoin8831373091800709074 as (
with aggView7886997470960858453 as (select v37, MIN(v49) as v49, MIN(v51) as v51 from aggJoin521652939774102920 group by v37,v51,v49)
select v50 as v50, v49, v51 from aggJoin6851818523845386210 join aggView7886997470960858453 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin8831373091800709074;
