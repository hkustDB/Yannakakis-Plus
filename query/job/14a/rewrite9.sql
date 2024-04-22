create or replace view aggJoin4195604162990986260 as (
with aggView8706531768265332619 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView8706531768265332619 where mi_idx.info_type_id=aggView8706531768265332619.v3);
create or replace view aggJoin9020135884039689724 as (
with aggView6983800763230199157 as (select v23, v18 from aggJoin4195604162990986260 group by v23,v18)
select v23, v18 from aggView6983800763230199157 where v18<'8.5');
create or replace view aggJoin937932835487342966 as (
with aggView5124658610466788319 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView5124658610466788319 where mk.keyword_id=aggView5124658610466788319.v5);
create or replace view aggJoin9069462143123913276 as (
with aggView7813666593969828160 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView7813666593969828160 where mi.info_type_id=aggView7813666593969828160.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin5724753604002321105 as (
with aggView2496704045856697618 as (select v23 from aggJoin9069462143123913276 group by v23)
select v23 from aggJoin937932835487342966 join aggView2496704045856697618 using(v23));
create or replace view aggJoin9062428292274429294 as (
with aggView2931281774985137531 as (select v23 from aggJoin5724753604002321105 group by v23)
select id as v23, title as v24, kind_id as v8, production_year as v27 from title as t, aggView2931281774985137531 where t.id=aggView2931281774985137531.v23 and production_year>2010);
create or replace view aggJoin1754766489714286333 as (
with aggView1581134986913774347 as (select id as v8 from kind_type as kt where kind= 'movie')
select v23, v24, v27 from aggJoin9062428292274429294 join aggView1581134986913774347 using(v8));
create or replace view aggView7076081659148734691 as select v23, v24 from aggJoin1754766489714286333 group by v23,v24;
create or replace view aggJoin179143211669741266 as (
with aggView6770311424788886008 as (select v23, MIN(v18) as v35 from aggJoin9020135884039689724 group by v23)
select v24, v35 from aggView7076081659148734691 join aggView6770311424788886008 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin179143211669741266;
