create or replace view aggJoin1249644037141481134 as (
with aggView3698289462095260870 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView3698289462095260870 where t.kind_id=aggView3698289462095260870.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin8012194537447532534 as (
with aggView4581951494040824040 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView4581951494040824040 where mi_idx.info_type_id=aggView4581951494040824040.v3 and info>'6.0');
create or replace view aggJoin2903132733682922669 as (
with aggView6093558217192322004 as (select v23, MIN(v18) as v35 from aggJoin8012194537447532534 group by v23)
select v23, v24, v27, v35 from aggJoin1249644037141481134 join aggView6093558217192322004 using(v23));
create or replace view aggJoin8166044792057155869 as (
with aggView6982610208353745255 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin2903132733682922669 group by v23,v35)
select movie_id as v23, keyword_id as v5, v35, v36 from movie_keyword as mk, aggView6982610208353745255 where mk.movie_id=aggView6982610208353745255.v23);
create or replace view aggJoin1892267253923186196 as (
with aggView4620771343429041150 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView4620771343429041150 where mi.info_type_id=aggView4620771343429041150.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin2180347904173260077 as (
with aggView8096263348095617568 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select v23, v35, v36 from aggJoin8166044792057155869 join aggView8096263348095617568 using(v5));
create or replace view aggJoin617094912117220931 as (
with aggView5770021738466027137 as (select v23 from aggJoin1892267253923186196 group by v23)
select v35 as v35, v36 as v36 from aggJoin2180347904173260077 join aggView5770021738466027137 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin617094912117220931;
