create or replace view aggJoin8771234078295496430 as (
with aggView7512997440917956082 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView7512997440917956082 where ci.person_id=aggView7512997440917956082.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5543456166326441133 as (
with aggView2832072089360512889 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView2832072089360512889 where mi_idx.info_type_id=aggView2832072089360512889.v10 and info>'8.0');
create or replace view aggJoin8648010419198868511 as (
with aggView7585622516674329283 as (select v31, MIN(v20) as v44 from aggJoin5543456166326441133 group by v31)
select id as v31, title as v32, production_year as v35, v44 from title as t, aggView7585622516674329283 where t.id=aggView7585622516674329283.v31 and production_year>=2008 and production_year<=2014);
create or replace view aggJoin108729945009401214 as (
with aggView3964293307157753030 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView3964293307157753030 where mi.info_type_id=aggView3964293307157753030.v8 and info IN ('Horror','Thriller'));
create or replace view aggJoin5628622355757344857 as (
with aggView7844904059682258618 as (select v31, MIN(v15) as v43 from aggJoin108729945009401214 group by v31)
select v31, v32, v35, v44 as v44, v43 from aggJoin8648010419198868511 join aggView7844904059682258618 using(v31));
create or replace view aggJoin3504205193947385711 as (
with aggView5216660872357164869 as (select v31, MIN(v44) as v44, MIN(v43) as v43, MIN(v32) as v45 from aggJoin5628622355757344857 group by v31,v43,v44)
select v44, v43, v45 from aggJoin8771234078295496430 join aggView5216660872357164869 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3504205193947385711;
