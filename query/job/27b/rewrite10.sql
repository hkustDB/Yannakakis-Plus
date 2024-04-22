create or replace view aggJoin1179123383358536840 as (
with aggView2738424046454268564 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView2738424046454268564 where mc.company_id=aggView2738424046454268564.v25);
create or replace view aggJoin126442442527082130 as (
with aggView1497926385232806419 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView1497926385232806419 where ml.link_type_id=aggView1497926385232806419.v21);
create or replace view aggJoin2369444878203512881 as (
with aggView2262745535681872109 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView2262745535681872109 where cc.subject_id=aggView2262745535681872109.v5);
create or replace view aggJoin1359295892936819301 as (
with aggView6015705081448550319 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView6015705081448550319 where mk.keyword_id=aggView6015705081448550319.v35);
create or replace view aggJoin1827977650556196496 as (
with aggView2816943329237761315 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin2369444878203512881 join aggView2816943329237761315 using(v7));
create or replace view aggJoin7432418827204449979 as (
with aggView2107564933387961103 as (select v37 from aggJoin1827977650556196496 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView2107564933387961103 where mi.movie_id=aggView2107564933387961103.v37 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin4426309345650163956 as (
with aggView4397165080244173762 as (select v37 from aggJoin7432418827204449979 group by v37)
select v37 from aggJoin1359295892936819301 join aggView4397165080244173762 using(v37));
create or replace view aggJoin2089401086785142556 as (
with aggView5094511893127733695 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin1179123383358536840 join aggView5094511893127733695 using(v26));
create or replace view aggJoin8281146719117355415 as (
with aggView2096546736956666793 as (select v37, MIN(v52) as v52 from aggJoin2089401086785142556 group by v37,v52)
select id as v37, title as v41, production_year as v44, v52 from title as t, aggView2096546736956666793 where t.id=aggView2096546736956666793.v37 and production_year= 1998);
create or replace view aggJoin2584054526913935243 as (
with aggView8020419063389657080 as (select v37, MIN(v52) as v52, MIN(v41) as v54 from aggJoin8281146719117355415 group by v37,v52)
select v37, v53 as v53, v52, v54 from aggJoin126442442527082130 join aggView8020419063389657080 using(v37));
create or replace view aggJoin3121560568146354760 as (
with aggView465929921798092154 as (select v37, MIN(v53) as v53, MIN(v52) as v52, MIN(v54) as v54 from aggJoin2584054526913935243 group by v37,v53,v52,v54)
select v53, v52, v54 from aggJoin4426309345650163956 join aggView465929921798092154 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin3121560568146354760;
