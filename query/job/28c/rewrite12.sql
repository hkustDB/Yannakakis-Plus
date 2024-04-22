create or replace view aggView2096424510281991243 as select id as v9, name as v10 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin53431363967473793 as (
with aggView9049126518872676545 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView9049126518872676545 where t.kind_id=aggView9049126518872676545.v25 and production_year>2005);
create or replace view aggView3601874289089105266 as select v46, v45 from aggJoin53431363967473793 group by v46,v45;
create or replace view aggJoin3868469357862597922 as (
with aggView8972698732094885329 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView8972698732094885329 where mi_idx.info_type_id=aggView8972698732094885329.v20);
create or replace view aggJoin6185465558556372649 as (
with aggView1651730807409842594 as (select v40, v45 from aggJoin3868469357862597922 group by v40,v45)
select v45, v40 from aggView1651730807409842594 where v40<'8.5');
create or replace view aggJoin5277746080542983607 as (
with aggView3709193716544241453 as (select v45, MIN(v46) as v59 from aggView3601874289089105266 group by v45)
select v45, v40, v59 from aggJoin6185465558556372649 join aggView3709193716544241453 using(v45));
create or replace view aggJoin3676102853858118595 as (
with aggView2915392377904626395 as (select v9, MIN(v10) as v57 from aggView2096424510281991243 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView2915392377904626395 where mc.company_id=aggView2915392377904626395.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8997541243710063483 as (
with aggView7418490632750597875 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView7418490632750597875 where cc.subject_id=aggView7418490632750597875.v5);
create or replace view aggJoin1792502267083914892 as (
with aggView1865802199198759024 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin3676102853858118595 join aggView1865802199198759024 using(v16));
create or replace view aggJoin2467992463383335438 as (
with aggView2069275573855089590 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin8997541243710063483 join aggView2069275573855089590 using(v7));
create or replace view aggJoin9060108595245552303 as (
with aggView4999058401312188897 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView4999058401312188897 where mk.keyword_id=aggView4999058401312188897.v22);
create or replace view aggJoin7809072050863031065 as (
with aggView7039867854452160006 as (select v45 from aggJoin9060108595245552303 group by v45)
select v45, v31, v57 as v57 from aggJoin1792502267083914892 join aggView7039867854452160006 using(v45));
create or replace view aggJoin836223809568984747 as (
with aggView6570440449257387368 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView6570440449257387368 where mi.info_type_id=aggView6570440449257387368.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin3688124061459116209 as (
with aggView5356309186504796182 as (select v45 from aggJoin836223809568984747 group by v45)
select v45 from aggJoin2467992463383335438 join aggView5356309186504796182 using(v45));
create or replace view aggJoin2208723794898304256 as (
with aggView5237951066138650529 as (select v45 from aggJoin3688124061459116209 group by v45)
select v45, v31, v57 as v57 from aggJoin7809072050863031065 join aggView5237951066138650529 using(v45));
create or replace view aggJoin4818239281471823937 as (
with aggView289057715991127966 as (select v45, MIN(v57) as v57 from aggJoin2208723794898304256 group by v45,v57)
select v40, v59 as v59, v57 from aggJoin5277746080542983607 join aggView289057715991127966 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin4818239281471823937;
