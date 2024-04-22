create or replace view aggJoin6418112032708237087 as (
with aggView8340329191979398186 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView8340329191979398186 where mc.company_id=aggView8340329191979398186.v13);
create or replace view aggJoin1767256340062398762 as (
with aggView837582293038649974 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView837582293038649974 where mi.info_type_id=aggView837582293038649974.v22 and note LIKE '%internet%');
create or replace view aggJoin8938288313077673054 as (
with aggView3256864638440280857 as (select v40 from aggJoin1767256340062398762 group by v40)
select movie_id as v40, title as v3 from aka_title as aka_t, aggView3256864638440280857 where aka_t.movie_id=aggView3256864638440280857.v40);
create or replace view aggJoin4001287497144455948 as (
with aggView5827444828256298215 as (select v40, MIN(v3) as v52 from aggJoin8938288313077673054 group by v40)
select id as v40, title as v41, production_year as v44, v52 from title as t, aggView5827444828256298215 where t.id=aggView5827444828256298215.v40 and production_year>1990);
create or replace view aggJoin2046281700854598921 as (
with aggView658019295930875213 as (select id as v20 from company_type as ct)
select v40 from aggJoin6418112032708237087 join aggView658019295930875213 using(v20));
create or replace view aggJoin9180760312840789422 as (
with aggView5612200220727092578 as (select v40 from aggJoin2046281700854598921 group by v40)
select v40, v41, v44, v52 as v52 from aggJoin4001287497144455948 join aggView5612200220727092578 using(v40));
create or replace view aggJoin9100916525862692473 as (
with aggView8698359240365278758 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin9180760312840789422 group by v40,v52)
select keyword_id as v24, v52, v53 from movie_keyword as mk, aggView8698359240365278758 where mk.movie_id=aggView8698359240365278758.v40);
create or replace view aggJoin2371635139308677930 as (
with aggView6815438490603265913 as (select id as v24 from keyword as k)
select v52, v53 from aggJoin9100916525862692473 join aggView6815438490603265913 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin2371635139308677930;
