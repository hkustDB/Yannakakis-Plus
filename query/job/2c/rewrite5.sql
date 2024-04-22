create or replace view aggJoin4084840272135238761 as (
with aggView6262448264020564306 as (select id as v12, title as v31 from title as t)
select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView6262448264020564306 where mk.movie_id=aggView6262448264020564306.v12);
create or replace view aggJoin5553311218423075955 as (
with aggView8700732377241137824 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select v12, v31 from aggJoin4084840272135238761 join aggView8700732377241137824 using(v18));
create or replace view aggJoin8235790685306914780 as (
with aggView5953488717304624612 as (select id as v1 from company_name as cn where country_code= '[sm]')
select movie_id as v12 from movie_companies as mc, aggView5953488717304624612 where mc.company_id=aggView5953488717304624612.v1);
create or replace view aggJoin8083386702775666233 as (
with aggView7599640606757257731 as (select v12 from aggJoin8235790685306914780 group by v12)
select v31 as v31 from aggJoin5553311218423075955 join aggView7599640606757257731 using(v12));
select MIN(v31) as v31 from aggJoin8083386702775666233;
