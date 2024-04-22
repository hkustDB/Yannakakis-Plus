create or replace view aggJoin3436936588351676930 as (
with aggView6216123783203251822 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView6216123783203251822 where mc.company_id=aggView6216123783203251822.v25);
create or replace view aggJoin5574526866086955935 as (
with aggView4357902183956934916 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView4357902183956934916 where ml.link_type_id=aggView4357902183956934916.v21);
create or replace view aggJoin5047181299777045556 as (
with aggView8041268570999388466 as (select id as v37, title as v54 from title as t where production_year= 1998)
select movie_id as v37, keyword_id as v35, v54 from movie_keyword as mk, aggView8041268570999388466 where mk.movie_id=aggView8041268570999388466.v37);
create or replace view aggJoin3919774815974162907 as (
with aggView287233398341641192 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView287233398341641192 where cc.subject_id=aggView287233398341641192.v5);
create or replace view aggJoin4691650747594191556 as (
with aggView3996804769335260896 as (select id as v35 from keyword as k where keyword= 'sequel')
select v37, v54 from aggJoin5047181299777045556 join aggView3996804769335260896 using(v35));
create or replace view aggJoin4598443855721092870 as (
with aggView2854792149504184739 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin3919774815974162907 join aggView2854792149504184739 using(v7));
create or replace view aggJoin2446134919203988230 as (
with aggView8890455134264162116 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin3436936588351676930 join aggView8890455134264162116 using(v26));
create or replace view aggJoin6650720776367427580 as (
with aggView850059722911964934 as (select v37, MIN(v52) as v52 from aggJoin2446134919203988230 group by v37,v52)
select movie_id as v37, info as v31, v52 from movie_info as mi, aggView850059722911964934 where mi.movie_id=aggView850059722911964934.v37 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin4671839794391063898 as (
with aggView5023520458400013984 as (select v37, MIN(v52) as v52 from aggJoin6650720776367427580 group by v37,v52)
select v37, v54 as v54, v52 from aggJoin4691650747594191556 join aggView5023520458400013984 using(v37));
create or replace view aggJoin7234573174308531004 as (
with aggView4282277150036701055 as (select v37, MIN(v53) as v53 from aggJoin5574526866086955935 group by v37,v53)
select v37, v53 from aggJoin4598443855721092870 join aggView4282277150036701055 using(v37));
create or replace view aggJoin2694319359488484064 as (
with aggView3347434207443942890 as (select v37, MIN(v53) as v53 from aggJoin7234573174308531004 group by v37,v53)
select v54 as v54, v52 as v52, v53 from aggJoin4671839794391063898 join aggView3347434207443942890 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin2694319359488484064;
