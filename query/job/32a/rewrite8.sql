create or replace view aggJoin5603316226420470099 as (
with aggView4979531239474317508 as (select id as v11, title as v39 from title as t2)
select movie_id as v13, link_type_id as v4, v39 from movie_link as ml, aggView4979531239474317508 where ml.linked_movie_id=aggView4979531239474317508.v11);
create or replace view aggJoin46480037869277394 as (
with aggView4290255217330239358 as (select id as v4, link as v37 from link_type as lt)
select v13, v39, v37 from aggJoin5603316226420470099 join aggView4290255217330239358 using(v4));
create or replace view aggJoin6564960892811088299 as (
with aggView4583665613860656738 as (select id as v13, title as v38 from title as t1)
select movie_id as v13, keyword_id as v8, v38 from movie_keyword as mk, aggView4583665613860656738 where mk.movie_id=aggView4583665613860656738.v13);
create or replace view aggJoin5464491207978949208 as (
with aggView386261731216400788 as (select v13, MIN(v39) as v39, MIN(v37) as v37 from aggJoin46480037869277394 group by v13,v39,v37)
select v8, v38 as v38, v39, v37 from aggJoin6564960892811088299 join aggView386261731216400788 using(v13));
create or replace view aggJoin5624800922193723817 as (
with aggView1072049371574265007 as (select id as v8 from keyword as k where keyword= '10,000-mile-club')
select v38, v39, v37 from aggJoin5464491207978949208 join aggView1072049371574265007 using(v8));
select MIN(v37) as v37,MIN(v38) as v38,MIN(v39) as v39 from aggJoin5624800922193723817;
