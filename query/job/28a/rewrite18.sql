create or replace view aggJoin2380727289197428242 as (
with aggView7456437575526962401 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView7456437575526962401 where mc.company_id=aggView7456437575526962401.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin7853297106234428627 as (
with aggView1028533764317062434 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView1028533764317062434 where mk.keyword_id=aggView1028533764317062434.v22);
create or replace view aggJoin4264797198441214179 as (
with aggView8214172740072662795 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView8214172740072662795 where mi.info_type_id=aggView8214172740072662795.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8383806488594547280 as (
with aggView90182097841856130 as (select v45 from aggJoin4264797198441214179 group by v45)
select v45 from aggJoin7853297106234428627 join aggView90182097841856130 using(v45));
create or replace view aggJoin9130594251228492121 as (
with aggView7480760423961826536 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView7480760423961826536 where cc.status_id=aggView7480760423961826536.v7);
create or replace view aggJoin6893630052555387411 as (
with aggView8030008569449159792 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin9130594251228492121 join aggView8030008569449159792 using(v5));
create or replace view aggJoin5732486322914789593 as (
with aggView4411955522712841337 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin2380727289197428242 join aggView4411955522712841337 using(v16));
create or replace view aggJoin6954804356605514124 as (
with aggView2581165641602395253 as (select v45 from aggJoin6893630052555387411 group by v45)
select v45, v31, v57 as v57 from aggJoin5732486322914789593 join aggView2581165641602395253 using(v45));
create or replace view aggJoin4968936545646763695 as (
with aggView2354700140462253710 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView2354700140462253710 where mi_idx.info_type_id=aggView2354700140462253710.v20 and info<'8.5');
create or replace view aggJoin4408127158107264176 as (
with aggView121894963426143302 as (select v45, MIN(v40) as v58 from aggJoin4968936545646763695 group by v45)
select v45, v31, v57 as v57, v58 from aggJoin6954804356605514124 join aggView121894963426143302 using(v45));
create or replace view aggJoin8614422883390521113 as (
with aggView3535211600502915225 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView3535211600502915225 where t.kind_id=aggView3535211600502915225.v25 and production_year>2000);
create or replace view aggJoin4986176230674230163 as (
with aggView8930146408654636555 as (select v45, MIN(v46) as v59 from aggJoin8614422883390521113 group by v45)
select v45, v31, v57 as v57, v58 as v58, v59 from aggJoin4408127158107264176 join aggView8930146408654636555 using(v45));
create or replace view aggJoin2356211146512992176 as (
with aggView7320616316368482030 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v59) as v59 from aggJoin4986176230674230163 group by v45,v58,v59,v57)
select v57, v58, v59 from aggJoin8383806488594547280 join aggView7320616316368482030 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin2356211146512992176;
