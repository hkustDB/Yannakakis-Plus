create or replace view aggView5444879376869754977 as select id as v9, name as v10 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin7583047972008016469 as (
with aggView1859409757970425886 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView1859409757970425886 where t.kind_id=aggView1859409757970425886.v25 and production_year>2005);
create or replace view aggView1909355543378514030 as select v46, v45 from aggJoin7583047972008016469 group by v46,v45;
create or replace view aggJoin6702415456928518553 as (
with aggView5265063902134740289 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView5265063902134740289 where cc.subject_id=aggView5265063902134740289.v5);
create or replace view aggJoin2293610935130104759 as (
with aggView5396432805070823020 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView5396432805070823020 where mi_idx.info_type_id=aggView5396432805070823020.v20 and info<'8.5');
create or replace view aggJoin2425511697494832104 as (
with aggView3228278382354490015 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin6702415456928518553 join aggView3228278382354490015 using(v7));
create or replace view aggJoin5535653251627061435 as (
with aggView3244218978174019657 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView3244218978174019657 where mk.keyword_id=aggView3244218978174019657.v22);
create or replace view aggJoin2881744721380124978 as (
with aggView3532207230685921385 as (select v45 from aggJoin2425511697494832104 group by v45)
select v45 from aggJoin5535653251627061435 join aggView3532207230685921385 using(v45));
create or replace view aggJoin2708930731642906815 as (
with aggView1513268741776646503 as (select v45 from aggJoin2881744721380124978 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView1513268741776646503 where mi.movie_id=aggView1513268741776646503.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1847949406187307798 as (
with aggView2023196106332568413 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin2708930731642906815 join aggView2023196106332568413 using(v18));
create or replace view aggJoin6480422974838926505 as (
with aggView8440926289048442350 as (select v45 from aggJoin1847949406187307798 group by v45)
select v45, v40 from aggJoin2293610935130104759 join aggView8440926289048442350 using(v45));
create or replace view aggView1665358970100188620 as select v40, v45 from aggJoin6480422974838926505 group by v40,v45;
create or replace view aggJoin6895757337846345602 as (
with aggView9169574529278081335 as (select v45, MIN(v46) as v59 from aggView1909355543378514030 group by v45)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v59 from movie_companies as mc, aggView9169574529278081335 where mc.movie_id=aggView9169574529278081335.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5655551536451366706 as (
with aggView3656142653524410520 as (select v45, MIN(v40) as v58 from aggView1665358970100188620 group by v45)
select v9, v16, v31, v59 as v59, v58 from aggJoin6895757337846345602 join aggView3656142653524410520 using(v45));
create or replace view aggJoin169645896031024836 as (
with aggView8138077482178146331 as (select id as v16 from company_type as ct)
select v9, v31, v59, v58 from aggJoin5655551536451366706 join aggView8138077482178146331 using(v16));
create or replace view aggJoin8649006755098719181 as (
with aggView1843132433743053471 as (select v9, MIN(v59) as v59, MIN(v58) as v58 from aggJoin169645896031024836 group by v9,v58,v59)
select v10, v59, v58 from aggView5444879376869754977 join aggView1843132433743053471 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin8649006755098719181;
