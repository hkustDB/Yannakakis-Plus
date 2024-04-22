create or replace view aggView4181903511772848826 as select id as v14, title as v15 from title as t where production_year>1990;
create or replace view aggJoin7183794004992651424 as (
with aggView8531386461174439356 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8531386461174439356 where mi_idx.info_type_id=aggView8531386461174439356.v1 and info>'2.0');
create or replace view aggJoin7979599787559648093 as (
with aggView3442308185638624145 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView3442308185638624145 where mk.keyword_id=aggView3442308185638624145.v3);
create or replace view aggJoin1301165139678903809 as (
with aggView8490231088301453066 as (select v14 from aggJoin7979599787559648093 group by v14)
select v14, v9 from aggJoin7183794004992651424 join aggView8490231088301453066 using(v14));
create or replace view aggView7535338498079569282 as select v9, v14 from aggJoin1301165139678903809 group by v9,v14;
create or replace view aggJoin254324100620563303 as (
with aggView7833576338373957627 as (select v14, MIN(v9) as v26 from aggView7535338498079569282 group by v14)
select v15, v26 from aggView4181903511772848826 join aggView7833576338373957627 using(v14));
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin254324100620563303;
