create or replace view aggView7832862836928944452 as select title as v26, id as v11 from title as t2;
create or replace view aggView4765860401634907631 as select id as v13, title as v14 from title as t1;
create or replace view aggJoin8360097829035319245 as (
with aggView1132831495257387462 as (select v11, MIN(v26) as v39 from aggView7832862836928944452 group by v11)
select movie_id as v13, link_type_id as v4, v39 from movie_link as ml, aggView1132831495257387462 where ml.linked_movie_id=aggView1132831495257387462.v11);
create or replace view aggJoin2599453412952448759 as (
with aggView5909111136831190263 as (select id as v4, link as v37 from link_type as lt)
select v13, v39, v37 from aggJoin8360097829035319245 join aggView5909111136831190263 using(v4));
create or replace view aggJoin460412135824293509 as (
with aggView6264124078982962365 as (select id as v8 from keyword as k where keyword= '10,000-mile-club')
select movie_id as v13 from movie_keyword as mk, aggView6264124078982962365 where mk.keyword_id=aggView6264124078982962365.v8);
create or replace view aggJoin1411265620270882581 as (
with aggView1206068268158870420 as (select v13 from aggJoin460412135824293509 group by v13)
select v13, v39 as v39, v37 as v37 from aggJoin2599453412952448759 join aggView1206068268158870420 using(v13));
create or replace view aggJoin6037741511384863956 as (
with aggView3957295101814308615 as (select v13, MIN(v39) as v39, MIN(v37) as v37 from aggJoin1411265620270882581 group by v13,v39,v37)
select v14, v39, v37 from aggView4765860401634907631 join aggView3957295101814308615 using(v13));
select MIN(v37) as v37,MIN(v14) as v38,MIN(v39) as v39 from aggJoin6037741511384863956;
