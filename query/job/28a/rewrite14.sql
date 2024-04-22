create or replace view aggJoin1221350304735698977 as (
with aggView5192353711835941818 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView5192353711835941818 where mc.company_id=aggView5192353711835941818.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8787751232006490486 as (
with aggView1762101649622037084 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView1762101649622037084 where mk.keyword_id=aggView1762101649622037084.v22);
create or replace view aggJoin4596225493114608516 as (
with aggView1463080575171471361 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView1463080575171471361 where mi.info_type_id=aggView1463080575171471361.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin5326467405027421311 as (
with aggView4231350590927572317 as (select v45 from aggJoin4596225493114608516 group by v45)
select v45 from aggJoin8787751232006490486 join aggView4231350590927572317 using(v45));
create or replace view aggJoin3532220928510547126 as (
with aggView4039115417808730131 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView4039115417808730131 where cc.status_id=aggView4039115417808730131.v7);
create or replace view aggJoin6120020591795451357 as (
with aggView4748206401195411070 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin3532220928510547126 join aggView4748206401195411070 using(v5));
create or replace view aggJoin1044941716777902437 as (
with aggView1368314911717714832 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin1221350304735698977 join aggView1368314911717714832 using(v16));
create or replace view aggJoin3446870188069042638 as (
with aggView4432728283324157888 as (select v45 from aggJoin6120020591795451357 group by v45)
select v45, v31, v57 as v57 from aggJoin1044941716777902437 join aggView4432728283324157888 using(v45));
create or replace view aggJoin3851833456071752455 as (
with aggView3993492921282711238 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView3993492921282711238 where mi_idx.info_type_id=aggView3993492921282711238.v20 and info<'8.5');
create or replace view aggJoin4501700085280101577 as (
with aggView1546962482210002014 as (select v45, MIN(v40) as v58 from aggJoin3851833456071752455 group by v45)
select id as v45, title as v46, kind_id as v25, production_year as v49, v58 from title as t, aggView1546962482210002014 where t.id=aggView1546962482210002014.v45 and production_year>2000);
create or replace view aggJoin6265937276260381843 as (
with aggView6768895494262742827 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select v45, v46, v49, v58 from aggJoin4501700085280101577 join aggView6768895494262742827 using(v25));
create or replace view aggJoin8664141778909918461 as (
with aggView7703876504705211154 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin6265937276260381843 group by v45,v58)
select v45, v31, v57 as v57, v58, v59 from aggJoin3446870188069042638 join aggView7703876504705211154 using(v45));
create or replace view aggJoin1534172223986002081 as (
with aggView1299648285548141316 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v59) as v59 from aggJoin8664141778909918461 group by v45,v58,v59,v57)
select v57, v58, v59 from aggJoin5326467405027421311 join aggView1299648285548141316 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin1534172223986002081;
