create or replace view aggJoin823995988347726001 as (
with aggView505963327784977809 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView505963327784977809 where t.kind_id=aggView505963327784977809.v8 and production_year>2005);
create or replace view aggView3153917513075959654 as select v24, v23 from aggJoin823995988347726001 group by v24,v23;
create or replace view aggJoin7106810109050005510 as (
with aggView6613349850552846053 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView6613349850552846053 where mk.keyword_id=aggView6613349850552846053.v5);
create or replace view aggJoin52945021620876619 as (
with aggView753549168033541964 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView753549168033541964 where mi_idx.info_type_id=aggView753549168033541964.v3);
create or replace view aggJoin8734916624639611190 as (
with aggView1320206297786588762 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView1320206297786588762 where mi.info_type_id=aggView1320206297786588762.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8025785786135767667 as (
with aggView59193458066460325 as (select v23 from aggJoin7106810109050005510 group by v23)
select v23, v13 from aggJoin8734916624639611190 join aggView59193458066460325 using(v23));
create or replace view aggJoin1634050630205501674 as (
with aggView8708938198439461473 as (select v23 from aggJoin8025785786135767667 group by v23)
select v23, v18 from aggJoin52945021620876619 join aggView8708938198439461473 using(v23));
create or replace view aggJoin832109506506204465 as (
with aggView1933254296040199437 as (select v18, v23 from aggJoin1634050630205501674 group by v18,v23)
select v23, v18 from aggView1933254296040199437 where v18<'8.5');
create or replace view aggJoin4186543091686699981 as (
with aggView1960196556920305343 as (select v23, MIN(v24) as v36 from aggView3153917513075959654 group by v23)
select v18, v36 from aggJoin832109506506204465 join aggView1960196556920305343 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin4186543091686699981;
