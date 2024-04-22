create or replace view aggJoin5506253806173486762 as (
with aggView4082605903811067064 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView4082605903811067064 where t.kind_id=aggView4082605903811067064.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin3271012432577184766 as (
with aggView21887339943953965 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView21887339943953965 where mi_idx.info_type_id=aggView21887339943953965.v3 and info>'6.0');
create or replace view aggJoin8052801837024276133 as (
with aggView7827300725422209645 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView7827300725422209645 where mi.info_type_id=aggView7827300725422209645.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin7260253184391819586 as (
with aggView5047268831591231039 as (select v23 from aggJoin8052801837024276133 group by v23)
select v23, v18 from aggJoin3271012432577184766 join aggView5047268831591231039 using(v23));
create or replace view aggJoin2291058734974497393 as (
with aggView220324385343881842 as (select v23, MIN(v18) as v35 from aggJoin7260253184391819586 group by v23)
select v23, v24, v27, v35 from aggJoin5506253806173486762 join aggView220324385343881842 using(v23));
create or replace view aggJoin2052726564863715142 as (
with aggView3357958870835887599 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin2291058734974497393 group by v23,v35)
select keyword_id as v5, v35, v36 from movie_keyword as mk, aggView3357958870835887599 where mk.movie_id=aggView3357958870835887599.v23);
create or replace view aggJoin3282559251212025370 as (
with aggView2360535207543922014 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select v35, v36 from aggJoin2052726564863715142 join aggView2360535207543922014 using(v5));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin3282559251212025370;
