create or replace view aggJoin6380036803349877055 as (
with aggView8512072637366672981 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView8512072637366672981 where t.kind_id=aggView8512072637366672981.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin906077260742217698 as (
with aggView1110692501580490789 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView1110692501580490789 where mi_idx.info_type_id=aggView1110692501580490789.v3);
create or replace view aggJoin3194173041228546666 as (
with aggView1597827668330776721 as (select v23, v18 from aggJoin906077260742217698 group by v23,v18)
select v23, v18 from aggView1597827668330776721 where v18>'6.0');
create or replace view aggJoin1613868291108062628 as (
with aggView3846292383907608288 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView3846292383907608288 where mi.info_type_id=aggView3846292383907608288.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin2871665688774437153 as (
with aggView8907524456457139363 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView8907524456457139363 where mk.keyword_id=aggView8907524456457139363.v5);
create or replace view aggJoin6733399252225529405 as (
with aggView4953627219245640042 as (select v23 from aggJoin1613868291108062628 group by v23)
select v23 from aggJoin2871665688774437153 join aggView4953627219245640042 using(v23));
create or replace view aggJoin8821178211843608780 as (
with aggView8121893916333748523 as (select v23 from aggJoin6733399252225529405 group by v23)
select v23, v24, v27 from aggJoin6380036803349877055 join aggView8121893916333748523 using(v23));
create or replace view aggView5065883212033529286 as select v23, v24 from aggJoin8821178211843608780 group by v23,v24;
create or replace view aggJoin4298534283298353584 as (
with aggView2210601657355811132 as (select v23, MIN(v18) as v35 from aggJoin3194173041228546666 group by v23)
select v24, v35 from aggView5065883212033529286 join aggView2210601657355811132 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin4298534283298353584;
