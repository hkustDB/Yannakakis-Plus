create or replace view aggJoin5890072323058807276 as (
with aggView8923596113328990588 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView8923596113328990588 where t.kind_id=aggView8923596113328990588.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggView3169836871756245906 as select v23, v24 from aggJoin5890072323058807276 group by v23,v24;
create or replace view aggJoin5872154697221128001 as (
with aggView5024882591518090210 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView5024882591518090210 where mi_idx.info_type_id=aggView5024882591518090210.v3);
create or replace view aggJoin3107984809571588502 as (
with aggView1145011371907501688 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView1145011371907501688 where mk.keyword_id=aggView1145011371907501688.v5);
create or replace view aggJoin460972578427532406 as (
with aggView4658775607020303520 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView4658775607020303520 where mi.info_type_id=aggView4658775607020303520.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin7310304536655261839 as (
with aggView4534506580751524772 as (select v23 from aggJoin3107984809571588502 group by v23)
select v23, v13 from aggJoin460972578427532406 join aggView4534506580751524772 using(v23));
create or replace view aggJoin2080068510721108953 as (
with aggView595045124304580702 as (select v23 from aggJoin7310304536655261839 group by v23)
select v23, v18 from aggJoin5872154697221128001 join aggView595045124304580702 using(v23));
create or replace view aggJoin5555031416408857998 as (
with aggView8600951053070865776 as (select v23, v18 from aggJoin2080068510721108953 group by v23,v18)
select v23, v18 from aggView8600951053070865776 where v18>'6.0');
create or replace view aggJoin2942226153432629728 as (
with aggView5529570968137490034 as (select v23, MIN(v24) as v36 from aggView3169836871756245906 group by v23)
select v18, v36 from aggJoin5555031416408857998 join aggView5529570968137490034 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin2942226153432629728;
