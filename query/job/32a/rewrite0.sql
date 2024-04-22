create or replace view aggView9054017459511743767 as select title as v26, id as v11 from title as t2;
create or replace view aggJoin1721236806041609445 as (
with aggView2764275682956656103 as (select id as v8 from keyword as k where keyword= '10,000-mile-club')
select movie_id as v13 from movie_keyword as mk, aggView2764275682956656103 where mk.keyword_id=aggView2764275682956656103.v8);
create or replace view aggJoin3832123779261356399 as (
with aggView506097005657795301 as (select v13 from aggJoin1721236806041609445 group by v13)
select id as v13, title as v14 from title as t1, aggView506097005657795301 where t1.id=aggView506097005657795301.v13);
create or replace view aggView526962472536880544 as select v13, v14 from aggJoin3832123779261356399 group by v13,v14;
create or replace view aggJoin3113339737592520528 as (
with aggView7957623977030035457 as (select v11, MIN(v26) as v39 from aggView9054017459511743767 group by v11)
select movie_id as v13, link_type_id as v4, v39 from movie_link as ml, aggView7957623977030035457 where ml.linked_movie_id=aggView7957623977030035457.v11);
create or replace view aggJoin8190970490429249578 as (
with aggView5104385110202697006 as (select id as v4, link as v37 from link_type as lt)
select v13, v39, v37 from aggJoin3113339737592520528 join aggView5104385110202697006 using(v4));
create or replace view aggJoin7656290605896091815 as (
with aggView2442601021701282375 as (select v13, MIN(v39) as v39, MIN(v37) as v37 from aggJoin8190970490429249578 group by v13,v39,v37)
select v14, v39, v37 from aggView526962472536880544 join aggView2442601021701282375 using(v13));
select MIN(v37) as v37,MIN(v14) as v38,MIN(v39) as v39 from aggJoin7656290605896091815;
