create or replace view aggView1150651442294886152 as select id as v37, title as v41 from title as t where production_year= 1998;
create or replace view aggView7084739056906054502 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin7827964259720074527 as (
with aggView5587950853249474869 as (select v25, MIN(v10) as v52 from aggView7084739056906054502 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView5587950853249474869 where mc.company_id=aggView5587950853249474869.v25);
create or replace view aggJoin7135278962293858947 as (
with aggView8896273634977786831 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id)
select movie_id as v37, subject_id as v5, status_id as v7 from complete_cast as cc, aggView8896273634977786831 where cc.movie_id=aggView8896273634977786831.v37);
create or replace view aggJoin6694851839608907637 as (
with aggView3116583158223622194 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v37, v7 from aggJoin7135278962293858947 join aggView3116583158223622194 using(v5));
create or replace view aggJoin1182283365167479843 as (
with aggView4685787363917285115 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView4685787363917285115 where mk.keyword_id=aggView4685787363917285115.v35);
create or replace view aggJoin7787002871839778723 as (
with aggView458038881977619155 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin6694851839608907637 join aggView458038881977619155 using(v7));
create or replace view aggJoin5965635593182960329 as (
with aggView8432794676081776394 as (select v37 from aggJoin7787002871839778723 group by v37)
select v37 from aggJoin1182283365167479843 join aggView8432794676081776394 using(v37));
create or replace view aggJoin3571675861296800860 as (
with aggView7144312487231406506 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin7827964259720074527 join aggView7144312487231406506 using(v26));
create or replace view aggJoin890674550942474845 as (
with aggView4800250466814058596 as (select v37, MIN(v52) as v52 from aggJoin3571675861296800860 group by v37,v52)
select v37, v41, v52 from aggView1150651442294886152 join aggView4800250466814058596 using(v37));
create or replace view aggJoin5517446599089172895 as (
with aggView5978751052048956112 as (select v37, MIN(v52) as v52, MIN(v41) as v54 from aggJoin890674550942474845 group by v37,v52)
select movie_id as v37, link_type_id as v21, v52, v54 from movie_link as ml, aggView5978751052048956112 where ml.movie_id=aggView5978751052048956112.v37);
create or replace view aggJoin2927931157506100910 as (
with aggView6131734311130647085 as (select v37 from aggJoin5965635593182960329 group by v37)
select v21, v52 as v52, v54 as v54 from aggJoin5517446599089172895 join aggView6131734311130647085 using(v37));
create or replace view aggJoin8090165700649625561 as (
with aggView2784223684946187999 as (select v21, MIN(v52) as v52, MIN(v54) as v54 from aggJoin2927931157506100910 group by v21,v52,v54)
select link as v22, v52, v54 from link_type as lt, aggView2784223684946187999 where lt.id=aggView2784223684946187999.v21 and link LIKE '%follow%');
select MIN(v52) as v52,MIN(v22) as v53,MIN(v54) as v54 from aggJoin8090165700649625561;
