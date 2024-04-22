create or replace view aggView2173864752455251022 as select name as v2, id as v1 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin8121718520991977849 as (
with aggView5905237844028793534 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView5905237844028793534 where mi.info_type_id=aggView5905237844028793534.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin458487517241735379 as (
with aggView399035519579155946 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView399035519579155946 where mk.keyword_id=aggView399035519579155946.v14);
create or replace view aggJoin3044876982858880219 as (
with aggView6376160372630494141 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView6376160372630494141 where mi_idx.info_type_id=aggView6376160372630494141.v12);
create or replace view aggJoin1601797476548411994 as (
with aggView6922819300495131949 as (select v32, v37 from aggJoin3044876982858880219 group by v32,v37)
select v37, v32 from aggView6922819300495131949 where v32<'8.5');
create or replace view aggJoin5059651595615645680 as (
with aggView1405926414677528521 as (select v37 from aggJoin458487517241735379 group by v37)
select v37, v27 from aggJoin8121718520991977849 join aggView1405926414677528521 using(v37));
create or replace view aggJoin3199853131788431833 as (
with aggView1931861323936264750 as (select v37 from aggJoin5059651595615645680 group by v37)
select id as v37, title as v38, kind_id as v17, production_year as v41 from title as t, aggView1931861323936264750 where t.id=aggView1931861323936264750.v37 and production_year>2005);
create or replace view aggJoin114477920189705401 as (
with aggView207279223565157456 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41 from aggJoin3199853131788431833 join aggView207279223565157456 using(v17));
create or replace view aggView2253249696302146319 as select v37, v38 from aggJoin114477920189705401 group by v37,v38;
create or replace view aggJoin8629879939213082812 as (
with aggView6866657712288641778 as (select v1, MIN(v2) as v49 from aggView2173864752455251022 group by v1)
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView6866657712288641778 where mc.company_id=aggView6866657712288641778.v1);
create or replace view aggJoin6179583839272896973 as (
with aggView4488153885527894469 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin8629879939213082812 join aggView4488153885527894469 using(v8));
create or replace view aggJoin8969358525131000783 as (
with aggView5007201958001531612 as (select v37, MIN(v49) as v49 from aggJoin6179583839272896973 group by v37,v49)
select v37, v32, v49 from aggJoin1601797476548411994 join aggView5007201958001531612 using(v37));
create or replace view aggJoin5890065411458318597 as (
with aggView7344501125033546788 as (select v37, MIN(v49) as v49, MIN(v32) as v50 from aggJoin8969358525131000783 group by v37,v49)
select v38, v49, v50 from aggView2253249696302146319 join aggView7344501125033546788 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v38) as v51 from aggJoin5890065411458318597;
