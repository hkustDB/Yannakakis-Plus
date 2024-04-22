create or replace view aggView8865987996534609561 as select id as v13, title as v14 from title as t1;
create or replace view aggView8776527369048056146 as select id as v11, title as v26 from title as t2;
create or replace view aggJoin8302635499784151282 as (
with aggView8526499578437186383 as (select v13, MIN(v14) as v38 from aggView8865987996534609561 group by v13)
select movie_id as v13, linked_movie_id as v11, link_type_id as v4, v38 from movie_link as ml, aggView8526499578437186383 where ml.movie_id=aggView8526499578437186383.v13);
create or replace view aggJoin2419017085520066844 as (
with aggView8665789288538631230 as (select id as v4, link as v37 from link_type as lt)
select v13, v11, v38, v37 from aggJoin8302635499784151282 join aggView8665789288538631230 using(v4));
create or replace view aggJoin22029076634148376 as (
with aggView6387304831506808519 as (select id as v8 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v13 from movie_keyword as mk, aggView6387304831506808519 where mk.keyword_id=aggView6387304831506808519.v8);
create or replace view aggJoin8916403268936351465 as (
with aggView9078579483660367586 as (select v13 from aggJoin22029076634148376 group by v13)
select v11, v38 as v38, v37 as v37 from aggJoin2419017085520066844 join aggView9078579483660367586 using(v13));
create or replace view aggJoin969571590079689888 as (
with aggView8363484192018116970 as (select v11, MIN(v38) as v38, MIN(v37) as v37 from aggJoin8916403268936351465 group by v11,v37,v38)
select v26, v38, v37 from aggView8776527369048056146 join aggView8363484192018116970 using(v11));
select MIN(v37) as v37,MIN(v38) as v38,MIN(v26) as v39 from aggJoin969571590079689888;
