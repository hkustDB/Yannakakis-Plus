create or replace view aggView1345141158155955142 as select title as v32, id as v31 from title as t where production_year>=2008 and production_year<=2014;
create or replace view aggJoin908353987579780410 as (
with aggView5434697714846995413 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView5434697714846995413 where ci.person_id=aggView5434697714846995413.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5202834119739273512 as (
with aggView8694279473271996721 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView8694279473271996721 where mi.info_type_id=aggView8694279473271996721.v8 and info IN ('Horror','Thriller'));
create or replace view aggJoin8044945169827720972 as (
with aggView3604563442327923620 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView3604563442327923620 where mi_idx.info_type_id=aggView3604563442327923620.v10);
create or replace view aggJoin1412618066225713829 as (
with aggView8195670045991691886 as (select v31, v20 from aggJoin8044945169827720972 group by v31,v20)
select v31, v20 from aggView8195670045991691886 where v20>'8.0');
create or replace view aggJoin3714147257682239923 as (
with aggView342315804024532700 as (select v31 from aggJoin908353987579780410 group by v31)
select v31, v15 from aggJoin5202834119739273512 join aggView342315804024532700 using(v31));
create or replace view aggView5443122152289337799 as select v15, v31 from aggJoin3714147257682239923 group by v15,v31;
create or replace view aggJoin2965727367408726418 as (
with aggView5450686436209238302 as (select v31, MIN(v15) as v43 from aggView5443122152289337799 group by v31)
select v31, v20, v43 from aggJoin1412618066225713829 join aggView5450686436209238302 using(v31));
create or replace view aggJoin3183597035300505473 as (
with aggView2808726247532542043 as (select v31, MIN(v43) as v43, MIN(v20) as v44 from aggJoin2965727367408726418 group by v31,v43)
select v32, v43, v44 from aggView1345141158155955142 join aggView2808726247532542043 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin3183597035300505473;
