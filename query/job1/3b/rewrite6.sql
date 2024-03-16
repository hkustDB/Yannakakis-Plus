create or replace view aggView9124448617036255806 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin2306034176731599258 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView9124448617036255806 where mk.movie_id=aggView9124448617036255806.v12;
create or replace view aggView5671885135357512606 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1471989927253843657 as select v12 from aggJoin2306034176731599258 join aggView5671885135357512606 using(v1);
create or replace view aggView7891816816588410557 as select v12 from aggJoin1471989927253843657 group by v12;
create or replace view aggJoin5208670497611538651 as select title as v13 from title as t, aggView7891816816588410557 where t.id=aggView7891816816588410557.v12 and production_year>2010;
create or replace view res as select MIN(v13) as v24 from aggJoin5208670497611538651;
select sum(v24) from res;